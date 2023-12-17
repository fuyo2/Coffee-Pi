#!/bin/bash

# Check if pip3 is installed
if ! command -v pip3 &>/dev/null; then
    echo "pip3 is not installed. Installing..."
    
    # Install pip3 using apt
    sudo apt update
    sudo apt install -y python3-pip
    echo "pip3 has been installed."
else
    echo "pip3 is already installed."
fi

# Check if Django version 5.0.0 is installed
if ! pip3 show django | grep -q "Version: 5.0.0"; then
    echo "Django version 5.0.0 is not installed. Installing..."
    sudo pip3 install django==5.0.0
    echo "Django version 5.0.0 has been installed."
else
    echo "Django version 5.0.0 is already installed."
fi

# Check if Pillow is installed
if ! pip3 show pillow &>/dev/null; then
    echo "Pillow is not installed. Installing..."
    sudo pip3 install pillow
    echo "Pillow has been installed."
else
    echo "Pillow is already installed."
fi

# Check if PostgreSQL is installed
if ! command -v psql &>/dev/null; then
    echo "PostgreSQL is not installed. Installing..."
    sudo apt update
    sudo apt install -y postgresql postgresql-contrib
    echo "PostgreSQL has been installed."
else
    echo "PostgreSQL is already installed."
fi

# Install the public key for the repository (if not done previously):
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

# Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

# Check if pgAdmin4 is installed
if ! command -v pgadmin4 &>/dev/null; then
    echo "pgAdmin4 is not installed. Installing..."
    sudo apt update
    sudo apt install -y pgadmin4
    echo "pgAdmin4 has been installed."
else
    echo "pgAdmin4 is already installed."
fi

# Check if psycopg2-binary is installed
if ! pip3 show psycopg2-binary &>/dev/null; then
    echo "psycopg2-binary is not installed. Installing..."
    sudo pip3 install psycopg2-binary
    echo "psycopg2-binary has been installed."
else
    echo "psycopg2-binary is already installed."
fi

# Check if the 'coffee' database exists, and create it if not
if ! sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw coffee; then
    echo "Creating 'coffee' database..."
    sudo -u postgres createdb coffee
    echo "'coffee' database has been created."
else
    echo "'coffee' database already exists."
fi

# Change the password of the 'postgres' user to 'coffeepi'
echo "Changing the password of 'postgres' user..."
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'coffeepi';"
echo "Password for 'postgres' user has been changed to 'coffeepi'."