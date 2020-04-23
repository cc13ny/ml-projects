# Python 3.6.0

import MySQLdb
from sqlalchemy import create_engine

engine = create_engine('mysql+mysqldb://username:password@localhost/database')
table_name = 'table_name'
dataframe.to_sql(table_name, con=engine, if_exists='replace')
