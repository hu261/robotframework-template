#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""This module contains a library for dealing serial line"""

def serial_send(data):
    """Send data over the serial line"""
    
    try:
        print "sending", data
        return "Ok"
    except:
        return "Error"
    
def serial_receive():
    """Receive data over the serial line"""
    
    return "123456"

def serial_configure(bauds, parity):
    """Configure the serial line"""

    print "configured serial line."
