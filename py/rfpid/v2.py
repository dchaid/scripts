#!/usr/bin/python3
import psycopg2
import threading
import queue
import sys
import csv
from datetime import datetime

LOG = open('logs.tsv', 'a+')
TIME = datetime.now().strftime("%m/%d/%y") + " " +datetime.now().strftime("%I:%M:%S %p")

def console(q):
    while 1:
        cmd = input('> ')
        q.put(cmd)
        if cmd == 'quit':
            break
        
def getUser(userID):
    try: 
        connection = psycopg2.connect("dbname='rfpidb' user='davidchaid' host='localhost'")
        cursor = connection.cursor()
        postgreSQL_select_Query = "select * from rfpidb where id = %s" % (number)
        cursor.execute(postgreSQL_select_Query, (userID,))
        mobile_records = cursor.fetchall()
        for row in mobile_records:
            LOG
            print("\n")
            print("")
            print(TIME)
            print("First Name:  ", row[1])
            print("Last Name:   ", row[2])
            print("Email:       ", row[3])
            print("Gender:      ", row[4])
            print("Country:     ", row[5])
            print(TIME + '\t' + row[1] + '\t' + row[2] + '\t' + '\t' + row[4] + '\t' + row[5], file = LOG)

    finally:
        if (connection):
            cursor.close()
            connection.close()
            print("")

while True:            
    print("")
    print("Swipe badge to create ticket...")
    print("\n")
    number = input()
    if number.isdigit() and 1 <= int(number) <= 1001:
        print("\nTicket Created...\n")
    elif number.isalpha():
        print ("\nYou did not enter a valid number.\n")
        number = 0
    elif number == "":
        print ("\nYou did not enter a valid number.\n")
        number = 0
    else:
        print("\nBadge not recognized...\n")
        
    getUser(number)
