README

n = number of pigeons, m = number of holes 

This program is written in C. To compile and run the source code, enter the command: "make run". 

Then, input the number of pigeons and holes. The program will then write the output into the "output files" folder and the standard output. The name of the .txt files inside the "output files" are determined by its input n and m.

A short explanation about the code:
For every pigeon i and hole k, we have a variable num = m*(i-1)+k, which means that pigeon i is living in hole k. After the problem line, we have n clauses which has the meaning of a pigeon has to live in some hole. Then, for each hole, we have a set of clauses to ensure that only a pigeon is living in that particular hole.
