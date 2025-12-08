#!/bin/bash

# Update and install Python3 and pip
yum update -y
yum install -y python3 git

# Install Flask
pip3 install --no-cache-dir flask

# Create a simple Flask app
cat > /home/ec2-user/app.py <<'EOF'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello from Terraform Flask!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# Run the app in background
nohup python3 /home/ec2-user/app.py &
