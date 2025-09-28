#!/bin/bash

# -----------------------------------------------------------
# Summit Cloud Solutions Repo Scaffold + Git Setup
# -----------------------------------------------------------

REPO_NAME="summit-cloud-solutions"
GITHUB_URL=$1   # Pass your GitHub repo HTTPS or SSH URL as first argument

if [ -z "$GITHUB_URL" ]; then
  echo "Usage: bash setup_summit_repo.sh <GITHUB_REPO_URL>"
  exit 1
fi

echo "Creating repo: $REPO_NAME"
mkdir $REPO_NAME
cd $REPO_NAME || exit

# -------------------------
# Root files
# -------------------------
echo "# Summit Cloud Solutions Portfolio" > README.md

echo "node_modules/
.env
.DS_Store" > .gitignore

cat <<EOL > LICENSE
MIT License
Copyright (c) 2025 Matt
Permission is hereby granted, free of charge, to any person obtaining a copy...
EOL

# -------------------------
# Gig 1: EC2 Setup
# -------------------------
mkdir -p gig-ec2-setup/nginx-hello-world
cat <<EOL > gig-ec2-setup/ec2-user-data.sh
#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx
cat <<HTML > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Hello from EC2</title>
</head>
<body>
<h1>Hello from EC2 in region: \$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')</h1>
<p>Current server time: \$(date)</p>
</body>
</html>
HTML
EOL

echo "# EC2 Setup Example

This project demonstrates provisioning an EC2 instance running Amazon Linux 2, installing Nginx, and serving a simple webpage.

## Setup Instructions

1. Launch an EC2 instance (Amazon Linux 2).
2. Paste the contents of ec2-user-data.sh into User Data.
3. Access your public IP to see 'Hello from EC2'." > gig-ec2-setup/README.md

# -------------------------
# Gig 2: S3 Static Site
# -------------------------
mkdir -p gig-s3-static-site/website

cat <<EOL > gig-s3-static-site/website/index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Summit Cloud S3 Static Site</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<header>
<h1>Welcome to Summit Cloud S3 Static Site</h1>
</header>
<main>
<p>This static site is hosted on AWS S3.</p>
<button onclick="showTime()">Show Server Time</button>
<p id="time"></p>
</main>
<script src="script.js"></script>
</body>
</html>
EOL

cat <<EOL > gig-s3-static-site/website/style.css
body { font-family: Arial, sans-serif; text-align: center; margin: 50px; }
header { background-color: #4CAF50; color: white; padding: 20px; }
button { padding: 10px 20px; font-size: 16px; }
EOL

cat <<EOL > gig-s3-static-site/website/script.js
function showTime() {
  document.getElementById('time').innerText = new Date().toLocaleString();
}
EOL

echo "# S3 Static Site Example

This project demonstrates a static website hosted on AWS S3.

## Setup Instructions

1. Create an S3 bucket.
2. Enable static website hosting.
3. Upload the contents of the website folder.
4. Visit the S3 website endpoint to see the site live." > gig-s3-static-site/README.md

# -------------------------
# Gig 3: AWS Amplify React/Vite
# -------------------------
mkdir -p gig-aws-amplify/amplify-project/src
mkdir -p gig-aws-amplify/amplify-project/public

cat <<EOL > gig-aws-amplify/amplify-project/package.json
{
  "name": "amplify-project",
  "version": "1.0.0",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.0.0",
    "react-dom": "^18.0.0"
  },
  "devDependencies": {
    "vite": "^5.0.0",
    "@vitejs/plugin-react": "^4.0.0"
  }
}
EOL

cat <<EOL > gig-aws-amplify/amplify-project/src/App.jsx
import React from 'react';

function App() {
  return (
    <div style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>Welcome to Summit Cloud Amplify Project</h1>
      <p>This React app is deployed via AWS Amplify.</p>
    </div>
  );
}

export default App;
EOL

cat <<EOL > gig-aws-amplify/amplify-project/src/main.jsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOL

cat <<EOL > gig-aws-amplify/amplify-project/public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Amplify React App</title>
</head>
<body>
<div id="root"></div>
<script type="module" src="/src/main.jsx"></script>
</body>
</html>
EOL

echo "# AWS Amplify React/Vite Example

This project demonstrates a React app deployed using AWS Amplify.

## Setup Instructions

1. Install dependencies: npm install
2. Run locally: npm run dev
3. Push to Amplify: connect this repo via Amplify Console." > gig-aws-amplify/README.md

# -------------------------
# Gig 4: EC2 Express App
# -------------------------
mkdir -p gig-ec2-express-app/routes

cat <<EOL > gig-ec2-express-app/package.json
{
  "name": "ec2-express-app",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOL

cat <<EOL > gig-ec2-express-app/app.js
const express = require('express');
const app = express();
const port = 3000;

const indexRouter = require('./routes/index');
const apiRouter = require('./routes/api');

app.use('/', indexRouter);
app.use('/api', apiRouter);

app.listen(port, () => {
  console.log(\`Express app listening at http://localhost:\${port}\`);
});
EOL

cat <<EOL > gig-ec2-express-app/routes/index.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.send('<h1>Hello from EC2 Express App!</h1>');
});

module.exports = router;
EOL

cat <<EOL > gig-ec2-express-app/routes/api.js
const express = require('express');
const router = express.Router();

router.get('/time', (req, res) => {
    res.json({ serverTime: new Date() });
});

module.exports = router;
EOL

echo "# EC2 Express App Example

This project demonstrates running a Node.js Express app on an EC2 instance.

## Setup Instructions

1. Launch EC2 (Amazon Linux 2 or Ubuntu).
2. Install Node.js: sudo yum install -y nodejs npm
3. Upload this project to the instance.
4. Install dependencies: npm install
5. Run the app: npm start
6. Access http://<EC2_PUBLIC_IP>:3000 for home page and /api/time for API." > gig-ec2-express-app/README.md

# -------------------------
# Git initialization & push
# -------------------------
echo "Initializing Git..."
git init
git add .
git commit -m "Initial commit: Full Summit Cloud Solutions portfolio scaffold"
git branch -M main
git remote add origin $GITHUB_URL

echo "Pushing to GitHub..."
git push -u origin main

echo "✅ Summit Cloud Solutions repo scaffold created, committed, and pushed to GitHub!"