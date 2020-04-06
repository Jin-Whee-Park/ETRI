from keras.models import load_model, model_from_json
from keras.preprocessing import image
import numpy as np
import os, glob, os.path
import time
def removeAllfile(filePath):
    fileList = glob.glob(os.path.join(filePath, "*.jpg"))
    for f in fileList:
        os.remove(f)

def Predict():
    json_file=open("model.json","r")
    model_json =  json_file.read()
    json_file.close()
    model = model_from_json(model_json)
    model.load_weights("model.h5")
    
    model.compile(loss='binary_crossentropy',
            optimizer='rmsprop',
            metrics=['accuracy'])
    ctotal=0
    dtotal=0
    img_width , img_height= 224, 224
    images = []
    img_dir = ('/app/data/classify/videos')
    for img in os.listdir(img_dir):
        img = os.path.join(img_dir, img)
        img = image.load_img(img, target_size=(img_width, img_height))
        img = image.img_to_array(img)
        img = np.expand_dims(img, axis=0)
        images.append(img)
        predicts = model.predict(img)
        if predicts == [0]:
            ctotal = ctotal + 1
        else:
            dtotal = dtotal + 1
        time.sleep(1)
    removeAllfile(img_dir)
    return ctotal, dtotal
#print("DOG: ",dtotal, "CAT: ",ctotal)
