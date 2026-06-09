#!/bin/bash

# Entertainment Platform - Automated Installation Script
# This script automates the setup process on Termux

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_section() {
    echo -e "\n${YELLOW}=== $1 ===${NC}\n"
}

# Check if running on Termux
if [ ! -d "$HOME/.termux" ] && [ ! -f "/data/data/com.termux/files/usr/bin/bash" ]; then
    print_warning "This script is optimized for Termux, but may work on other Linux systems"
fi

print_section "Entertainment Platform - Installation"

# Get current directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

print_status "Project directory: $PROJECT_DIR"

# Step 1: Install PHP and Database
print_section "Installing Dependencies"

if ! command -v php &> /dev/null; then
    print_status "Installing PHP..."
    pkg install -y php php-json php-mbstring php-pdo php-mysql 2>/dev/null || {
        print_error "Failed to install PHP"
        exit 1
    }
else
    print_status "PHP already installed"
fi

if ! command -v mariadb &> /dev/null; then
    print_status "Installing MariaDB..."
    pkg install -y mariadb 2>/dev/null || {
        print_error "Failed to install MariaDB"
        exit 1
    }
else
    print_status "MariaDB already installed"
fi

# Step 2: Create directories
print_section "Creating Directory Structure"

directories=(
    "$PROJECT_DIR/storage/uploads/avatars"
    "$PROJECT_DIR/storage/uploads/covers"
    "$PROJECT_DIR/storage/uploads/chapters"
    "$PROJECT_DIR/storage/uploads/webtoons"
    "$PROJECT_DIR/storage/uploads/videos"
    "$PROJECT_DIR/storage/cache"
    "$PROJECT_DIR/storage/temp"
    "$PROJECT_DIR/logs"
)

for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        print_status "Created directory: $dir"
    else
        print_status "Directory already exists: $dir"
    fi
done

# Set permissions
chmod -R 755 "$PROJECT_DIR/storage" "$PROJECT_DIR/logs" 2>/dev/null || true
print_status "Set directory permissions"

# Step 3: Environment configuration
print_section "Configuring Environment"

if [ ! -f "$PROJECT_DIR/.env" ]; then
    if [ -f "$PROJECT_DIR/.env.example" ]; then
        cp "$PROJECT_DIR/.env.example" "$PROJECT_DIR/.env"
        print_status "Created .env from .env.example"
    else
        print_error ".env.example not found"
        exit 1
    fi
else
    print_status ".env already exists"
fi

# Step 4: Database setup
print_section "Setting Up Database"

# Check if MariaDB data directory exists
MYSQL_DATA_DIR="$HOME/.mysql"
if [ ! -d "$MYSQL_DATA_DIR" ]; then
    print_status "Initializing MariaDB database..."
    mkdir -p "$MYSQL_DATA_DIR"
    mysql_install_db --datadir="$MYSQL_DATA_DIR" 2>/dev/null || {
        print_warning "MariaDB might already be initialized"
    }
fi

# Start MariaDB if not running
if ! pgrep -x "mysqld" > /dev/null; then
    print_status "Starting MariaDB..."
    mysqld_safe --datadir="$MYSQL_DATA_DIR" > /dev/null 2>&1 &
    sleep 3  # Wait for MariaDB to start
else
    print_status "MariaDB is already running"
fi

# Create database and user
print_status "Creating database and user..."

mysql -u root 2>/dev/null << EOF
CREATE DATABASE IF NOT EXISTS entertainment_platform;
CREATE USER IF NOT EXISTS 'app_user'@'localhost' IDENTIFIED BY 'app_password_123';
GRANT ALL PRIVILEGES ON entertainment_platform.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;
EOF

print_status "Database and user created"

# Step 5: Import database schema
print_section "Importing Database Schema"

if [ -f "$PROJECT_DIR/database/database.sql" ]; then
    print_status "Importing database.sql..."
    mysql -u app_user -papp_password_123 entertainment_platform < "$PROJECT_DIR/database/database.sql" 2>/dev/null || {
        print_warning "Database import had issues - schema might need manual setup"
    }
    print_status "Database schema imported"
else
    print_warning "database.sql not found at $PROJECT_DIR/database/database.sql"
fi

# Step 6: Create admin account
print_section "Creating Admin Account"

ADMIN_EMAIL="admin@example.com"
ADMIN_PASSWORD="admin123"
ADMIN_PASSWORD_HASH=$(php -r "echo password_hash('$ADMIN_PASSWORD', PASSWORD_DEFAULT);")

mysql -u app_user -papp_password_123 entertainment_platform 2>/dev/null << EOF
INSERT IGNORE INTO users (email, password, name, username, is_admin, email_verified, created_at)
VALUES ('$ADMIN_EMAIL', '$ADMIN_PASSWORD_HASH', 'Administrator', 'admin', 1, 1, NOW());
EOF

print_status "Admin account created"
print_status "Admin Email: $ADMIN_EMAIL"
print_status "Admin Password: $ADMIN_PASSWORD"

# Step 7: Set script permissions
print_section "Setting Script Permissions"

chmod +x "$SCRIPT_DIR/start.sh" 2>/dev/null || true
chmod +x "$SCRIPT_DIR/stop.sh" 2>/dev/null || true
chmod +x "$SCRIPT_DIR/backup.sh" 2>/dev/null || true

print_status "Script permissions set"

# Step 8: Display information
print_section "Installation Complete!"

echo -e "${GREEN}Your Entertainment Platform is ready!${NC}\n"

echo "Next steps:"
echo "1. Start the server: ./scripts/start.sh"
echo "2. Access the platform: http://localhost:8000"
echo "3. Admin panel: http://localhost:8000/admin"
echo ""
echo "Login credentials:"
echo "  Email: admin@example.com"
echo "  Password: admin123"
echo ""
echo "Configuration file: $PROJECT_DIR/.env"
echo ""
print_warning "⚠ Change your admin password after first login!"
print_warning "⚠ For production, update .env and database credentials"
echo ""
echo "For more information, see INSTALLATION.md"
