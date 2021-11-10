def fib(a,b):
    
    yield a
    while True:
        yield b
        c = a + b
        a, b = b, c
        print("a is ", a)
        print("b is ", b)

for j, x in enumerate(fib(0,1)):
    if j>0:
        print(x)
    if j>9:
        break
type((fib(0,1)))