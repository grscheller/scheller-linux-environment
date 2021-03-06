#!/usr/bin/env python
"""Commands taken verbatim from chap. 2 of 
   Deep Learning with Python by François Chollet."""

### Import the MNIST Handwritten Digit Dataset

from keras.datasets import mnist 

(train_images, train_labels), (test_images, test_labels) = mnist.load_data()

# Training Data:
print('\ntrain_images.shape =', train_images.shape)
print('len(train_labels) =', len(train_labels))
print('train_labels =', train_labels)

# Test Data:
print('\ntest_images.shape =', test_images.shape)
print('len(test_labels) =', len(test_labels))
print('test_labels =', test_labels)

### Build the network

from keras import models
from keras import layers

print('\nBuild the network.')
network = models.Sequential()
network.add(layers.Dense(512, activation='relu', input_shape=(28 * 28,)))
network.add(layers.Dense(10, activation='softmax'))

# Add loss function
print('Add loss function.')
network.compile(optimizer='rmsprop',
                loss='categorical_crossentropy',
                metrics=['accuracy'])

### Reshape/format data to match network.

print('Reshape/format data to match network.')
train_images = train_images.reshape((60000, 28 * 28))
train_images = train_images.astype('float32') / 255
test_images = test_images.reshape((10000, 28 * 28))
test_images = test_images.astype('float32') / 255

### Categorically encode the labels.

from keras.utils import to_categorical

print('Categorically encode the labels.')
train_labels = to_categorical(train_labels)
test_labels = to_categorical(test_labels)

### Train the network.

print('\nTrain the network:')
network.fit(train_images, train_labels, epochs=5, batch_size=128)

### Run network with training data.

print('\nRun network with test data:')
test_loss, test_acc = network.evaluate(test_images, test_labels)
print('test_acc:', test_acc)

