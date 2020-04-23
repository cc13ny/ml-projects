# CUDA-Learning-Note

## Objective

__Performance Optimization Techniques__

#  Note

2.	Hyperthread, out-order, multi-instruction
3.	Multi-threaded, in-order, single-instruction
4.	DRAM & RAM
5.	Texture Lookup
6.	Frame buffer
a)	https://en.wikipedia.org/wiki/Framebuffer
b)	A framebuffer (sometimes framestore) is a portion of RAM containing a bitmap that is driven to a video display from a memory buffer containing a complete frame of data.
i.	memory buffer: a region of a physical memory storage used to temporarily store data while it is being moved from one place to another
ii.	bitmap: a mapping from some domain (e.g. a range of integers) to bits
7.	Relaxed memory model
8.	Memory bandwidth for CPU
9.	GPU
a)	Minimizing the control logic required for each execution thread
i.	Take advantage of a large number of execution threads
b)	Small cache memories
i.	Access the same memory, not need to all go to the DRAM
10.	Differences between CPU and GPU
a)	Deep Learning differences btw CPU and GPU
11.	Single precision and double precision
12.	CUDA programs no longer go through the graphics interface at all??
13.	Virtual instruction set
14.	Parallel computational elements
15.	Compute kernels
16.	Direct3D & OpenGL different from CUDA
17.	CUDA supports programming framework such as OpenACC and OpenCL
18.	Compiler directives such as OpenACC
19.	how do CUDA focus on numerically intensive application
20.	Where to use GPU. This design is more effective than general-purpose CPUs for algorithms in situations where processing of large blocks of data is done in parallel, such as:
a)	push-relabel maximum flow algorithm
b)	fast sort algorithms of large lists
c)	two-dimensional fast wavelet transform
d)	molecular dynamics simulations
21.	Nvcc – LLVM (low level virtual machine)-based
22.	
23.	 
24.	C++ AMP
25.	GPU
a)	Graphics rendering
b)	Game physics calculations
26.	CUDA
a)	Low-level api
b)	High-level api
27.	Nvidia GPUs from the G8x series onwards
a)	GeForce, Quadro, Tesla
28.	Due to binary compatibility (wiki: CUDA)
29.	[Pros] CUDA over GPGPU
a)	Scattered reads: code can read from arbitrary address in memory
b)	?? Unified virtual memory (CUDA 4.0 and above)
c)	Unified memory (CUDA 6.0 and above)
d)	[Why] Faster downloads and readbacks to and from the GPU
e)	[Any special?] Full support for integer and bitwise operations, including integer texture lookups.
f)	Shared memory – CUDA exposes a fast shared memory region that can be shared amongst threads. This can be used as a user-managed cache, enabling higher bandwidth than is possible using texture lookups (???).
30.	[Cons]
a)	Don't support the full C standard as it runs host code through a C++ compiler (make some valid C but invalid C++ code fail to compile)
b)	Unlike OpenCL, CUDA-enabled GPUs are only available from Nvidia.
31.	GPU
a)	Building block
i.	Two (or more) SMs [Highly threaded streaming multiprocessors]
1.	Multiple SPs (streaming processors)
a)	Share control logic and instruction cache
b)	Has a multiply-add (MAD) unit and an additional multiply unit
c)	Multi-threaded
ii.	Global Memory [4 GB of GDDR (graphics double data rate), DRAM]
1.	Differ from the system DRAMs on the CPU motherboard
2.	Frame buffer memory used for graphics
a)	For computing, as very-high-bandwidth, off-chip memory
i.	Though with somewhat more latency than typical system memory.
ii.	For massively parallel applications, the higher bandwidth makes up for the longer latency.
iii.	Communication bandwidth is much lower than the memory bandwidth and may seem like a limitation
3.	However, the PCI Express bandwidth is comparable to the CPU front-side bus bandwidth to the system memory, so it is really not the limitation it would seem at first. The communication bandwidth is also expected to grow as the CPU bus bandwidth of the system memory grows in the future. ?????
32.	Data Parallelism
33.	In general, straightforward parallelization of applications often saturates the memory (DRAM) bandwidth, resulting in only about a 10_ speedup. The trick is to figure out how to get around memory bandwidth limitations, which involves doing one of many transformations to utilize specialized GPU on-chip memories to drastically reduce the number of accesses to the DRAM.
34.	Message Passing Interface (MPI) for scalable cluster computing
a)	A model where computing nodes in a cluster don’t share memory.
b)	All data sharing and interaction must be done through explicit message passing.
c)	The amount of effort required to port an application into MPI can be extremely high due to lack of shared memory across computing nodes.
35.	OpenMP for shared-memory multiprocessor systems
a)	Support shared-memory
b)	Not scalable to nodes due to thread management overheads and cache coherence hardware requirements.
36.	CUDA
a)	Provide shared memory for parallel execution in the GPU
b)	Very limited shared memory btw CPU and GPU
c)	Data Transfer btw CPU and GPU similar to “one-sided” message passing, a capability whose absence in MPI has been historically considered as a major weakness of MPI
d)	Much higher scalability than OpenMP with simple, low-overhead thread management and no cache coherence hardware requirements [for shared memory consistency]. However, due to such scalability tradeoffs, CUDA doesn't support applications as many as OpenMP did.
37.	Cache Coherence: https://en.wikipedia.org/wiki/Cache_coherence
