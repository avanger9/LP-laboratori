#!/usr/bin/python3
from jutge import read

def fact(x):
	if x == 0:
		return 1
	else:
		return x * fact(x-1)

def factRF(x):
	'''Funció que calcula x! utilitzant recursivitat final
           Si Python la optimitzés el cost en espai d'aquest codi equivaldria al de la versió recursiva (Θ(1) enlloc de Θ(n))
	'''
	def factRF(x,acumulat=1):
		if x==0: return acumulat
		return factRF(x-1,acumulat*x)
	return factRF(x,1)

def absValue(x):
	if x < 0:
		x = -x
	return x

def power(x,p):
	if p == 0:
		return 1
	pt = power(x, p//2)
	if p%2 == 0:
		return pt*pt
	return pt*pt*x

def isPrime(x):
	if x < 2:
		return False
	i = 2
	while i*i <= x:
		if x%i == 0:
			return False
		i += 1
	return True

def slowFib(n):
	if n == 0 or n == 1:
		return n
	else:
		return slowFib(n-1) + slowFib(n-2)

def quickFib(n):
	a, b = 0, 1
	for i in range(n):
		a, b = a+b, a
	return a

"""
def fact3(n):
	f = 1
	for i in range(2, n+1):
"""

"""
def main():
	x = read(int)
	print (quickFib(x))

main()
"""
