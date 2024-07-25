from flask import render_template

def init_app(app):
    @app.route('/')
    def home():
        return render_template('index.html')

    @app.route('/about')
    def about():
        return render_template('about.html')
    @app.route('/display')
    def display():
        return render_template('display.html')
    @app.route('/manage')
    def manage():
        return render_template('manage.html')
    @app.route('/dashboard')
    def dashboard():
        return render_template('home.html')