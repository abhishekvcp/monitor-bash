from flask import Flask, render_template
import time

app = Flask(__name__)

def get_system_metrics():
    with open('system_metrics.log', 'r') as file:
        lines = file.readlines()
        #last_lines = lines[-40:]
        return last_lines

@app.route('/')
def index():
    while True:
        last_lines = get_system_metrics()
        return render_template('index.html', last_lines=last_lines)
        time.sleep(10)

if __name__ == '__main__':
    app.run(debug=True)
