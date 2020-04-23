# By Pandas

'''
  Reference: http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_json.html
  - columns-oriented:   '{"col 1":{"row 1":"a","row 2":"b"},"col 2":{"row 1":"c","row 2":"d"}}'
  - index-oriented:     '{"row 1":{"col 1":"a","col 2":"c"},"row 2":{"col 1":"b","col 2":"d"}}'
'''

import pandas as pd

dat_by_col = pd.read_json('train.json', orient='columns') 
dat_by_idx = pd.read_json('train.json', orient='index')


# By Itself

'''
  Reference: http://stackoverflow.com/questions/20199126/reading-json-from-a-file
'''

import json

with open('train.json') as json_data:
    dat = json.load(json_data)
