# Entertainment Platform - Installation Guide

## Quick Start (Termux)

### Prerequisites
```bash
pkg update -y
pkg upgrade -y
pkg install php -y
pkg install mariadb -y
pkg install git -y
pkg install curl -y
pkg install unzip -y
```

### Automated Installation

```bash
# Clone repository
git clone https://github.com/nrokami/web.git
cd web

# Run installation script
chmod +x scripts/install.sh
./scripts/install.sh
```

The installation script will:
- ✅ Create necessary directories
- ✅ Set up database
- ✅ Import SQL schema
- ✅ Create admin account
- ✅ Configure environment variables
- ✅ Set up file permissions

### Start the Server

```bash
chmod +x scripts/start.sh
./scripts/start.sh
```

### Access the Platform

- **Frontend**: http://localhost:8000
- **Admin Panel**: http://localhost:8000/admin
- **Default Admin Login**:
  - Email: `admin@example.com`
  - Password: `admin123`

### Stop the Server

```bash
chmod +x scripts/stop.sh
./scripts/stop.sh
```

## Manual Installation

### Step 1: Install Dependencies

```bash
pkg update -y && pkg upgrade -y
pkg install php php-json php-mbstring php-pdo php-mysql -y
pkg install mariadb -y
pkg install git curl unzip -y
```

### Step 2: Clone Repository

```bash
git clone https://github.com/nrokami/web.git
cd web
```

### Step 3: Configure Environment

```bash
cp .env.example .env
# Edit .env with your settings
nano .env
```

### Step 4: Create Directories

```bash
mkdir -p storage/uploads/{avatars,covers,chapters,webtoons,videos}
mkdir -p storage/cache
mkdir -p storage/temp
mkdir -p logs
chmod -R 755 storage logs
```

### Step 5: Setup Database

```bash
# Start MariaDB
mysqld_safe &

# Wait a moment for MariaDB to start
sleep 2

# Create database and user
mysql -u root << EOF
CREATE DATABASE entertainment_platform;
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'app_password_123';
GRANT ALL PRIVILEGES ON entertainment_platform.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;
EOF

# Import database schema
mysql -u app_user -p'app_password_123' entertainment_platform < database/database.sql
```

### Step 6: Start PHP Server

```bash
# Navigate to public directory
cd public

# Start PHP built-in server
php -S localhost:8000

# Or with specific IP
php -S 127.0.0.1:8000

# Or use port 8080
php -S localhost:8080
```

### Step 7: Access Application

Open your browser and navigate to:
- **http://localhost:8000**
- **http://127.0.0.1:8000**
- **http://localhost:8080**

## Configuration

### .env File

```env
# Application
APP_NAME=Entertainment Platform
APP_ENV=development
APP_DEBUG=true
APP_URL=http://localhost:8000

# Database
DB_HOST=localhost
DB_PORT=3306
DB_NAME=entertainment_platform
DB_USER=app_user
DB_PASSWORD=app_password_123

# Mail (for email verification)
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USER=your_email@gmail.com
MAIL_PASSWORD=your_app_password
MAIL_FROM=noreply@entertainment.local

# Security
SESSION_LIFETIME=1440
CSRF_TOKEN_LENGTH=32
PASSWORD_MIN_LENGTH=8

# File Upload
MAX_UPLOAD_SIZE=104857600
ALLOWED_IMAGE_TYPES=jpg,jpeg,png,gif,webp
ALLOWED_VIDEO_TYPES=mp4,webm,avi

# API
API_RATE_LIMIT=60
API_RATE_WINDOW=60
```

## Database Backup

### Automatic Backup

```bash
chmod +x scripts/backup.sh
./scripts/backup.sh
```

### Manual Backup

```bash
# Backup database
mysqldump -u app_user -p'app_password_123' entertainment_platform > backup_$(date +%Y%m%d_%H%M%S).sql

# Restore from backup
mysql -u app_user -p'app_password_123' entertainment_platform < backup_file.sql
```

## Troubleshooting

### Port Already in Use

```bash
# Use different port
cd public
php -S localhost:8081

# Or kill existing process
pkill php
```

### Database Connection Error

```bash
# Check if MariaDB is running
ps aux | grep mariadb

# Start MariaDB if not running
mysqld_safe &

# Test connection
mysql -u app_user -p'app_password_123' entertainment_platform
```

### Permission Denied

```bash
# Fix file permissions
chmod -R 755 storage logs
chmod -R 755 scripts/*.sh

# Make scripts executable
chmod +x scripts/*.sh
```

### Storage Directory Not Found

```bash
# Create all necessary directories
mkdir -p storage/uploads/{avatars,covers,chapters,webtoons,videos}
mkdir -p storage/cache
mkdir -p storage/temp
mkdir -p logs

# Set permissions
chmod -R 755 storage logs
```

## First Time Setup

After successful installation:

1. **Access Admin Panel**: http://localhost:8000/admin
2. **Login**: admin@example.com / admin123
3. **Change Admin Password**: Settings → Security
4. **Configure Site Settings**: Settings → General
5. **Set Email Configuration**: Settings → Email
6. **Upload Site Logo**: Settings → Branding
7. **Create Categories**: Admin → Categories
8. **Create Tags**: Admin → Tags

## Development vs Production

### Development Mode
- Debug mode enabled
- Detailed error messages
- No caching
- Easy file modifications

### Production Mode
Update `.env`:
```env
APP_ENV=production
APP_DEBUG=false
```

## Security Checklist

- [ ] Change default admin password
- [ ] Set strong database password
- [ ] Configure HTTPS
- [ ] Set proper file permissions
- [ ] Enable CSRF protection
- [ ] Configure rate limiting
- [ ] Set up email verification
- [ ] Enable admin logging
- [ ] Configure firewall rules
- [ ] Set up regular backups

## Performance Optimization

1. **Enable Caching**
   - Set `CACHE_DRIVER=file` in .env

2. **Optimize Database**
   - Run `php maintenance/optimize-db.php`

3. **Compress Assets**
   - CSS and JS are minified

4. **Image Optimization**
   - Images automatically optimized on upload

## Support

For issues or questions:
- Check TROUBLESHOOTING.md
- Review logs in `logs/` directory
- Check application error logs

---

**Need Help?** Visit the documentation or create an issue on GitHub.
