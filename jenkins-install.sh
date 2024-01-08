#!/bin/bash

# Install Jenkins
sudo snap install jenkins --classic

# Install terraform
sudo snap install terraform --classic 

# Install kubectl
sudo snap install kubectl --classic

# Configuring Firewall
# sudo ufw allow http
sudo ufw allow 8080
sudo ufw allow ssh
sudo ufw enable

