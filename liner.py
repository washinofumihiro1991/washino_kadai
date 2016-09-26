import numpy as np
from matplotlib import pyplot as plt


data = np.genfromtxt("dataset.txt", delimiter=',')
# data = np.loadtxt("dataset.txt", delimiter=',')
# print(data)
x = data[:, 0]
y = np.array(data[:, 1])

print(x)
print(y)

z = np.polyfit(x, y, 1)
p = np.poly1d(z)
print(p.c)

plt.hold(True)
plt.scatter(x, y)
# plt.show()


# 求めた単回帰のデータを3～10間で1刻みで生成
ax = np.arange(0, 10, 1)
ay = p(ax)
# 単回帰のデータをプロット
plt.plot(ax, ay)
# 描画・表示
plt.show()



