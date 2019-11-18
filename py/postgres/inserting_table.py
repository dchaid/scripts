#!/usr/bin/python3

import psycopg2
import sys

DB_NAME = "dzuklhfd"
DB_USER = "dzuklhfd"
DB_PASS = "JJNOoEcdb7W5UdJ1H0PCHEX8IR9xTP9P"
DB_HOST = "hansken.db.elephantsql.com"
DB_PORT = 5432


conn = psycopg2.connect(database = DB_NAME, user = DB_USER,
            password = DB_PASS, host = DB_HOST, port = DB_PORT)

print("Database connected.")

cur = conn.cursor()
cur.execute("""

CREATE TABLE Employee
(
ID INT PRIMARY KEY NOT NULL,
NAME TEXT NOT NULL,
EMAIL TEXT NOT NULL,
TICKETS INT NOT NULL
)
""")

conn.commit()
print("Table Created.")

sys.exit()


