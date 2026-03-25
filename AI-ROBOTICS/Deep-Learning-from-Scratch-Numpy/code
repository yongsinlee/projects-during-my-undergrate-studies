import sys
import os
import numpy as np
import gzip
import pickle
import urllib.request
from collections import OrderedDict

# ================================================================= #
# 1. Layers Implementation (노드 구현)
# ================================================================= #

class AddLayer:
    def __init__(self):
        pass

    def forward(self, x, y):
        out = x + y
        return out

    def backward(self, dout):
        dx = dout * 1
        dy = dout * 1
        return dx, dy

class MulLayer:
    def __init__(self):
        self.x = None
        self.y = None

    def forward(self, x, y):
        self.x = x
        self.y = y
        out = x * y
        return out

    def backward(self, dout):
        dx = dout * self.y
        dy = dout * self.x
        return dx, dy

class Relu:
    def __init__(self):
        self.mask = None

    def forward(self, x):
        self.mask = (x <= 0)
        out = x.copy()
        out[self.mask] = 0
        return out

    def backward(self, dout):
        dout[self.mask] = 0
        dx = dout
        return dx

class Sigmoid:
    def __init__(self):
        self.out = None

    def forward(self, x):
        out = 1 / (1 + np.exp(-x))
        self.out = out
        return out

    def backward(self, dout):
        dx = dout * self.out * (1.0 - self.out)
        return dx

class Affine:
    def __init__(self, W, b):
        self.W = W
        self.b = b
        self.x = None
        self.dW = None
        self.db = None

    def forward(self, x):
        self.x = x
        out = np.dot(self.x, self.W) + self.b
        return out

    def backward(self, dout):
        dx = np.dot(dout, self.W.T)
        self.dW = np.dot(self.x.T, dout)
        self.db = np.sum(dout, axis=0)
        return dx

class SoftmaxWithLoss:
    def __init__(self):
        self.loss = None
        self.y = None
        self.t = None

    def softmax(self, a):
        if a.ndim == 2:
            a = a.T
            a = a - np.max(a, axis=0)
            y = np.exp(a) / np.sum(np.exp(a), axis=0)
            return y.T
        a = a - np.max(a)
        return np.exp(a) / np.sum(np.exp(a))

    def cross_entropy_error(self, y, t):
        if y.ndim == 1:
            t = t.reshape(1, t.size)
            y = y.reshape(1, y.size)
        if t.size == y.size:
            t = t.argmax(axis=1)
        batch_size = y.shape[0]
        return -np.sum(np.log(y[np.arange(batch_size), t] + 1e-7)) / batch_size

    def forward(self, x, t):
        self.t = t
        self.y = self.softmax(x)
        self.loss = self.cross_entropy_error(self.y, self.t)
        return self.loss

    def backward(self, dout=1):
        batch_size = self.t.shape[0]
        if self.t.size == self.y.size:
            dx = (self.y - self.t) / batch_size
        else:
            dx = self.y.copy()
            dx[np.arange(batch_size), self.t] -= 1
            dx = dx / batch_size
        return dx

# ================================================================= #
# 2. Network Implementation (신경망 구성)
# ================================================================= #

class TwoLayerNet:
    def __init__(self, input_size, hidden_size, output_size, weight_init_std=0.01):
        self.params = {}
        self.params['W1'] = weight_init_std * np.random.randn(input_size, hidden_size)
        self.params['b1'] = np.zeros(hidden_size)
        self.params['W2'] = weight_init_std * np.random.randn(hidden_size, output_size)
        self.params['b2'] = np.zeros(output_size)

        self.layer = OrderedDict()
        self.layer['Affine1'] = Affine(self.params['W1'], self.params['b1'])
        self.layer['ReLU'] = Relu()
        self.layer['Affine2'] = Affine(self.params['W2'], self.params['b2'])
        self.lastLayer = SoftmaxWithLoss()

    def predict(self, x):
        for layer in self.layer.values():
            x = layer.forward(x)
        return x

    def loss(self, x, t):
        y = self.predict(x)
        return self.lastLayer.forward(y, t)

    def accuracy(self, x, t):
        y = self.predict(x)
        y = np.argmax(y, axis=1)
        if t.ndim != 1: t = np.argmax(t, axis=1)
        accuracy = np.sum(y == t) / float(x.shape[0])
        return accuracy

    def gradient(self, x, t):
        self.loss(x, t)
        dout = 1
        dout = self.lastLayer.backward(dout)
        layers = list(self.layer.values())
        layers.reverse()
        for layer in layers:
            dout = layer.backward(dout)

        grads = {}
        grads['W1'] = self.layer['Affine1'].dW
        grads['b1'] = self.layer['Affine1'].db
        grads['W2'] = self.layer['Affine2'].dW
        grads['b2'] = self.layer['Affine2'].db
        return grads

# ================================================================= #
# 3. Dataset Handling (데이터셋 로드)
# ================================================================= #

url_base = 'https://ossci-datasets.s3.amazonaws.com/mnist/'
key_file = {
    'train_img':'train-images-idx3-ubyte.gz',
    'train_label':'train-labels-idx1-ubyte.gz',
    'test_img':'t10k-images-idx3-ubyte.gz',
    'test_label':'t10k-labels-idx1-ubyte.gz'
}
dataset_dir = './'
save_file = dataset_dir + "/mnist.pkl"

def download_mnist():
    for file_name in key_file.values():
        file_path = dataset_dir + "/" + file_name
        if os.path.exists(file_path): continue
        headers = {"User-Agent": "Mozilla/5.0"}
        request = urllib.request.Request(url_base + file_name, headers=headers)
        response = urllib.request.urlopen(request).read()
        with open(file_path, mode='wb') as f: f.write(response)

def load_mnist(normalize=True, flatten=True, one_hot_label=False):
    if not os.path.exists(save_file):
        download_mnist()
        dataset = {}
        for key, name in key_file.items():
            path = dataset_dir + "/" + name
            with gzip.open(path, 'rb') as f:
                if 'img' in key:
                    data = np.frombuffer(f.read(), np.uint8, offset=16).reshape(-1, 784)
                else:
                    data = np.frombuffer(f.read(), np.uint8, offset=8)
            dataset[key] = data
        with open(save_file, 'wb') as f: pickle.dump(dataset, f, -1)

    with open(save_file, 'rb') as f: dataset = pickle.load(f)
    if normalize:
        for key in ('train_img', 'test_img'): dataset[key] = dataset[key].astype(np.float32) / 255.0
    if one_hot_label:
        for key in ('train_label', 'test_label'):
            T = np.zeros((dataset[key].size, 10))
            for idx, row in enumerate(T): row[dataset[key][idx]] = 1
            dataset[key] = T
    return (dataset['train_img'], dataset['train_label']), (dataset['test_img'], dataset['test_label'])

# ================================================================= #
# 4. Training Loop (학습 실행)
# ================================================================= #

if __name__ == '__main__':
    (x_train, t_train), (x_test, t_test) = load_mnist(normalize=True, one_hot_label=True)
    network = TwoLayerNet(input_size=784, hidden_size=50, output_size=10)

    iters_num = 10000
    train_size = x_train.shape[0]
    batch_size = 100
    learning_rate = 0.1

    iter_per_epoch = max(train_size / batch_size, 1)

    for i in range(iters_num):
        batch_idx = np.random.choice(train_size, batch_size)
        x_batch = x_train[batch_idx]
        t_batch = t_train[batch_idx]

        grad = network.gradient(x_batch, t_batch)

        for key in ('W1', 'b1', 'W2', 'b2'):
            network.params[key] -= learning_rate * grad[key]

        if i % iter_per_epoch == 0:
            train_acc = network.accuracy(x_train, t_train)
            test_acc = network.accuracy(x_test, t_test)
            print(f"Iter {i} | Train Acc: {train_acc:.4f}, Test Acc: {test_acc:.4f}")
