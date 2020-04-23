import numpy as np

class NeuralNetwork(object):
  def __init__(self, layers):
      W = []
      for i in xrange(len(layers) - 1):
        m, n = layers[i], layers[i+1]
        # Consider more meaningful and reasonable initializations
        W.append(np.random.rand(m, n+1))
    
      self.W = W
      
  def activate(self, x, name="sigmoid"):
      act = {"sigmoid" : lambda x: ,}
      
      
  def forward(self, x):
      x = np.append(1, x)
      for w in W:
        x = self.activate(np.dot(w, x))
      
      return x
    
  def backward(self):
      pass
      
