from flask import render_template, request, redirect, flash
from app import app

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        message = request.form.get("message")

        if not name or not email or not message:
            flash("Wszystkie pola są wymagane!", "error")
            return redirect("/")
        
        flash("Wiadomość została wysłana!", "success")
        return redirect("/")

    return render_template("index.html")
