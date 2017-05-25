#!/bin/bash
set -e
source /electron-headless/buildconfig
set -x

$minimal_apt_get_install nodejs

# Install Electron dependencies
$minimal_apt_get_install libgtk2.0-0 libgconf2-4 libnss3 libasound2 libxtst6 xvfb gtk2-engines-pixbuf

# Install dependencies needed by 0.36.5+
$minimal_apt_get_install libnotify-dev dbus-x11

# Install dependencies needed by newer Electron
$minimal_apt_get_install libxss1

npm install -g electron@1.6.8
