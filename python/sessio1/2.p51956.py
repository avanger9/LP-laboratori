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

import math

def isPrime(x):
	if x<=1:
		return False
	if x<=3:
		return True
	if x%2==0:
		return False
	for i in range(3, int(math.sqrt(x))+1, 2):
		if x%i==0:
			return False
	return True

def primeDivisors(n):
	divisors = [ d for d in range(2,n//2+1) if n%d==0 ]
	prime_divisors = [ d for d in divisors if isPrime(d) ]
	if isPrime(n):
		prime_divisors.append(n)
	return prime_divisors

#print(primeDivisors(255))
#print(remove([1,4,5,3,4,5,1,2,7,4,2], [2,4]))
#print(remove([1,2,3,4,5],[2,4]))