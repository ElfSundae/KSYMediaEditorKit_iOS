
import re
import os
import httplib
import random
import json
import hashlib
import hmac
import base64
import urllib
import time
import os
import sys
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import SocketServer
import requests
import json
import pprint
from aws_auth import AWSRequestsAuth
from urlparse import urlparse, parse_qs
from aksk import *



RTC_REQUEST_PATH = "/Auth"

def gen_response(pkg):
    auth = AWSRequestsAuth(aws_access_key=AK, 
	    aws_secret_access_key=SK,
	    aws_host='ksvs.cn-beijing-6.api.ksyun.com',
	    aws_region='cn-beijing-6',
	    aws_service='ksvs')
    print(pkg)
    return auth.get_auth('https://ksvs.cn-beijing-6.api.ksyun.com?Action=KSDKAuth&Version=2017-04-01&Pkg=' + pkg)



class AuthServerRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
	qs = parse_qs(urlparse(self.path).query)
	pkg = qs['Pkg'][0]
	if urlparse(self.path).path != RTC_REQUEST_PATH:
	    print "request url error"
	    rsp = { 'Data': {'RetCode' : 1, 
		     'RetMsg' : 'other error'}}

	    rsp_data = json.dumps(rsp)

	    self.send_response(200)
	    self.send_header('Content-Type','application/json')
	    self.send_header('Content-Length',len(rsp_data))
	    self.end_headers()
	    self.wfile.write(rsp_data)
	    return
	try:
	    response = gen_response(pkg)

	    response['RetCode'] =0
	    response['RetMsg'] = 'success'
	    rsp = {'Data' : response}

	    rsp_data = json.dumps(rsp)

	    self.send_response(200)
	    self.send_header('Content-Type','application/json')
	    self.send_header('Content-Length',len(rsp_data))
	    self.end_headers()
	    self.wfile.write(rsp_data)
	    return
	except Exception,e:
	    print(e)
	    self.send_error(503, 'server internal error')

class AuthServer (SocketServer.ThreadingMixIn, HTTPServer):
    pass

def main(port):
    print "serving HTTP on port %s " %(port)

    httpd = AuthServer(("",port), AuthServerRequestHandler)
    print('http server is running...')
    httpd.serve_forever()

if __name__ == '__main__':
    print "usage: python server.py [port]"
    port = 8123
    if len(sys.argv) == 2:
	port = int(sys.argv[1])

    main(port)
