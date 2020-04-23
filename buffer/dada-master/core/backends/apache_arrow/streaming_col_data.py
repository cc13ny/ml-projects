# Reference: http://wesmckinney.com/blog/arrow-streaming-columnar/

import time
import numpy as np
import pandas as pd
import pyarrow as pa

def generate_data(total_size, ncols):
    nrows = int(total_size / ncols / np.dtype('float64').itemsize)
    return pd.DataFrame({
        'c' + str(i): np.random.randn(nrows)
        for i in range(ncols)
    })

#          c0        c1
# 0 -1.027724 -1.355950
# 1 -0.703654 -0.759856
# 2 -0.114206  0.073758
# 3  0.477138 -0.063724

# 1 << 10 --> 1024: 1 Kilobyte
KILOBYTE = 1 << 10
MEGABYTE = KILOBYTE * KILOBYTE
DATA_SIZE = 1024 * MEGABYTE
NCOLS = 16


df = generate_data(MEGABYTE, NCOLS)

# df --> batch
batch = pa.RecordBatch.from_pandas(df)

# Write batches in RAM
sink = pa.InMemoryOutputStream()
stream_writer = pa.StreamWriter(sink, batch.schema)

for i in range(DATA_SIZE // MEGABYTE):
    stream_writer.write_batch(batch)

# Info
source = sink.get_result()
source.size

# Read back Arrow record batches in memory
reader = pa.StreamReader(source)
table = reader.read_all()

table

# Convert Arrow Table to DF
df = table.to_pandas()
df.memory_usage().sum()

# --------------------------------------- #
# 1. How fast is it?
# 2. How does the stream chunk size affect the absolute performance to obtain
#       the ABSOLUTE PERFORMANCE to obtain the pandas DataFrame?

# As the streaming chunksize grows smaller, the cost to reconstruct
# a contiguous columnar pandas DataFrame increases because of cache-inefficient memory access patterns
# There's also some overhead from manipulating the C++ container data structures around the arrays and their memory buffers

# Summary: Smaller Chunksize, Worser Performance
# ToDo: try this --> %timeit pa.StreamReader(source).read_all().to_pandas()
import timeit
timeit.timeit('pa.StreamReader(source).read_all().to_pandas()', number=10)
# 10 loops, best of 3: 129 ms per loop
# 1/0.129 = 7.7519379845 GB/s

# "This is an effective throughput of 7.75 GB/s to reconstruct a 1GB DataFrame from 1024 1MB chunks.
#   The performance degrades significantly from 256K to 64K chunks.
#   I was surprised to see that 1MB chunks were faster than 16MB ones;
#   it would be worth a more thorough investigation to understand
#   whether that is normal variance or something else going on."

# ToDo: Good to think and do some experiments/ dive for the comment above

# ToDo: plot the performance figure 'Streaming data throughput by chunksize'
# ToDo: -- the following is the complete example code with plots of different chunksize
# Benchmarking Code

import time
import numpy as np
import pandas as pd
import pyarrow as pa

def generate_data(total_size, ncols):
    nrows = total_size / ncols / np.dtype('float64').itemsize
    return pd.DataFrame({
        'c' + str(i): np.random.randn(nrows)
        for i in range(ncols)
    })

KILOBYTE = 1 << 10
MEGABYTE = KILOBYTE * KILOBYTE
DATA_SIZE = 1024 * MEGABYTE
NCOLS = 16

def get_timing(f, niter):
    start = time.clock_gettime(time.CLOCK_REALTIME)
    for i in range(niter):
        f()
    return (time.clock_gettime(time.CLOCK_REALTIME) - start) / NITER

def read_as_dataframe(klass, source):
    reader = klass(source)
    table = reader.read_all()
    return table.to_pandas()

NITER = 5 # number of iterations to evaluate the performance
results = []

CHUNKSIZES = [16 * KILOBYTE, 64 * KILOBYTE, 256 * KILOBYTE, MEGABYTE, 16 * MEGABYTE]

for chunksize in CHUNKSIZES:
    nchunks = DATA_SIZE // chunksize
    batch = pa.RecordBatch.from_pandas(generate_data(chunksize, NCOLS))

    sink = pa.InMemoryOutputStream()
    stream_writer = pa.StreamWriter(sink, batch.schema)

    for i in range(nchunks):
        stream_writer.write_batch(batch)

    source = sink.get_result()

    elapsed = get_timing(lambda: read_as_dataframe(pa.StreamReader, source), NITER)

    result = (chunksize, elapsed)
    print(result)
    results.append(result)