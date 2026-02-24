
Assigment 2.2
Write a program that uses input to prompt a user for their name and then welcomes them. 
Note that input will pop up a dialog box. 
Enter Sarah in the pop-up box when you are prompted so your output will match the desired output.

name = input("Enter your name")
print("Hello", name)

--

Assigment 2.3
Write a program to prompt the user for hours and rate per hour using input to compute gross pay. 
Use 35 hours and a rate of 2.75 per hour to test the program (the pay should be 96.25). 
You should use input to read a string and float() to convert the string to a number. 
Do not worry about error checking or bad user data.

hrs = input('Enter Hours:')
rate = input('Enter Rate:')
ihrs = int(hrs)
frate = float(rate)
print ('Pay:', ihrs * frate)

--

Assigment 3.1
Write a program to prompt the user for hours and rate per hour using input to compute gross pay. 
Pay the hourly rate for the hours up to 40 and 1.5 times the hourly rate for all hours worked above 40 hours. 
Use 45 hours and a rate of 10.50 per hour to test the program (the pay should be 498.75). 
You should use input to read a string and float() to convert the string to a number. 
Do not worry about error checking the user input - assume the user types numbers properly.

hrs = input("Enter Hours:")
rate = input('Enter Rate:')
ihrs = int(hrs)
frate = float(rate)

if ihrs > 40:
    pay = 40 * frate + (ihrs - 40) * 1.5 * frate
else: pay = ihrs * frate
    
print (pay)

--

Assigment 3.3
Write a program to prompt for a score between 0.0 and 1.0. 
If the score is out of range, print an error. 
If the score is between 0.0 and 1.0, print a grade using the following table:
Score Grade
>= 0.9 A
>= 0.8 B
>= 0.7 C
>= 0.6 D
< 0.6 F
If the user enters a value out of range, print a suitable error message and exit. For the test, enter a score of 0.85.

str_score = input("Enter Score: ")
try:
    score = float(str_score)
except:
    print ('error')
    quit()
    
if score >= 0.9:
    print ('A')
elif score >= 0.8:
    print ('B')
elif score >= 0.7:
    print ('C')
elif score >= 0.6:
    print ('D')
else:
    print ('F')
    
--

Assigment 4.6

Write a program to prompt the user for hours and rate per hour using input to compute gross pay. 
Pay should be the normal rate for hours up to 40 and time-and-a-half for the hourly rate for all hours worked above 40 hours. 
Put the logic to do the computation of pay in a function called computepay() and use the function to do the computation. 
The function should return a value. Use 45 hours and a rate of 10.50 per hour to test the program (the pay should be 498.75). 
You should use input to read a string and float() to convert the string to a number. 
Do not worry about error checking the user input unless you want to - you can assume the user types numbers properly. 
Do not name your variable sum or use the sum() function.

def computepay(hrs, rate):
    if hrs > 40:
        return 40 * rate + (hrs - 40) * 1.5 * rate
    else: 
        return hrs * rate
    
s_hrs = input('Enter Hours:')
s_rate = input('Enter Rate:')
hrs = int(s_hrs)
rate = float(s_rate)

print("Pay", computepay(hrs, rate))

--

Assigment 5.2
    
Write a program that repeatedly prompts a user for integer numbers until the user enters 'done'. 
Once 'done' is entered, print out the largest and smallest of the numbers. 
If the user enters anything other than a valid number catch it with a try/except and put out an appropriate message and ignore the number. 
Enter 7, 2, bob, 10, and 4

largest = None
smallest = None
while True:
    str_num = input("Enter a number: ")
    if str_num == "done":
        break
    try:
        num = int(str_num)
    except:
        print('Invalid input')
        continue
    if largest is None:
        largest = num
    elif num > largest:
        largest = num
    elif smallest is None:
        smallest = num
    elif num < smallest:
        smallest = num
print("Maximum is", largest)
print("Minimum is", smallest)














