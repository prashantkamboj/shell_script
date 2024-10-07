#!/bin/bash
# Variables to track installation status
CHROME=
NODE=
CODE=
SLACK=
ITERM=
JAVA=
ANDROID=
CURL=
YARN=
GIT=

# Function to install Google Chrome
chrome_install() {
    if [ ! -d "/Applications/Google Chrome.app" ]; then
        echo "Installing Google Chrome"
        brew install --cask google-chrome
        local chrome_exit_code=$?
        if [ $chrome_exit_code -eq 0 ]; then
            CHROME='Installed'
            return
        else
            CHROME='Failed'
            echo "Google Chrome did not install successfully"
            return
        fi
    fi
    CHROME='Already installed'
}

# Function to install Slack
slack_install() {
    if [ ! -d "/Applications/Slack.app" ]; then
        echo "Installing Slack"
        brew install --cask slack
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            SLACK='Installed'
            return
        else
            SLACK='Failed'
            echo "Slack did not install successfully"
            return
        fi
    fi
    SLACK='Already installed'
}

# Function to install VS Code
code_install() {
    if [ ! -d "/Applications/Visual Studio Code.app" ]; then
        echo "Installing VS Code"
        brew install --cask visual-studio-code
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            CODE='Installed'
            return
        else
            CODE='Failed'
            echo "VS Code did not install successfully"
            return
        fi
    fi
    CODE='Already installed'
}

# Function to install iTerm2
iterm_install() {
    if [ ! -d "/Applications/iTerm.app" ]; then
        echo "Installing iTerm2"
        brew install --cask iterm2
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            ITERM='Installed'
            return
        else
            ITERM='Failed'
            echo "iTerm2 did not install successfully"
            return
        fi
    fi
    ITERM='Already installed'
}

# Function to install Java
java_install() {
    if [ -z "$(java -version 2>&1 | grep 'java version')" ]; then
        echo "Installing Java"
        brew install openjdk@17
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            JAVA='Installed'
            return
        else
            JAVA='Failed'
            echo "Java did not install successfully"
            return
        fi
    fi
    JAVA='Already installed'
}

# Function to install Android Studio
android_studio_install() {
    if [ ! -d "/Applications/Android Studio.app" ]; then
        echo "Installing Android Studio"
        brew install --cask android-studio
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            ANDROID='Installed'
            return
        else
            ANDROID='Failed'
            echo "Android Studio did not install successfully"
            return
        fi
    fi
    ANDROID='Already installed'
}

# Function to install curl
curl_install() {
    if ! command -v curl &> /dev/null; then
        echo "Installing Curl"
        brew install curl
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            CURL='Installed'
            return
        else
            CURL='Failed'
            echo "Curl did not install successfully"
            return
        fi
    fi
    CURL='Already installed'
}

# Function to install Node.js and Yarn
nodejs_install() {
    if ! command -v node &> /dev/null; then
        echo "Installing Node.js"
        brew install node
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            NODE='Installed'
            npm install --global yarn
            YARN='Installed'
            return
        else
            NODE='Failed'
            echo "Node.js did not install successfully"
            return
        fi
    fi
    NODE='Already installed'
    YARN='Already installed'
}

# Function to install Git
install_git() {
    if ! command -v git &> /dev/null; then
        echo "Installing Git"
        brew install git
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            GIT='Installed'
            return
        else
            GIT='Failed'
            echo "Git did not install successfully"
            return
        fi
    fi
    GIT='Already installed'
}

# Function to update Homebrew
update_system() {
    echo "Updating Homebrew"
    brew update && brew upgrade
    return
}

# Main setup
echo "Welcome to macOS Setup for React Native Developers"
echo "Do you want to proceed with the setup? (y/n)"
read YES_NO
if [ "$YES_NO" = "y" ]; then
    update_system
    chrome_install
    slack_install
    code_install
    iterm_install
    java_install
    android_studio_install
    nodejs_install
    install_git
    echo -e "Chrome:\t\t$CHROME"
    echo -e "Slack:\t\t$SLACK"
    echo -e "VS Code:\t$CODE"
    echo -e "iTerm2:\t\t$ITERM"
    echo -e "Java:\t\t$JAVA"
    echo -e "Android Studio:\t$ANDROID"
    echo -e "Node.js:\t$NODE"
    echo -e "Git:\t\t$GIT"
else
    echo "Setup aborted."
    exit 1
fi
