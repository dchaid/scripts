#!/usr/bin/python3
import psycopg2

def getMobileDetails(mobileID):
    try: 
        connection = psycopg2.connect("dbname='davidchaid' user='davidchaid' host='localhost'")

        print("Using Python variable in PostgreSQL select Query")
        cursor = connection.cursor()
        postgreSQL_select_Query = "select * from rfpidb where id = %s" % (number)

        cursor.execute(postgreSQL_select_Query, (mobileID,))
        mobile_records = cursor.fetchall()
        for row in mobile_records:
            print("Id = ", row[0], )
            print("First_Name = ", row[1])
            print("Last_Name  = ", row[2])

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        # closing database connection
        if (connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed \n")

print("Swipe Badge...\n")
number = input()
getMobileDetails(number)
