#!/usr/bin/python3

import urllib.request
import xml.etree.ElementTree as ET
import sys
import argparse
import re
import datetime
import math
from ast import literal_eval

class Acte:
    def __init__(self, acte):
        self.bicing_bks = []
        self.bicing_slots = []
        self.ddstance = []
        self.nom = acte.find('nom').text
        self.lloc = acte.find('lloc_simple/nom').text
        self.barri = acte.findtext('lloc_simple/adreca_simple/barri')
        self.data = acte.find('data/data_proper_acte').text
        #self.horaFi = acte.find('data/hora_fi').text
        def get_float(dir, attr):
            try:
                return float(acte.find(dir).attrib[attr])
            except ValueError as err:
                return 0.0
        self.lat = get_float('lloc_simple/adreca_simple/coordenades/googleMaps', 'lat')
        self.lon = get_float('lloc_simple/adreca_simple/coordenades/googleMaps', 'lon')

        self.idd = acte.find('id').text
        self.munici = acte.findtext('lloc_simple/adreca_simple/municipi')
        self.nom_curt = acte.find('nom_curt').text
        self.carrer_as = acte.findtext('lloc_simple/adreca_simple/carrer')
        self.numero = acte.findtext('lloc_simple/adreca_simple/numero')
        self.districte = acte.findtext('lloc_simple/adreca_simple/districte')
        self.codi_postal = acte.findtext('lloc_simple/adreca_simple/codi_postal')

    def evalua_expr(self, expr):
        if isinstance(expr, str):
            res = lambda txt: re.search(expr, txt, re.IGNORECASE)
            return res(self.nom) or res(self.barri) or res(self.lloc)
        elif isinstance(expr, tuple):
            return any(self.evalua_expr(subexpr) for subexpr in expr)
        elif isinstance(expr, list):
            return all(self.evalua_expr(subexpr) for subexpr in expr)
        return False

    def evalua_date(self, date):
        data = datetime.datetime.strptime(self.data, '%d/%m/%Y %H.%M')
        data_min = datetime.datetime.strptime(date + ' 00.00', '%d/%m/%Y %H.%M')
        data_max = datetime.datetime.strptime(date + ' 23.59', '%d/%m/%Y %H.%M')
        return data_min <= data and data <= data_max

    def get_distance(self, bicing):
        rad = math.pi/180.0
        diametreT = 6371000.0

        lat1 = (90.0-self.lat)*rad
        lat2 = (90.0-bicing.lat)*rad
        lon1 = self.lon*rad
        lon2 = bicing.long*rad
        c = math.sin(lat1)*math.sin(lat2)*math.cos(lon1-lon2)+math.cos(lat1)*math.cos(lat2)
        return math.acos(c)*diametreT

    def add_bicing_disp(self, distance, bicing):
        dist = self.get_distance(bicing)
        if dist <= distance:
            #print('la distancia del bicing es', dist)
            self.ddstance.append([dist,bicing])


    def add_bicing_bikes(self, distance, bicing):
        dist = self.get_distance(bicing)
        if dist <= distance:
            self.ddstance.append([dist,bicing])


class Bicing:
    def __init__(self, station):
        self.idd = station.find('id').text
        self.typpe = station.find('type').text
        self.lat = float(station.find('lat').text)
        self.long = float(station.find('long').text)
        self.street = station.find('street').text
        self.height = station.find('height').text
        self.streetNumber = station.find('streetNumber').text
        self.nearbyStationList = station.find('nearbyStationList').text
        self.status = station.find('status').text
        self.slots = station.find('slots').text
        self.bikes = station.find('bikes').text

    def te_slots(self):
        return self.slots != '0'
    def te_bikes(self):
        return self.bikes != '0'
    def es_oberta(self):
        return self.status == 'OPN'

def tracta_xml(url):
    sock = urllib.request.urlopen(url)
    xmlSource = sock.read()
    sock.close()
    root = ET.fromstring(xmlSource)
    return root

def html_bicing(bicing, bll):
    a = '<div style=\'margin-top:16px\'>\n'
    for b in bicing:
        if bll == 0: c = b.slots
        else: c = b.bikes
        a += '<p><b>' + b.idd + ', ' + b.street + ', ' \
        + b.streetNumber + ', ' + c + '</p>\n'
    a += "</div>"
    return a

def html_acte2(acte):
    a = '<h2>' + acte.nom + '</h2>\n'
    a += '<p><em>' + acte.lloc + ', ' + acte.carrer_as + ', ' \
    + acte.numero + ', ' + acte.districte + ', ' + acte.codi_postal + ', ' \
    + acte.munici + ', ' + acte.barri + '</p>\n'
    a += "<p style=\"font-size:12px;color:#444\"><b>" + acte.data + "</b></p>\n"
    a += html_bicing(acte.bicing_slots, 0)
    a += html_bicing(acte.bicing_bks, 1)
    a += '</div>'
    return a

def html_acte(actes):
    a = '<div>'
    for acte in actes:
        a += html_acte2(acte)
    a += '</div>'
    return a

def funcio_html(actes):
    file = open('table.html', 'w')
    file.write("""<!DOCTYPE html>
<html>
    <head>
        <title>Practica de LP - Python</title>
        <meta charset="UTF-8" />
        <style>
            html { font-family: "HelveticaNeue-Light"; font-weight: 300; }
            div { margin-bottom:64px; margin-left:64px; margin-right:64px }
            h1 { font-size:32px; font-weight: bold; color:#444; }
            h2 { font-size:20px; color:#000; }
            p { font-size:16px; margin-top:8px; margin-bottom:8px }
            a { text-decoration: none; }
        </style>
    </head>
    <body>""")
    file.write(html_acte(actes))
    file.write("""
    </bodi>
</html""")


def main():
    arg = sys.argv

    parser = argparse.ArgumentParser(prog = 'cerca.py')
    parser.add_argument("--key")
    parser.add_argument('--date')
    parser.add_argument('--distance', type = int)
    args = parser.parse_args()
    # print(args.date)

    if args.date == None: date = datetime.datetime.today().strftime('%d/%m/20%y')
    else: date = args.date
    #print(date)
    if args.distance == None: distance = 500
    else: distance = args.distance
    #print ('Number of arguments:', len(args), 'arguments.')
    #print ('argument list:', str(args))

    eval = literal_eval(args.key)
    #if isinstance(eval, str): print('es una str')
    #if isinstance(eval, list): print('es una list')
    #if isinstance(eval, tuple): print('es una tuple')


    bicing = tracta_xml('http://wservice.viabicing.cat/v1/getstations.php?v=1')
    esdeveniments = tracta_xml('http://w10.bcn.es/APPS/asiasiacache/peticioXmlAsia?id=199')
    esdeveniments = esdeveniments[1][0][1]

    print(bicing.tag)
    print(esdeveniments.tag)

    bicing_disp = [ a for a in map(Bicing, bicing.iter('station')) if a.es_oberta() if a.te_slots() ]
    bicing_bikes = [ a for a in map(Bicing, bicing.iter('station')) if a.es_oberta() if a.te_bikes() ]
    actes = [ a for a in map(Acte,esdeveniments.iter('acte')) if a.evalua_expr(eval) if a.evalua_date(date) ]
    print('quants actes en total:', len(actes))
    #print('quantes estacions en total:', len(bicis))
    #print(actes[0].data)
    #print(bicis[0].idd)
    #print(actes[1].nom)
    #print(a[0].barri)

    qnt = 0
    for acte in actes:
        for bici in bicing_disp:
            acte.add_bicing_disp(distance, bici)
        sorted(acte.ddstance, key = lambda x:x[0])
        #print(acte.ddstance)
        acte.bicing_slots = [x[1] for x in acte.ddstance]
        acte.bicing_slots = acte.bicing_slots[:5]

    qnt = 0
    for acte in actes:
        acte.ddstance = []
        for bici in bicing_bikes:
            acte.add_bicing_bikes(distance, bici)
        sorted(acte.ddstance, key = lambda x:x[0])
        acte.bicing_bks = [x[1] for x in acte.ddstance]
        acte.bicing_bks = acte.bicing_bks[:5]

    print(len(actes[0].bicing_slots), len(actes[0].bicing_bks))
    funcio_html(actes)

main()
