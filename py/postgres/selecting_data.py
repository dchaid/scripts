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

cur.execute("SELECT ID, NAME, EMAIL, TICKETS FROM Employee")

rows = cur.fetchall()

print(" ")
print("****************")
print("Beginning Output")
print("****************")
print(" ")

for data in rows:
    print("ID: " + str(data[0]))
    print("Name: " + data[1])
    print("Email: " + data[2])
    print ("Ticket(s): " + str(data[3]))
    print(" ")

print(" ")
print("**************************")
print("Data Selected Successfully")
print("**************************")
conn.close()


sys.exit()


