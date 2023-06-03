#!/bin/bash
#Variables for knowing which packages has intalled
CHROME=
NODE=
CODE=
SLACK=
TERMINAL=
JAVA=
ANDROID=
CURL=
YARN=
GIT=
# function for install chro me
chrome_install() {
    #check and install chrome
    if [ ! -f "/usr/bin/google-chrome"]; then
        echo "Installing google chrome"
        sudo snap install -y google-chrome --stable
        local chrome_exit_code=$?
        if [ $chrome_exit_code -eq 0 ]; then
            CHROME='Installed'
            return
        fi
        if [ $chrome_exit_code -gt 0 ]; then
            CHROME='Failed'
            echo "Chrome didn't installed successfully"
            return
        fi
    fi
    CHROME='Already installed'
    return
}

# function for installing slack
slack_install() {
    #check and install slack
    if [ ! -f "/usr/bin/slack"]; then
        echo "Installing Slack"
        sudo snap install -y slack --classic
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            SLACK='Installed'
            return
        fi
        if [ $exit_code -gt 0 ]; then
            SLACK='Failed'
            echo "Slack didn't installed successfully"
            return
        fi
    fi
    SLACK='Already installed'
    return
}
# function for installing vs-code
code_install() {
    #check and install code
    if [ ! -f "/usr/bin/code"]; then
        echo "Installing Code"
        sudo snap install -y code --classic
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            CODE='Installed'
            return
        fi
        if [ $exit_code -gt 0 ]; then
            CODE='Failed'
            echo "Code didn't installed successfully"
            return
        fi
    fi
    CODE='Already installed'
    return
}
# function for installing terminator
terminator_install() {
    #check and install terminator
    if [ ! -f "/usr/bin/terminator"]; then
        echo "Installing Terminator"
        sudo apt install -y terminator
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            TERMINAL='Installed'
            return
        fi
        if [ $exit_code -gt 0 ]; then
            TERMINAL='Failed'
            echo "Terminal didn't installed successfully"
            return
        fi
    fi
    TERMINAL='Already installed'
    return
}
java_install() {
    #check and install terminator
    if [ ! -f "/usr/bin/java"]; then
        echo "Installing Java"
        sudo apt install -y openjdk-11
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            JAVA='Installed'
            return
        fi
        if [ $exit_code -gt 0 ]; then
            JAVA='Failed'
            echo "Java didn't installed successfully"
            return
        fi
    fi
    JAVA='Already installed'
    return
}
#function for installing android studio
android_studio_install() {
    #check and install android-studio
    if [ ! -f "/usr/bin/android-studio"]; then
        echo "Installing Code"
        sudo snap install -y android-studio --classic
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            ANDROID='Installed'
            return
        fi
        if [ $exit_code -gt 0 ]; then
            ANDROID='Failed'
            echo "Code didn't installed successfully"
            return
        fi
    fi
    ANDROID='Already installed'
    return
}
#function for installing curl
curl_install() {
    #check and install curl
    if [ ! -f "/usr/bin/curl"]; then
        echo "Installing Curl"
        sudo apt install -y curl
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            CURL='Installed'
            return
        fi
        if [ $exit_code -gt 0 ]; then
            CURL='Failed'
            echo "Curl didn't installed successfully"
            return
        fi
    fi
    CURL='Already installed'
    return
}
install_yarn() {
    if [ -f '/usr/bin/node' ]; then
        npm install --global yarn
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            echo "Yarn Installed Successfully"
            YARN="Installed"
            return
        else
            echo "There is an error installing yarn"
            YARN="Installation failed"
            return
        fi
    fi
    return
}
#function for setting up node source path
set_node_path() {
    if [ -f '/usr/bin/curl']; then
        echo "Setting node path using curl"
        curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            echo "Done setting node path"
            return
        else
            echo "Error setting up node path"
            return
        fi
    fi
    return
}
update_system_with_apt() {
    echo "Updating system with apt"
    sudo apt update
    return
}
#function for installing nodejs
nodejs_install() {
    #check and install nodejs
    if [ ! -f "/usr/bin/node"]; then
        if [ ! -f '/usr/bin/curl' ]; then
            curl_install
            set_node_path
            update_system_with_apt
        fi
        echo "Installing Node"
        sudo apt install -y nodejs
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            NODE='Installed'
            install_yarn
            return
        fi
        if [ $exit_code -gt 0 ]; then
            NODE='Failed'
            echo "Node didn't installed successfully"
            return
        fi
    fi
    NODE='Already installed'
    return
}
#function for instaling git version control system
install_git() {
    if [ ! -f '/usr/bin/git' ]; then
        sudo apt install git
        local exit_code=$?
        if [ $exit_code -eq 0 ]; then
            echo "Git Installed Successfully"
            GIT="Installed"
            return
        else
            echo "There is an error installing Git"
            GIT="Installation failed"
            return
        fi
    fi
    GIT="Already Installed"
    return
}
updated_systemWithApt() {
    #check if snap is installed
    if [ -f '/usr/bin/snapd']; then
        echo "snap is installed"
    else
        echo "Installing snap store for packages"
        sudo apt install snapd
        apt_exit_code=$?
        # Checking apt has intalled successfully or not
        if [ $apt_exit_code -gt 0 ]; then
            echo "There is some problem installing the snap store please install manually"
            # exit if snap command has not installed successfully
            exit 1
        fi
    fi
    chrome_install
    slack_install
    code_install
    terminator_install
    java_install
    android_studio_install
    nodejs_install
    install_git
    echo "Chrome\t\t$CHROME"
    echo "Slack \t\t$SLACK"
    echo "VsCode\t\t$CODE"
    echo "Terminator\t\t$TERMINATOR"
    echo "Java \t\t$JAVA"
    echo "Android Studio\t\t$ANDROID_STUDIO"
    echo "Node \t\t$NODE"
    echo "Git  \t\t$GIT"
}
# for users who haven't been updated there system with apt repository before running this script
proceed_with_errors() {
    echo "This might get break in between so please stay around your computer"
    updated_systemWithApt
}

update_systemWithApt() {
    echo "Updating system with apt $"
    sudo apt update && sudo apt upgrade
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo "System updated successfully"
        updated_systemWithApt
        return
    else
        echo "There is some error in updating your system \nDo you want to proceed further without fixing it(y/n)?"
        read YES_NO_PROCEED_WITH_ERROR
        if [ $YES_NO_PROCEED_WITH_ERROR = "y" ]; then
            proceed_with_errors
        else
            echo "Please update your system properly before moving forward \nBye Bye"
            exit 1
        fi
    fi
    echo "system is updated... proceeding further"
    return
}
# for user who has updated there system with apt repository before running this script

echo "Welcome to SystemSetup\nThis is basic system setup script for react native developers"
echo "Do you want to proceed further? (y/n)"
read YES_NO
if [ "$YES_NO" = "y" ]; then
    echo "Have you updated your system with apt repository?"
    read YES_UPDATED
    if [ "$YES_UPDATED" = "y" ]; then
        updated_systemWithApt
    else
        update_systemWithApt
    fi
else
    echo "Bye Bye"
    exit 1
fi
