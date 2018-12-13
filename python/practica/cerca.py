#!/usr/bin/python3

import urllib.request
import xml.etree.ElementTree as ET

def main():
	sock = urllib.request.urlopen("https://wservice.viabicing.cat/v1/getstations.php?v=1") 
	xmlSource = sock.read()                            
	sock.close()
	root = ET.fromstring(xmlSource)
	#print(root[2].text)	

main()