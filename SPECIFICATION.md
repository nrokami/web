# Entertainment Platform - Technical Specification

## Project Overview

Comprehensive entertainment platform supporting Stories/Novels, Videos, and Webtoons with monetization, social features, and livestream capabilities. Designed to run on PHP 8.x with MySQL 8.x, specifically optimized for Android Termux deployment without cPanel hosting.

## Architecture Overview

```
entertainment-platform/
├── public/                 # Web root
├── app/                   # Application logic
├── config/               # Configuration files
├── database/             # Database files & migrations
├── storage/              # User uploads
├── logs/                 # Application logs
├── scripts/              # Installation & maintenance scripts
└── docs/                 # Documentation
```

## Phase 1: Core Foundation (Weeks 1-3)

### 1.1 User Management
- **Authentication**
  - Email/Password registration with validation
  - Login with session management
  - Password hashing (bcrypt)
  - Email verification system
  - Password recovery flow
  - OTP via email
  - Remember me functionality

- **User Profile**
  - Profile information (name, bio, avatar, cover image)
  - User levels and experience points
  - Member badges and achievements
  - Profile privacy settings
  - Account security settings

### 1.2 Core Content Management

#### Stories/Novels
- **Story Management**
  - Create/edit/delete stories
  - Title, description, cover image
  - Category/tags assignment
  - Status (ongoing, completed, hiatus)
  - Visibility (public, private, VIP-only)
  - Chapter management with ordering

- **Chapter System**
  - Chapter creation and editing
  - Chapter content with rich text
  - Cover images per chapter
  - Read time estimation
  - Sequential chapter numbering
  - Auto-save functionality

#### Webtoons
- **Webtoon Management**
  - Series creation and management
  - Episode management
  - Image uploads per episode
  - Vertical scrolling support
  - Title and description

#### Videos
- **Video Management**
  - MP4 upload support
  - Thumbnail generation
  - Episode organization
  - Video player functionality
  - Playlist creation

### 1.3 Database Schema

**Core Tables:**
- `users` - User accounts and profiles
- `authors` - Author information and statistics
- `novels` - Story/novel data
- `chapters` - Chapter content
- `webtoons` - Webtoon series
- `webtoon_episodes` - Webtoon episodes
- `videos` - Video content
- `video_episodes` - Video episodes
- `wallets` - User currency wallets
- `transactions` - Financial transactions
- `settings` - System configuration
- `notifications` - User notifications
- `comments` - Comments on content
- `ratings` - User ratings and reviews
- `follows` - User following relationships
- `favorites` - User favorite content

### 1.4 Admin Panel Foundation
- **Dashboard**
  - System statistics
  - Recent activities
  - Quick actions
  
- **User Management**
  - User listing and search
  - User status management
  - Suspend/activate users
  - View user statistics

- **Content Management**
  - Story/novel management
  - Video management
  - Webtoon management
  - Bulk actions

- **Settings**
  - Website configuration
  - Logo and branding
  - Email configuration
  - System settings

### 1.5 Frontend Foundation
- **Pages**
  - Homepage with featured content
  - Story listing and search
  - Story detail page
  - Chapter reading interface
  - User profile page
  - Author profile page
  - Login/register pages
  - Settings page

- **Features**
  - Responsive mobile design
  - Search functionality
  - Category/tag filtering
  - Sorting options
  - Dark mode support

### 1.6 Termux Optimization
- **Installation Scripts**
  - `install.sh` - Automated setup
  - `start.sh` - Start services
  - `stop.sh` - Stop services
  - `backup.sh` - Database backup
  
- **Configuration**
  - `.env.example` - Environment template
  - Support for multiple ports (8000, 8080)
  - Support for localhost and 127.0.0.1
  - Automatic directory creation
  - Automatic database initialization

## Phase 2: Monetization System (Weeks 4-6)

### 2.1 Virtual Currency System
- Coin/Point system
- Wallet management
- Transaction history
- Recharge options

### 2.2 VIP Subscription
- VIP packages (monthly, quarterly, yearly)
- VIP benefits and features
- Auto-renewal management
- Subscription history

### 2.3 Payment Gateways
- QR Banking
- MoMo integration
- VNPay integration
- ZaloPay integration
- PayPal integration

### 2.4 Monetization Features
- Content unlocking with coins
- Premium chapter access
- Revenue sharing for authors
- Affiliate system

## Phase 3: Social & Community (Weeks 7-9)

### 3.1 Social Features
- Following system
- User messaging
- Comment system
- Like/reaction system
- Rating system

### 3.2 Community Content
- User posts/blogs
- Share functionality
- Comment threads
- User reputation

### 3.3 Livestream Foundation
- Livestream hosting
- Real-time chat
- Viewer management
- Schedule management

## Phase 4: Advanced Features (Weeks 10-12)

### 4.1 Ranking Systems
- Story rankings (views, ratings, coins)
- Author rankings
- User rankings
- Weekly/monthly rankings

### 4.2 Gamification
- Achievement system
- Reward system
- Daily missions
- Spin wheel rewards
- Gift codes

### 4.3 Analytics & Reporting
- Author dashboard
- Revenue analytics
- User analytics
- Content performance

## Technology Stack

### Backend
- **Language**: PHP 8.x
- **Framework**: Custom MVC framework
- **Database**: MySQL 8.x / MariaDB
- **Web Server**: Apache / PHP Built-in Server
- **Cache**: File-based (Redis optional Phase 2)

### Frontend
- **HTML5**
- **CSS3** (Flexbox, Grid)
- **JavaScript** (Vanilla JS + optional frameworks)
- **Responsive Design**
- **Dark Mode Support**

### Security
- Password hashing: bcrypt
- Session management: HTTP-only cookies
- CSRF protection: Token validation
- XSS protection: Input sanitization & output encoding
- Rate limiting: Request throttling
- SQL Injection prevention: Prepared statements

### File Structure

```
web/
├── .env.example                 # Environment template
├── .gitignore                   # Git ignore rules
├── README.md                    # Project documentation
├── SPECIFICATION.md             # This file
├── INSTALLATION.md              # Installation guide
├── 
├── scripts/
│   ├── install.sh              # Installation script
│   ├── start.sh                # Start services
│   ├── stop.sh                 # Stop services
│   ├── backup.sh               # Backup database
│   └── setup-termux.sh          # Termux-specific setup
├── 
├── public/                      # Web root
│   ├── index.php               # Entry point
│   ├── .htaccess               # Apache rewrite rules
│   ├── css/
│   │   ├── main.css            # Main stylesheet
│   │   ├── dark-mode.css       # Dark mode stylesheet
│   │   └── responsive.css      # Responsive design
│   ├── js/
│   │   ├── main.js             # Main JavaScript
│   │   ├── auth.js             # Authentication scripts
│   │   ├── api.js              # API client
│   │   └── utils.js            # Utility functions
│   └── images/
│       └── placeholder/        # Default images
├── 
├── app/
│   ├── Core/                   # Core framework classes
│   │   ├── Application.php
│   │   ├── Router.php
│   │   ├── Controller.php
│   │   ├── Model.php
│   │   ├── Database.php
│   │   ├── Session.php
│   │   ├── Auth.php
│   │   ├── Validator.php
│   │   └── Logger.php
│   ├── Controllers/            # Request handlers
│   │   ├── AuthController.php
│   │   ├── UserController.php
│   │   ├── NovelController.php
│   │   ├── ChapterController.php
│   │   ├── WebtoonController.php
│   │   ├── VideoController.php
│   │   ├── AdminController.php
│   │   ├── DashboardController.php
│   │   └── APIController.php
│   ├── Models/                 # Data models
│   │   ├── User.php
│   │   ├── Author.php
│   │   ├── Novel.php
│   │   ├── Chapter.php
│   │   ├── Webtoon.php
│   │   ├── Video.php
│   │   ├── Comment.php
│   │   ├── Rating.php
│   │   ├── Transaction.php
│   │   ├── Notification.php
│   │   └── Settings.php
│   ├── Middleware/             # Request middleware
│   │   ├── AuthMiddleware.php
│   │   ├── AdminMiddleware.php
│   │   ├── CSRFMiddleware.php
│   │   └── RateLimitMiddleware.php
│   ├── Helpers/                # Helper functions
│   │   ├── ImageHelper.php
│   │   ├── FileHelper.php
│   │   ├── DateHelper.php
│   │   ├── StringHelper.php
│   │   └── MathHelper.php
│   └── Services/               # Business logic
│       ├── AuthService.php
│       ├── UserService.php
│       ├── ContentService.php
│       ├── NotificationService.php
│       └── AnalyticsService.php
├── 
├── views/                      # Template files
│   ├── layouts/
│   │   ├── main.php
│   │   ├── admin.php
│   │   └── auth.php
│   ├── pages/
│   │   ├── home.php
│   │   ├── story/
│   │   │   ├── list.php
│   │   │   ├── detail.php
│   │   │   ├── read.php
│   │   │   └── create.php
│   │   ├── user/
│   │   │   ├── profile.php
│   │   │   ├── settings.php
│   │   │   ├── login.php
│   │   │   └── register.php
│   │   ├── admin/
│   │   │   ├── dashboard.php
│   │   │   ├── users.php
│   │   │   ├── content.php
│   │   │   └── settings.php
│   │   └── error/
│   │       ├── 404.php
│   │       ├── 403.php
│   │       └── 500.php
│   └── components/
│       ├── navbar.php
│       ├── sidebar.php
│       ├── footer.php
│       └── pagination.php
├── 
├── config/                     # Configuration files
│   ├── app.php                # Application config
│   ├── database.php           # Database config
│   ├── mail.php               # Email config
│   ├── session.php            # Session config
│   └── security.php           # Security config
├── 
├── database/
│   ├── database.sql           # Complete SQL schema
│   ├── migrations/            # Database migrations
│   │   ├── 2024_01_users.sql
│   │   ├── 2024_02_content.sql
│   │   ├── 2024_03_social.sql
│   │   └── 2024_04_transactions.sql
│   └── seeders/               # Database seeds
│       ├── AdminSeeder.php
│       ├── CategorySeeder.php
│       └── SettingsSeeder.php
├── 
├── storage/
│   ├── uploads/               # User uploads
│   │   ├── avatars/
│   │   ├── covers/
│   │   ├── chapters/
│   │   ├── webtoons/
│   │   └── videos/
│   ├── cache/                 # Cache files
│   └── temp/                  # Temporary files
├── 
├── logs/                      # Application logs
│   ├── error.log
│   ├── access.log
│   └── admin.log
├── 
└── docs/
    ├── API.md                 # API documentation
    ├── DATABASE.md            # Database schema docs
    ├── INSTALLATION.md        # Installation guide
    ├── TERMUX.md              # Termux setup guide
    └── TROUBLESHOOTING.md     # Troubleshooting guide
```

## Database Design Principles

1. **Normalization**: 3NF for efficient data management
2. **Indexing**: Strategic indexes on foreign keys and search fields
3. **Relationships**: Proper foreign key constraints
4. **Timestamps**: created_at and updated_at on all tables
5. **Soft Deletes**: Support for data recovery
6. **Audit Trail**: User activity logging

## Security Considerations

1. **Authentication**
   - Secure password hashing with bcrypt
   - HTTP-only session cookies
   - Automatic session timeout
   - Remember-me with secure tokens

2. **Authorization**
   - Role-based access control (RBAC)
   - Content ownership verification
   - Admin-only actions protection

3. **Data Protection**
   - SQL injection prevention (prepared statements)
   - XSS protection (output encoding)
   - CSRF token validation
   - Rate limiting on sensitive endpoints

4. **File Upload Security**
   - File type validation
   - Size limits
   - Virus scanning (optional)
   - Separate upload directory outside web root

## Performance Optimization

1. **Database**
   - Query optimization
   - Strategic indexing
   - Connection pooling

2. **Caching**
   - Page caching
   - Query caching
   - File caching

3. **Frontend**
   - Minified CSS/JS
   - Image optimization
   - Lazy loading
   - Gzip compression

## Deployment

### Termux Requirements
```bash
pkg install php mariadb git curl unzip -y
```

### Installation
```bash
git clone https://github.com/nrokami/web.git
cd web
chmod +x scripts/*.sh
./scripts/install.sh
./scripts/start.sh
```

### Access
- Frontend: http://localhost:8000
- Admin: http://localhost:8000/admin
- Default Admin: admin@example.com / admin123

## Testing Strategy

1. **Unit Tests**: Core logic and functions
2. **Integration Tests**: Database operations
3. **API Tests**: Endpoint functionality
4. **UI Tests**: Frontend interactions
5. **Performance Tests**: Load testing

## Maintenance

1. **Regular Backups**: Daily database backups
2. **Log Rotation**: Monthly log rotation
3. **Security Updates**: Monthly patches
4. **Performance Monitoring**: Weekly analysis
5. **User Feedback**: Continuous improvement

## Future Enhancements

- Progressive Web App (PWA) support
- Mobile native apps (React Native)
- AI-powered recommendations
- Advanced analytics
- Multi-language support
- CDN integration
- Microservices architecture

---

**Version**: 1.0  
**Last Updated**: 2024  
**Status**: Phase 1 Development
