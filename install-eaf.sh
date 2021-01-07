#!/bin/bash

set -eu

ARCH_PACKAGES=(git nodejs aria2 libreoffice wmctrl xdotool)
ARCH_PACKAGES+=(python-pyqt5 python-pyqt5-sip python-pyqtwebengine python-qrcode)
ARCH_PACKAGES+=(python-dbus python-pyinotify python-markdown python-qtconsole)

# System dependencies
if apt-get -v &> /dev/null; then
    sudo apt-get install git nodejs aria2 libreoffice wmctrl xdotool
    sudo apt-get install libglib2.0-dev libdbus-1-3 libdbus-1-dev
    # Missing in Ubuntu: filebrowser-bin

    sudo apt-get install python3-pyqt5 python3-sip python3-pyqt5.qtwebengine \
         python3-qrcode python3-feedparser python3-dbus python3-pyinotify \
         python3-markdown python3-qtconsole python3-pygit2
         
elif dnf &> /dev/null; then
        sudo dnf install git nodejs aria2 libreoffice wmctrl xdotool
        sudo dnf install glib2-devel dbus-devel

        sudo dnf install python3-pyqt5-sip pyqtwebengine-devel python3-qrcode \
             python3-feedparser python3-dbus  python3-inotify python3-markdown \
             python3-qtconsole python3-pygit2

elif type pacman &> /dev/null; then
    sudo pacman -Sy --needed "${ARCH_PACKAGES[@]}"
    if type yay &> /dev/null; then
        yay -S filebrowser-bin
    fi
else
    echo "Unsupported distribution/package manager. Here are the packages that needs to be installed:"
    for PCK in "${ARCH_PACKAGES[@]}";
    do
        echo "- ${PCK}"
    done
    echo "Please test their installation and submit an issue/PR to https://github.com/manateelazycat/emacs-application-framework for the script to be updated."
    exit 1
fi

# Python dependencies
if type pip3 &>/dev/null; then
    pip3 install --user pymupdf grip
elif type pip &>/dev/null; then
    pip install --user pymupdf grip
else
    echo "Cannot find pip. Please install it before launching the script again."
    exit 1
fi
