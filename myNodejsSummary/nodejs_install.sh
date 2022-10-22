#!/bin/bash
set -euxo pipefail
sudo apt update
sudo apt install nodejs
sudo apt install npm
npm install express
npm install ejs
npm install mysql