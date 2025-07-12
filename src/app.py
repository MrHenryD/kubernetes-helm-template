from flask import Flask, jsonify

import settings


app = Flask(__name__)

@app.route("/")
def home():
    return jsonify(
        {"message": "Welcome to the API!"}
    ), 200

@app.route("/healthcheck")
def healthcheck():
    return jsonify(
        {"status": "healthy"}
    ), 200

@app.route("/version")
def version():
    return jsonify(
        {"version": settings.VERSION}
    ), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)