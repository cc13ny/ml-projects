'''
    input:
        1. trans_p[i, j] = p(x_i | x_j), sum_j (p(x_i | x_j)) = 1

    Concrete:

        1. Number of States: could be noun, verb, etc

    Inference:

        1. p(x_t | x_t-1)  &  p(y_t | x_t) [transition probability & estimation distribution]
        2. p(y_n | y_n-1, y_n-2, ... , y_1)
        3. p(x_n | y_n-1, y_n-2, ... , y_1) [forward algorithm]

    Application:

        1. cipher decoding
        2. summary (try yourself)

'''



import numpy as np


'''
    Example:

        start_p = {'Healthy': 0.6, 'Fever': 0.4}

        trans_p = {'Healthy': {'Healthy': 0.7, 'Fever': 0.3},
                   'Fever': {'Healthy': 0.4, 'Fever': 0.6}}

        emit_p = {'Healthy': {'normal': 0.5, 'cold': 0.4, 'dizzy': 0.1},
                  'Fever': {'normal': 0.1, 'cold': 0.3, 'dizzy': 0.6}}

'''


class HMM:
    def __init__(self, start_p, trans_p, emit_p):
        # ToDo: data format normalization like dataframe or nosql (https://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_json.html)

        self.start_p = start_p
        self.trans_p = trans_p
        self.emit_p = emit_p

    def generate(self, L):
        outputs = []
        gp = self.start_p
        ep = self.emit_p

        for i in range(L):
            idx = self._emit(gp)
            outputs.append(idx)
            gp = ep[:, idx]

        return outputs

    ## Inference
    # https://en.wikipedia.org/wiki/Forward_algorithm
    def forward(self, seqs):
        # tentative: seqs is a series of idx of symbols
        tp = self.trans_p
        ep = self.emit_p
        gp = np.multiply(ep[:, seqs[0]], self.start_p)

        for i in seqs[1:]:
            gp = np.multiply(ep[:, i], tp.dot(gp))

        return gp

    # https://en.wikipedia.org/wiki/Viterbi_algorithm
    def viterbi(self, seqs):
        tp = self.trans_p
        ep = self.emit_p
        n = self.start_p.size

        # initialize
        vp = np.multiply(ep[:, seqs[0]], self.start_p)
        paths = np.zeros((n, seqs.size - 1))

        # forward
        for j in range(1, seqs.size):
            t = seqs[j]
            vm = np.outer(np.ones((n,)), vp)
            tpm = np.multiply(tp, vm)
            tvp = tpm.max(1)
            vp = np.multiply(ep[:, t], tvp)

            paths[:, -j] = tpm.argmax(1)

        # backward
        i = np.argmax(vp)
        viterbi_path = [i] # tentative: idx of symbols
        for j in range(seqs.size - 1):
            i = paths[i, j]
            viterbi_path.append(i)

        return viterbi_path[::-1]

    # ToDo: maybe improved to log(n) by [1, 2, 4, ...] or other tricks
    def _emit(self, emit_p):
        selected_p = np.random.uniform()
        i = 0
        while selected_p >= 0:
            selected_p -= emit_p[i]
            i += 1

        return i

    # generate = forward
