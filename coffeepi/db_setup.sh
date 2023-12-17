#!/bin/bash

# Run 'makemigrations'
echo "Running 'makemigrations'..."
sudo python3 manage.py makemigrations

# Run 'migrate'
echo "Running 'migrate'..."
python3 manage.py migrate

# Define the SQL command to create the view
SQL_CMD=$(cat <<EOF
CREATE OR REPLACE VIEW distinct_brands AS
SELECT DISTINCT ON (brand) brand FROM console_coffee;
EOF
)

# Run the SQL command using psql
echo "$SQL_CMD" | sudo -u postgres psql -d coffee

# Create superuser
echo "Creating superuser..."
python3 manage.py createsuperuser