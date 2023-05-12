import matplotlib.pyplot as plt
import numpy as np

matrixSize = [1000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 50000]
results = []

filenameC_normal = "tempo_normal"
filenameC_trocado = "tempo_trocado"
filenameFortran_normal = "tempo_normal_fortran"
filenameFortran_trocado = "tempo_trocado_fortran"

with open(filenameC_normal, "r") as file:
    lines = file.readlines()
    results.append([float(x.strip()) for x in lines])

with open(filenameC_trocado, "r") as file:
    lines = file.readlines()
    results.append([float(x.strip()) for x in lines])

with open(filenameFortran_normal, "r") as file:
    lines = file.readlines()
    results.append([float(x.strip()) for x in lines])

with open(filenameFortran_trocado, "r") as file:
    lines = file.readlines()
    results.append([float(x.strip()) for x in lines])

plt.figure(figsize=(12, 8))
plt.plot(matrixSize, results[0], 'o-', label='C - line/column')
plt.plot(matrixSize, results[1], 'o-', label='C - column/line')
plt.plot(matrixSize, results[2], 'o-', label='Fortran - line/column')
plt.plot(matrixSize, results[3], 'o-', label='Fortran - column/line')
plt.xticks(matrixSize)
plt.tick_params('x', labelsize = 6)

plt.xlabel('Matrix Size')
plt.ylabel('Time (s)')
plt.title('Runtime of Matrix Multiplication: A * X = B', weight = 'bold')
plt.legend()
plt.savefig("img/result.png")
# plt.show()