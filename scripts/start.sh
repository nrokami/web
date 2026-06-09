#!/bin/bash

# Entertainment Platform - Start Server Script

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo -e "${YELLOW}=== Entertainment Platform - Start Server ===${NC}\n"

# Check if MariaDB is running
print_status "Checking MariaDB..."
if ! pgrep -x "mysqld" > /dev/null; then
    print_status "Starting MariaDB..."
    MYSQL_DATA_DIR="$HOME/.mysql"
    mkdir -p "$MYSQL_DATA_DIR" 2>/dev/null || true
    mysqld_safe --datadir="$MYSQL_DATA_DIR" > /dev/null 2>&1 &
    sleep 3
    print_status "MariaDB started"
else
    print_status "MariaDB is already running"
fi

# Start PHP server
echo ""
print_status "Starting PHP server..."
echo ""

cd "$PROJECT_DIR/public"

# Default to port 8000
PORT=${1:-8000}
HOST="127.0.0.1"

print_status "Server starting on http://$HOST:$PORT"
print_status "Admin panel: http://$HOST:$PORT/admin"
print_status "Press Ctrl+C to stop the server"
print_warning "Remember to run 'scripts/stop.sh' when finished to stop MariaDB"
echo ""

# Start PHP built-in server
php -S "$HOST:$PORT"
