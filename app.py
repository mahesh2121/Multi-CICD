from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to the CI/CD Deployment Example!"

@app.route('/env')
def environment():
    import os
    env = os.getenv("APP_ENV", "Unknown")
    return f"This is the {env} environment."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
