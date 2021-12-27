from math import log
import numpy as np

file1 = open('log_abac_time.txt', 'r')
Lines = file1.readlines()
lst = []
sum = 0

for row in Lines:
    # print(row)
    if(row.find("real")!=-1):
        curvar = float(row.split("m")[1][:-2])
        print(curvar)
        # sum += curvar
        lst.append(curvar)
    # var+=1

a = np.array(lst)
print(np.average(a, axis=0))
print(np.std(a, axis=0))