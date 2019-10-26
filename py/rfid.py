#!/usr/bin/python3

import csv
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

LOG = open('logs.tsv', 'a+')

def action_2807():
    LOG = open('logs.tsv', 'a+')
    TIME = datetime.now().strftime("%m/%d/%y") + '\t' + datetime.now().strftime("%I:%M:%S %p") + '\t'
    print(TIME + 'USER X') 
    print((TIME + 'USER X'), file = LOG)
    LOG.close()
    LOG

def action_2808():
    LOG = open('logs.tsv', 'a+')
    TIME = datetime.now().strftime("%m/%d/%y") + '\t' + datetime.now().strftime("%I:%M:%S %p") + '\t'
    print(TIME + 'USER Y')
    print((TIME + 'USER Y'), file = LOG)
    LOG.close()
    LOG

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
            break
        action = cmd_actions.get(cmd, invalid_input)
        action()

main()

