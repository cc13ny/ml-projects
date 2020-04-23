import numpy as np
import os

class NaiveBayes(object):
    def __init__(self):
        self.y = [0, 0]
        self.nwords = np.zeros((1, 2))
        self.wordcnts = [{}, {}]}

    def fit(self, dir_path, reset=false):
        if dir_path is None:
            dir_path = self.collect_data()
        
        if reset:
            self.y = [0, 0]
            self.nwords = np.zeros((1, 2))
            self.wordcnts = [{}, {}]}
        
        # [0] -> ham / non-spam, [1] -> spam
        for filename in os.listdir(dir_path):
            filepath = os.path.join(dir_path, filename)
            if os.path.isfile(fp):
                with open(filename, 'r') as f:
                    lbl = int(filename.split(".")[-2][-1])
                    y[lbl] += 1
                    self.preprocess(f, lbl)
        
    def classify(self, filepath):
        assert os.path.isfile(fp)
        
        nw = self.nwords
        p = 1.0 / nw
        
        with open(filepath, 'r') as f:
            words = f.read().replace('\n', '').split()
            for w in words:
                for i in range(2):
                    wc = self.wordcnts[i]
                    p[i] *= (wc[w] + 0.0) / nw[i] if w in wc else 1.0 / nw[i]
        
        return "The probability of the doc as a spam is : " + p[1] / sum(p)
        

    def preprocess(self, f, lbl):
        words = f.read().replace('\n', '').split()
        wc = self.wordcnts[lbl]
        for w in words:
            wc[w] = wc[w] + 1 if w in wc else 1
            self.nwords[lbl] += 1

    def collect_data(self):
        # collect corpus with labels for classification
        pass
