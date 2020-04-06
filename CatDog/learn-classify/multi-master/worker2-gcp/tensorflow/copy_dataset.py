print("==========================")
print("====loading settings======")
import tensorflow as tf
import os
import shutil

work_dir = '/root/tensorflow/cat_dog/' 
image_names = sorted(os.listdir(os.path.join(work_dir, 'train')))

def copy_files(prefix_str, range_start, range_end, target_dir):
    image_paths = [os.path.join(work_dir, 'train', prefix_str+'.'+str(i)+'.jpg')
                   for i in range(range_start, range_end)]
    dest_dir = os.path.join(work_dir, 'data', target_dir,prefix_str)
    os.makedirs(dest_dir)
    for image_path in image_paths:
        shutil.copy(image_path, dest_dir)



print("==========================")
print("====copy image files======")
#copy_files('dog', 100, , 'train')
#copy_files('cat', 0, 5000, 'train')
copy_files('dog', 100, 120, 'test')
copy_files('cat', 120, 135, 'test')
'''


print("==========================")
print("====define cnn model======")
image_height, image_width = 150, 150
train_dir = os.path.join(work_dir+'data/', 'train')
test_dir = os.path.join(work_dir+'data/', 'test')
no_classes = 2
no_validation = 8 #800
epochs = 4
batch_size = 2 #200
no_train = 20 #2000
no_test = 8 #800
input_shape = (image_height, image_width, 3)
epoch_steps = no_train // batch_size
test_steps = no_test // batch_size

def simple_cnn(input_shape):
    model = tf.keras.models.Sequential()
    model.add(tf.keras.layers.Conv2D(
        filters=75, # 64
        kernel_size=(3,3),
        activation='relu',
        input_shape=input_shape
        ))
    model.add(tf.keras.layers.Conv2D(
        filters=150, # 128
        kernel_size=(3,3),
        activation='relu',
        ))
    model.add(tf.keras.layers.MaxPooling2D(pool_size=(2,2)))
    model.add(tf.keras.layers.Dropout(rate=0.3))

    model.add(tf.keras.layers.Flatten())
    model.add(tf.keras.layers.Dense(units=32, activation='relu')) # 1024
    # tensorflow.python.framework.errors_impl.ResourceExhaustedError: OOM when allocating tensor with shape[799350,1024] and type float on /job:localhost/replica:0/task:0/device:CPU:0 by allocator cpu
    model.add(tf.keras.layers.Dropout(rate=0.3))
    model.add(tf.keras.layers.Dense(units=no_classes, activation='softmax'))
    model.compile(loss=tf.keras.losses.categorical_crossentropy,
                  optimizer=tf.keras.optimizers.Adam(),
                  metrics=['accuracy'])
    return model
simple_cnn_model = simple_cnn(input_shape)

generator_train = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1. /255)
generator_test = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1. / 255)

train_images = generator_train.flow_from_directory(
    train_dir,
    batch_size = batch_size,
    target_size = (image_width, image_height)
    )

test_images = generator_test.flow_from_directory(
    test_dir,
    batch_size = batch_size,
    target_size = (image_width, image_height)
    )

print("==========================")
print("====fitting cnn model=====")
simple_cnn_model.fit_generator(
    train_images,
    steps_per_epoch=epoch_steps,
    epochs=epochs,
    validation_data=test_images,
    validation_steps=test_steps
    )
   
''' 
