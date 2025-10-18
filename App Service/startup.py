"""
Startup script for Azure App Service
"""
import os
import sys

# Add the app directory to Python path
sys.path.insert(0, os.path.dirname(__file__))

# Import and run the Flask app
from app import app

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8000))
    print(f"Iniciando landing page en puerto {port}")
    print(f"Abre tu navegador en: http://localhost:{port}")
    app.run(host='0.0.0.0', port=port, debug=False)