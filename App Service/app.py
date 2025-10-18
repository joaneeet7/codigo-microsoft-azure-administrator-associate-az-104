"""
Demo App Service
"""

from flask import Flask, send_file

app = Flask(__name__)

@app.route('/')
def home():
    """Página principal"""
    return send_file('index.html')

@app.route('/health')
def health():
    """Health check simple"""
    return {'status': 'ok', 'message': 'Joan Amengual - Landing Page'}
