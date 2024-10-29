import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def upsample(x, N):
    y = np.zeros(N * len(x))
    for i in range(len(x)):
        y[i] = x[i % N]
    return y


t = np.linspace(0, 100, 100)
f = np.linspace(-np.pi, np.pi, 100)
f1 = np.linspace(-np.pi, np.pi, 400)
w1 = np.pi / 6
w2 = np.pi / 4
x = np.sin(w1 * t) + np.cos(w2 * t)
x2 = upsample(x, 4)
x1 = np.fft.fft(x)
x21 = np.fft.fft(x2)
x1a = np.abs(x1)
x2a = np.abs(x21)
plt.plot(f, x1a)
plt.plot(f1, x2a)
plt.show()
