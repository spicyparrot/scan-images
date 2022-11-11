import os
from datetime import datetime
from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

@app.route('/', methods = ['GET','POST'])
@cross_origin()
def default():
    now = datetime.now()
    message = 'Hello from my new demo app! It is ' + str(now)
    return jsonify(message)

@app.route('/heartbeat', methods = ['GET','POST'])
@cross_origin()
def heartbeat():
    now = datetime.now()
    message = 'I am alive! It is ' + str(now)
    return jsonify(message)

@app.route('/api/<name>', methods = ['GET','POST'])
@cross_origin()
def api(name):
    now = datetime.now()
    hello_dict = {'en': 'Hello', 'es': 'Hola', 'fr': 'Salut'}
    langinput = request.args.get('lang')
    message = 'Hello from App 1! It is ' + str(now) + ' thanks for trying our api - ' + str(name)
    #message = hello_dict[langinput] + ' from App 1! It is ' + str(now)  + " thanks for trying " + name
    resdict = {"status": 200 , "body": message}
    return jsonify(resdict)

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)