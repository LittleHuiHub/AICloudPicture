from flask import Flask, render_template, request
import openai
import os
import replicate

# os.environ["REPLICATE_API_TOKEN"]="r8_1nEw5DdiKU76XQ3m3dfgbD9w9FmGj0r04DZiR"
os.environ["REPLICATE_API_TOKEN"]="787f515cb0624813736c11e7fefec66473394f02"
m=replicate.models.get("tstramer/midjourney-diffusion")
version=m.versions.get("436b051ebd8f68d23e83d22de5e198e0995357afef113768c20f0b6fcef23c8b")

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        q=request.form.get("question")
        i={"prompt":q}
        r=version.predict(**i)
        return (render_template("Cloudpicture.html", result=r[0]))
    else:
        return (render_template("Cloudpicture.html", result="waiting"))


if __name__ == "__main__":
    app.run()
