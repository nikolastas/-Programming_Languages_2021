def fib(start_a,start_b):
    a, b = start_a, start_b
    yield a
    while True:
        yield b
        c = a + b
        a, b = b, c
def fib2(n, start_a=0, start_b=1):
    a,b=start_a,start_b
    if n == 0 :return start_a
    c=a+b
    s=0
    
    f=fib2(n-1,b,c)
    yield f
    s=s+(f)
    
for x in enumerate(fib2(10,0,1)):
    print(x) 
#sum=0    
#for i,x in enumerate(fib(0,1)):
#    if i >9000:
#        sum=sum + int(x)
#        if i>10000 :
#            break
#print(sum)