#!/usr/bin/python3

import threading
import queue
import sys
from datetime import datetime

def console(q):
    while 1:
        cmd = input('> ')
        q.put(cmd)
        if cmd == 'quit':
            break

LOG = open('logs.csv', 'a+')

TIME = datetime.now().strftime("%m/%d/%y") + ', ' + datetime.now().strftime("%I:%M:%S %p") + ', '

def action_2807():
    print("\r" + datetime.now().strftime("%m/%d/%y") + ', ' + datetime.now().strftime("%I:%M:%S %p") + ', ' + 'David Chaid') 
    print(("\r" + datetime.now().strftime("%m/%d/%y") + ', ' + datetime.now().strftime("%I:%M:%S %p") + ', ' + 'David Chaid'), file = LOG)
    

def action_2808():
    print("\r" + datetime.now().strftime("%m/%d/%y") + ', ' + datetime.now().strftime("%I:%M:%S %p") + ', ' + 'Bruce Rollins')
    print(("\r" + datetime.now().strftime("%m/%d/%y") + ', ' + datetime.now().strftime("%I:%M:%S %p") + ', ' + 'Bruce Rollins'), file = LOG)

def invalid_input():
    print('---> Unknown User...')

def main():
    cmd_actions = {'2807': action_2807, '2808': action_2808}
    cmd_queue = queue.Queue()

    dj = threading.Thread(target=console, args=(cmd_queue,))
    dj.start()

    while 1:
        cmd = cmd_queue.get()
        if cmd == 'quit':
            print(("\r"), file = LOG)
            break
        elif cmd == 'q':
            break
        action = cmd_actions.get(cmd, invalid_input)
        action()

main()
