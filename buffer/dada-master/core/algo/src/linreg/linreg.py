#!/usr/bin/python

# ToDo:
#   1. feature scaling
#   2. feature normalization

import numpy as np

class LinearRegression(object):
    
    def __init__(self):
        self.theta = None
        
    def fit(self, X, y, mode="mean", penalty=None, loss_func = "least_square"):
        self.theta = self.grad_descent(X, y)
    
    def grad_descent(self, X, y, theta, alpha=0.3, precise=0.000001):
        # theta: column vector, parameter we want to learn
        # alpha: learning rate
        
        m, n = X.shape[0], X,shape[1]
        
        X = np.concatenate((np.ones((m, 1)), X), axis=1)
        
        theta = np.ones((n, 1))
        pretheta = theta - 1.0
        
        while sum(abs(theta - pretheta)) / m > precise:
            h = np.dot(X, theta)
            
            feedback = np.dot(X.transpose(), np.substract(h - y))
            
            pretheta = theta
            theta = np.substract(theta, alpha * feedback / m)
        
        return theta
