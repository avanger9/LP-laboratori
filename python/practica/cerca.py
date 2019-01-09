#!/usr/bin/python3

import urllib.request
import xml.etree.ElementTree as ET
import sys
import argparse
import re
import datetime
import math
from ast import literal_eval

isday = False # per indicar si utilitzem el diari mensual

class Acte:
    def __init__(self, acte):
        self.bicing_bks = []
        self.bicing_slots = []
        self.ddstance = []
        self.nom = acte.find('nom').text
        self.lloc = acte.find('lloc_simple/nom').text
        self.data = acte.find('data/data_proper_acte').text
        #self.horaFi = acte.find('data/hora_fi').text
        def get_float(dir, attr):
            try:
                return float(acte.find(dir).attrib[attr])
            except ValueError as err:
                return 0.0

        global isday
        if isday:
            coord = 'lloc_simple/adreca_simple/coordenades/googleMaps'
            self.lat = get_float(coord, 'lat')
            self.lon = get_float(coord, 'lon')
            self.barri = acte.findtext('lloc_simple/adreca_simple/barri')
        else:
            self.data_inici = acte.find('data/data_inici').text
            self.data_fi = acte.find('data/data_fi').text

        lloc = 'lloc_simple/adreca_simple'
        self.munici = acte.findtext(lloc + '/municipi')
        self.carrer_as = acte.findtext(lloc + '/carrer')
        self.numero = acte.findtext(lloc + '/numero')
        self.districte = acte.findtext(lloc + '/districte')
        self.codi_postal = acte.findtext(lloc + '/codi_postal')

    def evalua_expr(self, expr):
        global isday
        if isinstance(expr, str):
            res = lambda txt: re.search(expr, txt, re.IGNORECASE)
            if isday: return res(self.nom) or res(self.lloc)
            else: return res(self.nom) or res(self.lloc) or res(self.barri)
        elif isinstance(expr, tuple):
            return any(self.evalua_expr(subexpr) for subexpr in expr)
        elif isinstance(expr, list):
            return all(self.evalua_expr(subexpr) for subexpr in expr)
        return False

    def evalua_date(self, date):
        data = datetime.datetime.strptime(self.data, '%d/%m/%Y')
        data_min = datetime.datetime.strptime(self.data_inici, '%d/%m/%Y')
        data_max = datetime.datetime.strptime(self.data_fi, '%d/%m/%Y')
        return data_min <= data and data <= data_max

    def get_distance(self, bicing):
        rad = math.pi/180.0
        diametreT = 6371000.0

        lat1 = (90.0-self.lat)*rad
        lat2 = (90.0-bicing.lat)*rad
        lon1 = self.lon*rad
        lon2 = bicing.long*rad
        c = math.sin(lat1)*math.sin(lat2)*math.cos(lon1-lon2) \
        + math.cos(lat1)*math.cos(lat2)
        return math.acos(c)*diametreT

    def add_bicing_disp(self, distance, bicing):
        dist = self.get_distance(bicing)
        if dist <= distance:
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

def html_bicing(bicing, tipus):
    a = '<div style=\'margin-top:16px\'>'
    if not tipus:
        a += '<p><b><h3>' + 'Estacions del bicing amb llocs disponibles:' \
        + '</h3></b></p>'
    else:
        a += '<h3><p><b>' + 'Estacions del bicing amb bicis disponibles:' \
        + '</h3></b></p>'
    for b in bicing:
        a += '<p><b>' + 'id del bicing: '     + '</b>' + b.idd + '</p>'
        a += '<p><b>' + 'carrer del bicing: ' \
        + '</b>' + b.street + '</p>'
        a += '<p><b>' + 'numero del carrer: ' \
        + '</b>' + str(b.streetNumber) + '</p>'
        if not tipus:
            a += '<p><b>' + 'llocs disponibles: ' + '</b>' + b.slots + '</p>'
        else:
            a += '<p><b>' + 'bicis disponibles: ' + '</b>' + b.bikes + '</p>'
        a += '</br>'
    a += "</div>"
    return a

def html_acte2(acte):
    global isday
    a = '<h1>' + acte.nom + '</h1>'
    a += '<p><em>' + acte.lloc + ', ' + acte.carrer_as + ', ' \
    + acte.numero + ', ' + acte.districte + ', ' + acte.codi_postal + ', ' \
    + acte.munici + '</p>'
    a += '<p style="font-size:12px;color:#444"><b>' + acte.data + "</b></p>"
    if isday:
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
            h1 { font-size:40px; font-weight: bold; color:#444; }
            p { font-size:16px; margin-top:8px; margin-bottom:8px }
        </style>
    </head>
    <body>""")
    file.write(html_acte(actes))
    file.write("""
    </bodi>
</html""")


def main():
    parser = argparse.ArgumentParser(prog = 'cerca.py')
    parser.add_argument("--key", required = True)
    parser.add_argument('--date')
    parser.add_argument('--distance', type = int)
    args = parser.parse_args()

    global isday
    if args.date == None:
        date = datetime.datetime.today().strftime('%d/%m/%Y')
        if args.distance == None: distance = 500
        else: distance = args.distance
        isday = True
    else: # data fixada, sense bicings
        date = args.date
        isday = False

    eval = literal_eval(args.key)

    bicing = tracta_xml('http://wservice.viabicing.cat/v1/getstations.php?v=1')
    if isday:
        esdeveniments = tracta_xml\
        ('http://w10.bcn.es/APPS/asiasiacache/peticioXmlAsia?id=199')
    else:
        esdeveniments = tracta_xml\
        ('http://w10.bcn.es/APPS/asiasiacache/peticioXmlAsia?id=103')
    esdeveniments = esdeveniments[1][0][1]

    bicing_disp = [ a for a in map(Bicing, bicing.iter('station')) \
                    if a.es_oberta() if a.te_slots() ]
    bicing_bikes = [ a for a in map(Bicing, bicing.iter('station')) \
                    if a.es_oberta() if a.te_bikes() ]
    actes = []
    for acte in map(Acte, esdeveniments.iter('acte')):
        if acte.evalua_expr(eval):
            if not isday:
                if acte.evalua_date(date):
                    actes.append(acte)
            else: actes.append(acte)

    if isday == True:
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

    funcio_html(actes)

main()
