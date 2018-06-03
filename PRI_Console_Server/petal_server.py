#!/usr/bin/env python
from flask import Flask, request
app = Flask(__name__)

import sys, re, json, os
from datetime import datetime
import inspect

tcpPort = 80

log_file_name = "/var/log/petal_server.log"
log_file_enable = True
print_log_entries = True


def write_log(entry):
    # Takes text of log entry
    if log_file_enable == False:
        return

    try:
        log_file = open(log_file_name, "a")
    except:
        print("BAD  - Unable to open file for append:   {0}\n".format(log_file_name))
        sys.exit()

    logEntry = "{0} - Function: {2} - {1}".format(datetime.now(), entry, inspect.stack()[1][3])
    log_file.write(logEntry)
    log_file.close()

    if print_log_entries == True:
        print ("Log Entry: {}".format(logEntry))

@app.route('/addr', methods=["POST"])
def addr():

    if request.method == "POST":
        ipAddress = request.form['addrline']
        apiKey = request.form['apikey']

    data = "Post received with IP Address: {0} and API Key: {1}\n".format(ipAddress, apiKey)

    write_log(data)
    return (data)

if __name__ == '__main__':
	app.config.update(
		DEBUG = True)

	app.run(host='0.0.0.0', port=tcpPort)
