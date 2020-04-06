#import urllib.request
from flask import Flask, request, jsonify
#import sys
import os
#import logging 
from predict import Predict
#logging.getLogger('tensorflow').disabled = True
#logging.disable(logging.WARNING)
#os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"



app = Flask(__name__)

@app.route("/")
def index():
    
    cat , dog = Predict()
    if cat == 0 and dog == 0:

        return 'Nodata'
    if cat > dog:
        result = {"result" : 'Cat'}
        return jsonify(result)
    elif cat < dog:
        result = {"result" : 'Dog'}
        return jsonify(result)


if __name__ == "__main__":
    app.run(host = "0.0.0.0", port=5000, debug=False)
