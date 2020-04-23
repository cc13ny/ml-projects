from . import hmm

'''
    Example 1 from: https://en.wikipedia.org/wiki/Viterbi_algorithm
'''

# data

# states = ['Healthy', 'Fever']
# obs = ['normal', 'cold', 'dizzy']
#
# start_p = [0.6, 0.4]
#
# trans_p = [[0.7, 0.3],
#            [0.4, 0.6]]
#
# emit_p = [[0.5, 0.4, 0.1],
#           [0.1, 0.3, 0.6]]


start_p = {'Healthy': 0.6, 'Fever': 0.4}

trans_p = {'Healthy': {'Healthy': 0.7, 'Fever': 0.3},
           'Fever': {'Healthy': 0.4, 'Fever': 0.6}}

emit_p = {'Healthy': {'normal': 0.5, 'cold': 0.4, 'dizzy': 0.1},
          'Fever': {'normal': 0.1, 'cold': 0.3, 'dizzy': 0.6}}