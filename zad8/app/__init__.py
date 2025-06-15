from flask import Flask

app = Flask(__name__)
app.secret_key = "tajny_klucz"

from app import routes
