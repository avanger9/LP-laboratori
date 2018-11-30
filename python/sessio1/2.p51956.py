#!/usr/bin/python3
from collections import Iterable

def myLength(L):
	lgth = 0
	for i in L:
		lgth += 1
	return lgth

def myLength2(L):
	return len(L)

def myMaximum(L):
	mxx = L[0]
	for i in L:
		if i > mxx:
			mxx = i
	return mxx

def myMaximum2(L):
	return max(L)

def average(L):
	suma = 0
	for i in L:
		suma += i
	return (suma/myLength(L))

def buildPalindrome(L):
	return L[::-1]+L

def buildPalindrome2(L):
	return list(reversed(L))+L

def remove(L1, L2):
	L1 = [n for n in L1 if n not in L2]
	return L1

def flatten(L):
	return list(flatten_lst(L))

def flatten_lst(L):
	for i in L:
		if isinstance(i,Iterable) and not isinstance(i, (str,bytes)):
			yield from flatten_lst(i)
		else:
			yield i

def flatten2(L):
	return sum(L,[])

def oddsNevens(L):
	Lodds = []
	Levens = []
	for i in L:
		if i%2!=0:
			Lodds.append(i)
		else:
			Levens.append(i)
	return Lodds,Levens

def primeDivisors(n):
	l = []
	i = 2
	while i*i < n:
		if n%i:
			i += 1
		else:
			l.append(i)
			n //= i
	if n>1:
		l.append(n)
	return l

#print(primeDivisors(255))
#print(remove([1,4,5,3,4,5,1,2,7,4,2], [2,4]))
#print(remove([1,2,3,4,5],[2,4]))