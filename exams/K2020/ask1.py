def f(a):
    a=list(a)
    s=sum(a)
    return [x/s for x in a]


def foo(x,y):
    print(y+2*x)
foo('na','ba')