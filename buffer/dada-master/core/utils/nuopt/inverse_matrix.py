'''Calculate the inverse of a matrix by different methods

Reference:
- The Inverse of a Matrix (NYU Class: Linear Algebra)
  http://www.math.nyu.edu/~neylon/linalgfall04/project1/jja/group7.htm

- Wiki: Invertible Matrix
  https://en.wikipedia.org/wiki/Invertible_matrix

'''

import numpy as np

def inv_mat(A, method='gauss_jordan_elim'):
    assert len(A) > 0
    assert len(A) == len(A[0])
    
    methods = {'gauss_jordan_elim': gauss_jordan_elim,
               'newton': newton}
    return methods[method](A)

def gauss_jordan_elim(A, touch_up=False):
    '''
    @param
        -- touch_up : boolean, optional(default=False)
        
               whether to "touch up" corrections for the Gauss-Jordan algorithm
               which has been contaminated by small errors due to imperfect
               computer arithmetic
                     
        
    Reference:
    - Wiki: Gaussian Elimination
      https://en.wikipedia.org/wiki/Gaussian_elimination
    '''
    n = len(A)
    I = np.eye(n)
    Aug = np.append(A, I, axis=1)
    
    for j in xrange(n):
        if not Aug[j][j]:
            msg = "It's invertible!!!"
            raise ZeroDivisionError(msg)
        
        for i in xrange(n):
            if i == j:
                continue
            Aug[i] -= Aug[j] * Aug[i][j] / Aug[j][j]
        Aug[j] /= Aug[j][j]

    B = Aug[:, n:]
    return newton(A, B) if touch_up else B

def newton(A, X=None):
    '''
    @param
        -- X : array-like or None (default=None)
            a starting seed / guess for the inversion of matrix A
    
    Description:
      1/(ax_n+1) = [1/(ax_n) + 1/(2-aX_n)] / 2 ==>

                        x_n+1 = x_n(2 - ax_n)
      The 1st equation aims at leading ax_n+1 to be 1
    
    Reference:
    - Choosing Starting Values for Newton-Raphson Computation of
      Reciprocals, Square-Roots and Square-Root Reciprocals
      https://hal.archives-ouvertes.fr/inria-00071899/document
    '''
    #ToDo
    
