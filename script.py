# To findout the Variables and Expressions
message = "Welcome to my first python script"
firstname = "raghupathi"
lastname = " kammari"
age = 23
sex = "male"
city = "hyd"
print message
print firstname+lastname
print age 
print sex
print city

# bult in functions
input = raw_input()
print input

# built in function for getting input from the user
name = raw_input('what is your name?\n')
print name

# mnemonic variable names
a = "raghu"
b = "pathi"
c = a+b
print c

# Boolean Expressins
5 == 5
5 == 6

# Conditional Execution
x = 5
if x > 0 : print 'x is possitive'
y = 0
if y < 5 : print 'y is negatibe'
# Alternative Execution
x = 10
if x % 2 == 0 : print 'x is even'
else : print 'x is odd'
# Chained Conditionals
x = 10
y = 20
if x == y : print 'x and y are equal'
elif x > y : print 'x is greater than y'
else : print 'x is less than y'

# To print Prime numbers from 1 to 11
for num in range(1,11):
    prime = True
    for i in range(2,num):
        if (num%i==0):
            prime = False
    if prime:
       print num

# This Function is to camputation of math values and the arguments provide while function call.
def square(a,b):
    print a*a
    print b*b
    print a+b
square(2,3)
# Function call to raghu and function names with following arguments
def raghu():
    print "Hello World"
raghu()

x = "raghupathi"
y = " kammari"
def f():
    return x + y
print f()

def power(base,exponent):
 result = base ** exponent
 print "%d to the power of %d is %d." % (base,exponent,result)
power(4,2)

# To check whether the even or odd numbers 
def even(x):
    if x % 2 == 0 :
        return "10 is a even number"
    else :
        return "10 is a odd number"
print even(10)
