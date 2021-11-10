print("Hello World")
if((1,2,3,4,9) < (1,3,4,5)):
    print("true")
else: 
    print("false")

L1=[1,2,3] #mutable
L2=[L1,L1,L1]
L2[1][1]=99
print(L2)

s={1,2,3}
t={1}
print(s - t)
t.add(42)
s.remove(1)
print(s,t)
o={} # keno leksiko
o=set()
for x in range(20):
    o.add(x)
print("o is :",o)
x=int(input())
while 10 < x:
    x=x+1
    x=int(input())
else :
    print(x)
    break

y=input().split
print(y)