
Assigment 6.5
Write code using find() and string slicing to extract the number at the end of the line below. 
Convert the extracted value to a floating point number and print it out.
text = "X-DSPAM-Confidence:    0.8475"

line = 'X-DSPAM-Confidence:    0.8475'

start = line.find(':')
number = float (line[start + 1:])

print (number)


Assigment 7.1
Write a program that prompts for a file name, then opens that file and reads through the file, 
and print the contents of the file in upper case. 
Use the file words.txt to produce the output below. 
You can download the sample data at http://www.py4e.com/code3/words.txt

fname = input("Enter file name: ")
fh = open(fname)
for text in fh:
    text = text.rstrip()
    print (text.upper())

    
--


Assigment 7.2
Write a program that prompts for a file name, then opens that file and reads through the file, looking for lines of the form

X-DSPAM-Confidence:

Count these lines and extract the floating point values from each of the lines and compute the average of those values 
and produce an output as shown below. Do not use the sum() function or a variable named sum in your solution.

You can download the sample data at http://www.py4e.com/code3/mbox-short.txt 
when you are testing below enter mbox-short.txt as the file name.

count = 0
total = 0
fname = input('Enter file name: ')
fh = open(fname)
for line in fh:
    if not line.startswith('X-DSPAM-Confidence:'):
        continue
    line = line.rstrip()
    start = line.find(':')
    number = float (line[start + 1:])
    count = count + 1
    total = total + number
average = total / count
print('Average spam confidence:', average)


--


Assigment 8.4
Open the file romeo.txt and read it line by line. For each line, split the line into a list of words using the split() method. 
The program should build a list of words. 
For each word on each line check to see if the word is already in the list and if not append it to the list. 
When the program completes, sort and print the resulting words in python sort() order as shown in the desired output.
You can download the sample data at http://www.py4e.com/code3/romeo.txt

fname = input("Enter file name: ")
fh = open(fname)
lst = list() 
for line in fh:
    words = line.split()
    for word in words:
        if word not in lst:
            lst.append(word)
lst.sort()
print(lst)


--


Assigment 8.5
Open the file mbox-short.txt and read it line by line. When you find a line that starts with 'From ' like the following line:
    From stephen.marquard@uct.ac.za Sat Jan  5 09:14:16 2008
You will parse the From line using split() and print out the second word in the line (i.e. the entire address of the person who sent the message). 
Then print out a count at the end.

Hint: make sure not to include the lines that start with 'From:'. Also look at the last line of the sample output to see how to print the count
You can download the sample data at http://www.py4e.com/code3/mbox-short.txt

fname = input('Enter file name: ')
fh = open(fname)
count = 0
for line in fh:
    if line.startswith('From ') :
        email = line.split()
        print (email[1])
        count = count + 1
print('There were', count, 'lines in the file with From as the first word')


--


Assigment 9.4
Write a program to read through the mbox-short.txt and figure out who has sent the greatest number of mail messages. 
The program looks for 'From ' lines and takes the second word of those lines as the person who sent the mail. 
The program creates a Python dictionary that maps the sender's mail address to a count of the number of times they appear in the file. 
After the dictionary is produced, the program reads through the dictionary using a maximum loop to find the most prolific committer.

name = input("Enter file:")
if len(name) < 1:
    name = 'mbox-short.txt'
handle = open(name)
email = dict()
for line in handle :
    if line.startswith('From ') :
        send = line.split()
        sender = send [1]
        email[sender] = email.get(sender, 0) + 1
        
bigword = None
bigcount = None
for word,count in email.items():
    if bigcount is None or count > bigcount:
            bigcount = count
            bigword = word
print (bigword,bigcount)


---


Assigment 10.2
Write a program to read through the mbox-short.txt and figure out the distribution by hour of the day for each of the messages. 
You can pull the hour out from the 'From ' line by finding the time and then splitting the string a second time using a colon.
From stephen.marquard@uct.ac.za Sat Jan  5 09:14:16 2008
Once you have accumulated the counts for each hour, print out the counts, sorted by hour as shown below.



name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"
handle = open(name)
x = dict()
for line in handle :
    if line.startswith('From ') :
        line = line.split()
        waktu = line[5]
        jam = waktu.split(':')
        hour = jam [0]
        x[hour] = x.get(hour, 0) + 1
sort_list =  sorted(x.items())
for a,b in sort_list :
    print (a,b)

































