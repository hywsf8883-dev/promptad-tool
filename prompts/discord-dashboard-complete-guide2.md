# الدليل الشامل لبناء داشبورد بوت Discord باستخدام HTML & CSS & JavaScript

---

## 📋 فهرس المحتويات

1. [مقدمة](#مقدمة)
2. [أساسيات HTML للداشبورد](#أساسيات-html-للداشبورد)
3. [تصميم CSS المتقدم](#تصميم-css-المتقدم)
4. [التنقل بين الأقسام (Navigation)](#التنقل-بين-الأقسام)
5. [الأيقونات واستبدال الإيموجيات](#الأيقونات-واستبدال-الإيموجيات)
6. [JavaScript للتفاعل](#javascript-للتفاعل)
7. [ربط الداشبورد مع البوت](#ربط-الداشبورد-مع-البوت)
8. [أمثلة عملية كاملة](#أمثلة-عملية-كاملة)
9. [نصائح وأفضل الممارسات](#نصائح-وأفضل-الممارسات)

---

## مقدمة

### ما هو داشبورد بوت Discord؟

داشبورد بوت Discord هو واجهة ويب تتيح للمستخدمين التحكم في بوت Discord الخاص بهم من خلال متصفح الويب. بدلاً من استخدام أوامر Slash Commands فقط، يمكن للمستخدمين إدارة إعدادات البوت عبر واجهة رسومية سهلة الاستخدام.

### لماذا نحتاج داشبورد؟

- **سهولة الاستخدام**: واجهة رسومية أسهل من تذكر الأوامر
- **إدارة متعددة**: التحكم في عدة سيرفرات من مكان واحد
- **إعدادات مرئية**: تخصيص الألوان والرسائل بشكل مباشر
- **إحصائيات**: عرض بيانات وإحصائيات البوت

### التقنيات المستخدمة

```
Frontend: HTML5 + CSS3 + JavaScript (Vanilla أو React/Vue)
Backend: Node.js + Express
Database: MongoDB / PostgreSQL / SQLite
API: Discord.js / Discord.py
```

---

## أساسيات HTML للداشبورد

### هيكل الصفحة الأساسي

```html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>داشبورد البوت | Bot Dashboard</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="styles.css">
    
    <!-- Font Awesome للأيقونات -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- المحتوى هنا -->
    
    <!-- JavaScript -->
    <script src="app.js"></script>
</body>
</html>
```

### شرح كل جزء:

#### 1. `<!DOCTYPE html>`
يخبر المتصفح أن هذا مستند HTML5. يجب أن يكون أول سطر في الملف.

#### 2. `<html lang="ar" dir="rtl">`
- `lang="ar"`: تحديد أن اللغة هي العربية (مهم لمحركات البحث وقارئات الشاشة)
- `dir="rtl"`: اتجاه النص من اليمين لليسار (ضروري للغة العربية)

#### 3. `<meta charset="UTF-8">`
تحديد ترميز الحروف لدعم جميع اللغات والرموز.

#### 4. `<meta name="viewport" ...>`
لجعل الموقع متجاوباً مع جميع أحجام الشاشات (جوال، تابلت، كمبيوتر).

---

## بناء هيكل الداشبورد

### التصميم الكلاسيكي للداشبورد

معظم داشبوردات Discord تتبع هذا الهيكل:

```
┌─────────────────────────────────────────────────────────┐
│  الشريط الجانبي    │        المحتوى الرئيسي              │
│  (Sidebar)         │        (Main Content)               │
│                    │                                     │
│  [لوجو]            │  ┌─────────────────────────────┐   │
│                    │  │    شريط العنوان العلوي      │   │
│  📊 لوحة التحكم    │  └─────────────────────────────┘   │
│  ⚙️ الإعدادات      │                                     │
│  📋 الأوامر        │  ┌─────────────────────────────┐   │
│  👥 المستخدمين     │  │                             │   │
│  📈 الإحصائيات     │  │    المحتوى الفعلي هنا       │   │
│  🔔 الإشعارات      │  │                             │   │
│                    │  │                             │   │
│  [زر تسجيل خروج]   │  └─────────────────────────────┘   │
│                    │                                     │
└────────────────────┴─────────────────────────────────────┘
```

### الكود HTML الكامل للهيكل

```html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>داشبورد البوت</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="dashboard-container">
        
        <!-- ===== الشريط الجانبي ===== -->
        <aside class="sidebar" id="sidebar">
            
            <!-- لوجو البوت -->
            <div class="sidebar-header">
                <img src="bot-logo.png" alt="Bot Logo" class="bot-logo">
                <h2 class="bot-name">بوتي الذكي</h2>
                <span class="bot-status online">● متصل</span>
            </div>
            
            <!-- قائمة التنقل -->
            <nav class="sidebar-nav">
                <ul class="nav-list">
                    
                    <!-- عنصر قائمة: لوحة التحكم -->
                    <li class="nav-item active">
                        <a href="#dashboard" class="nav-link" data-section="dashboard">
                            <i class="fas fa-chart-line nav-icon"></i>
                            <span class="nav-text">لوحة التحكم</span>
                        </a>
                    </li>
                    
                    <!-- عنصر قائمة: الإعدادات -->
                    <li class="nav-item">
                        <a href="#settings" class="nav-link" data-section="settings">
                            <i class="fas fa-cog nav-icon"></i>
                            <span class="nav-text">الإعدادات</span>
                        </a>
                    </li>
                    
                    <!-- عنصر قائمة: الأوامر -->
                    <li class="nav-item">
                        <a href="#commands" class="nav-link" data-section="commands">
                            <i class="fas fa-terminal nav-icon"></i>
                            <span class="nav-text">الأوامر</span>
                        </a>
                    </li>
                    
                    <!-- عنصر قائمة: المستخدمين -->
                    <li class="nav-item">
                        <a href="#users" class="nav-link" data-section="users">
                            <i class="fas fa-users nav-icon"></i>
                            <span class="nav-text">المستخدمين</span>
                        </a>
                    </li>
                    
                    <!-- عنصر قائمة: الإحصائيات -->
                    <li class="nav-item">
                        <a href="#statistics" class="nav-link" data-section="statistics">
                            <i class="fas fa-chart-bar nav-icon"></i>
                            <span class="nav-text">الإحصائيات</span>
                        </a>
                    </li>
                    
                    <!-- عنصر قائمة: السيرفرات -->
                    <li class="nav-item">
                        <a href="#servers" class="nav-link" data-section="servers">
                            <i class="fas fa-server nav-icon"></i>
                            <span class="nav-text">السيرفرات</span>
                        </a>
                    </li>
                    
                    <!-- عنصر قائمة: السجلات -->
                    <li class="nav-item">
                        <a href="#logs" class="nav-link" data-section="logs">
                            <i class="fas fa-history nav-icon"></i>
                            <span class="nav-text">السجلات</span>
                        </a>
                    </li>
                    
                    <!-- عنصر قائمة: الإشعارات -->
                    <li class="nav-item">
                        <a href="#notifications" class="nav-link" data-section="notifications">
                            <i class="fas fa-bell nav-icon"></i>
                            <span class="nav-text">الإشعارات</span>
                            <span class="badge">3</span>
                        </a>
                    </li>
                    
                </ul>
            </nav>
            
            <!-- قسم المستخدم في الأسفل -->
            <div class="sidebar-footer">
                <div class="user-profile">
                    <img src="user-avatar.png" alt="User" class="user-avatar">
                    <div class="user-info">
                        <span class="user-name">اسم المستخدم</span>
                        <span class="user-role">مدير</span>
                    </div>
                </div>
                <button class="logout-btn" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i>
                </button>
            </div>
            
        </aside>
        
        <!-- ===== المحتوى الرئيسي ===== -->
        <main class="main-content">
            
            <!-- شريط العنوان العلوي -->
            <header class="top-header">
                <button class="menu-toggle" id="menuToggle">
                    <i class="fas fa-bars"></i>
                </button>
                
                <h1 class="page-title" id="pageTitle">لوحة التحكم</h1>
                
                <div class="header-actions">
                    <button class="action-btn">
                        <i class="fas fa-search"></i>
                    </button>
                    <button class="action-btn">
                        <i class="fas fa-moon" id="themeToggle"></i>
                    </button>
                    <button class="action-btn notification-btn">
                        <i class="fas fa-bell"></i>
                        <span class="notification-badge">3</span>
                    </button>
                </div>
            </header>
            
            <!-- منطقة المحتوى المتغير -->
            <div class="content-area">
                
                <!-- ===== قسم: لوحة التحكم ===== -->
                <section id="dashboard-section" class="content-section active">
                    <div class="section-header">
                        <h2>نظرة عامة</h2>
                        <p>مرحباً بك في داشبورد بوت Discord</p>
                    </div>
                    
                    <!-- بطاقات الإحصائيات -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon blue">
                                <i class="fas fa-server"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-number">150</span>
                                <span class="stat-label">السيرفرات</span>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon green">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-number">12,450</span>
                                <span class="stat-label">المستخدمين</span>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon purple">
                                <i class="fas fa-terminal"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-number">45</span>
                                <span class="stat-label">الأوامر</span>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon orange">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-number">99.9%</span>
                                <span class="stat-label">الوقت التشغيلي</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- الرسوم البيانية -->
                    <div class="charts-row">
                        <div class="chart-card">
                            <h3>نشاط البوت</h3>
                            <div class="chart-placeholder">
                                <canvas id="activityChart"></canvas>
                            </div>
                        </div>
                        
                        <div class="chart-card">
                            <h3>أكثر الأوامر استخداماً</h3>
                            <div class="commands-list">
                                <div class="command-item">
                                    <span class="command-name">!help</span>
                                    <div class="command-bar">
                                        <div class="command-progress" style="width: 85%"></div>
                                    </div>
                                    <span class="command-count">2,450</span>
                                </div>
                                <div class="command-item">
                                    <span class="command-name">!play</span>
                                    <div class="command-bar">
                                        <div class="command-progress" style="width: 70%"></div>
                                    </div>
                                    <span class="command-count">1,890</span>
                                </div>
                                <div class="command-item">
                                    <span class="command-name">!ban</span>
                                    <div class="command-bar">
                                        <div class="command-progress" style="width: 45%"></div>
                                    </div>
                                    <span class="command-count">980</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- ===== قسم: الإعدادات ===== -->
                <section id="settings-section" class="content-section">
                    <div class="section-header">
                        <h2>إعدادات البوت</h2>
                        <p>تخصيص إعدادات البوت حسب احتياجاتك</p>
                    </div>
                    
                    <div class="settings-container">
                        <!-- إعدادات عامة -->
                        <div class="settings-card">
                            <h3><i class="fas fa-sliders-h"></i> إعدادات عامة</h3>
                            
                            <div class="setting-item">
                                <div class="setting-info">
                                    <label>بادئة الأوامر</label>
                                    <p>الرمز الذي يستخدم قبل الأوامر</p>
                                </div>
                                <div class="setting-control">
                                    <input type="text" value="!" class="prefix-input">
                                </div>
                            </div>
                            
                            <div class="setting-item">
                                <div class="setting-info">
                                    <label>لغة البوت</label>
                                    <p>اللغة الافتراضية للردود</p>
                                </div>
                                <div class="setting-control">
                                    <select class="setting-select">
                                        <option value="ar">العربية</option>
                                        <option value="en">English</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="setting-item">
                                <div class="setting-info">
                                    <label>الردود التلقائية</label>
                                    <p>تفعيل الردود التلقائية على الرسائل</p>
                                </div>
                                <div class="setting-control">
                                    <label class="toggle-switch">
                                        <input type="checkbox" checked>
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- إعدادات الترحيب -->
                        <div class="settings-card">
                            <h3><i class="fas fa-door-open"></i> رسالة الترحيب</h3>
                            
                            <div class="setting-item vertical">
                                <label>رسالة الترحيب</label>
                                <textarea class="setting-textarea" rows="4" placeholder="أهلاً بك في السيرفر!"></textarea>
                            </div>
                            
                            <div class="setting-item">
                                <div class="setting-info">
                                    <label>قناة الترحيب</label>
                                </div>
                                <div class="setting-control">
                                    <select class="setting-select">
                                        <option>#welcome</option>
                                        <option>#general</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- إعدادات الحماية -->
                        <div class="settings-card">
                            <h3><i class="fas fa-shield-alt"></i> الحماية</h3>
                            
                            <div class="setting-item">
                                <div class="setting-info">
                                    <label>مكافحة السبام</label>
                                    <p>حذف الرسائل المكررة تلقائياً</p>
                                </div>
                                <div class="setting-control">
                                    <label class="toggle-switch">
                                        <input type="checkbox" checked>
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                            
                            <div class="setting-item">
                                <div class="setting-info">
                                    <label>حظر الروابط</label>
                                    <p>حذف الروابط غير المسموح بها</p>
                                </div>
                                <div class="setting-control">
                                    <label class="toggle-switch">
                                        <input type="checkbox">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- ===== قسم: الأوامر ===== -->
                <section id="commands-section" class="content-section">
                    <div class="section-header">
                        <h2>إدارة الأوامر</h2>
                        <p>تفعيل/تعطيل الأوامر وتخصيصها</p>
                    </div>
                    
                    <div class="commands-table-container">
                        <table class="commands-table">
                            <thead>
                                <tr>
                                    <th>الأمر</th>
                                    <th>الوصف</th>
                                    <th>الاستخدام</th>
                                    <th>الحالة</th>
                                    <th>إجراءات</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><code>!help</code></td>
                                    <td>عرض قائمة الأوامر</td>
                                    <td>!help [command]</td>
                                    <td><span class="status-badge active">مفعل</span></td>
                                    <td>
                                        <button class="action-icon edit"><i class="fas fa-edit"></i></button>
                                        <button class="action-icon delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><code>!ban</code></td>
                                    <td>حظر مستخدم</td>
                                    <td>!ban @user [reason]</td>
                                    <td><span class="status-badge active">مفعل</span></td>
                                    <td>
                                        <button class="action-icon edit"><i class="fas fa-edit"></i></button>
                                        <button class="action-icon delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><code>!kick</code></td>
                                    <td>طرد مستخدم</td>
                                    <td>!kick @user [reason]</td>
                                    <td><span class="status-badge inactive">معطل</span></td>
                                    <td>
                                        <button class="action-icon edit"><i class="fas fa-edit"></i></button>
                                        <button class="action-icon delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </section>
                
                <!-- ===== قسم: المستخدمين ===== -->
                <section id="users-section" class="content-section">
                    <div class="section-header">
                        <h2>المستخدمين</h2>
                        <p>إدارة مستخدمي البوت</p>
                    </div>
                    
                    <div class="users-grid">
                        <div class="user-card">
                            <div class="user-card-header">
                                <img src="avatar1.png" alt="User" class="user-card-avatar">
                                <div class="user-status online"></div>
                            </div>
                            <div class="user-card-body">
                                <h4>أحمد محمد</h4>
                                <span class="user-tag">@ahmed123</span>
                                <div class="user-stats">
                                    <span><i class="fas fa-coins"></i> 1,250</span>
                                    <span><i class="fas fa-level-up-alt"></i> lvl 15</span>
                                </div>
                            </div>
                            <div class="user-card-footer">
                                <button class="btn-small">عرض</button>
                                <button class="btn-small danger">حظر</button>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- ===== قسم: الإحصائيات ===== -->
                <section id="statistics-section" class="content-section">
                    <div class="section-header">
                        <h2>الإحصائيات التفصيلية</h2>
                        <p>تحليلات وأرقام البوت</p>
                    </div>
                    
                    <div class="stats-detailed">
                        <div class="stat-detail-card">
                            <canvas id="serverGrowthChart"></canvas>
                        </div>
                    </div>
                </section>
                
                <!-- ===== قسم: السيرفرات ===== -->
                <section id="servers-section" class="content-section">
                    <div class="section-header">
                        <h2>السيرفرات</h2>
                        <p>إدارة السيرفرات المتصلة</p>
                    </div>
                    
                    <div class="servers-list">
                        <div class="server-item">
                            <img src="server-icon.png" alt="Server" class="server-icon">
                            <div class="server-info">
                                <h4>سيرفر الألعاب</h4>
                                <span>1,234 عضو</span>
                            </div>
                            <div class="server-actions">
                                <button class="btn-outline">الإعدادات</button>
                                <button class="btn-outline danger">إزالة</button>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- ===== قسم: السجلات ===== -->
                <section id="logs-section" class="content-section">
                    <div class="section-header">
                        <h2>سجلات الأحداث</h2>
                        <p>تتبع نشاط البوت</p>
                    </div>
                    
                    <div class="logs-container">
                        <div class="log-item">
                            <div class="log-icon success"><i class="fas fa-check"></i></div>
                            <div class="log-content">
                                <p>تم تشغيل البوت بنجاح</p>
                                <span class="log-time">منذ 5 دقائق</span>
                            </div>
                        </div>
                        <div class="log-item">
                            <div class="log-icon warning"><i class="fas fa-exclamation"></i></div>
                            <div class="log-content">
                                <p>تجاوز حد الـ Rate Limit</p>
                                <span class="log-time">منذ 15 دقيقة</span>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- ===== قسم: الإشعارات ===== -->
                <section id="notifications-section" class="content-section">
                    <div class="section-header">
                        <h2>الإشعارات</h2>
                        <p>إدارة إشعارات البوت</p>
                    </div>
                    
                    <div class="notifications-list">
                        <div class="notification-item unread">
                            <div class="notification-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="notification-content">
                                <h4>انضمام مستخدم جديد</h4>
                                <p>انضم @user إلى سيرفر الألعاب</p>
                                <span class="notification-time">منذ 2 دقيقة</span>
                            </div>
                            <button class="notification-dismiss"><i class="fas fa-times"></i></button>
                        </div>
                    </div>
                </section>
                
            </div>
            
        </main>
        
    </div>
    
    <script src="app.js"></script>
</body>
</html>
```

---

## تصميم CSS المتقدم

### ملف styles.css الكامل

```css
/* ============================================
   CSS VARIABLES (متغيرات CSS)
   ============================================ */

:root {
    /* الألوان الأساسية */
    --primary-color: #5865F2;
    --primary-hover: #4752C4;
    --primary-light: #E3E5F8;
    
    /* ألوان الخلفية */
    --bg-dark: #1a1b1e;
    --bg-darker: #141517;
    --bg-card: #25262b;
    --bg-hover: #2c2e33;
    
    /* ألوان النص */
    --text-primary: #ffffff;
    --text-secondary: #a0a0a0;
    --text-muted: #6e6e6e;
    
    /* ألوان الحالة */
    --success: #43b581;
    --warning: #faa61a;
    --danger: #f04747;
    --info: #5865F2;
    
    /* ألوان إضافية */
    --blue: #3ba55d;
    --green: #43b581;
    --purple: #9b59b6;
    --orange: #e67e22;
    --red: #e74c3c;
    
    /* المسافات */
    --sidebar-width: 280px;
    --sidebar-collapsed: 80px;
    --header-height: 70px;
    
    /* الحدود */
    --border-radius: 12px;
    --border-radius-sm: 8px;
    --border-color: #363636;
    
    /* الظلال */
    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.1);
    --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.15);
    --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.2);
    
    /* الانتقالات */
    --transition-fast: 0.2s ease;
    --transition-normal: 0.3s ease;
    --transition-slow: 0.5s ease;
}

/* ============================================
   RESET & BASE STYLES
   ============================================ */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    font-size: 16px;
    scroll-behavior: smooth;
}

body {
    font-family: 'Cairo', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background-color: var(--bg-dark);
    color: var(--text-primary);
    line-height: 1.6;
    overflow-x: hidden;
}

a {
    text-decoration: none;
    color: inherit;
}

ul {
    list-style: none;
}

button {
    cursor: pointer;
    border: none;
    background: none;
    font-family: inherit;
}

img {
    max-width: 100%;
    height: auto;
}

/* ============================================
   LAYOUT - الهيكل العام
   ============================================ */

.dashboard-container {
    display: flex;
    min-height: 100vh;
}

/* ============================================
   SIDEBAR - الشريط الجانبي
   ============================================ */

.sidebar {
    width: var(--sidebar-width);
    background-color: var(--bg-darker);
    border-left: 1px solid var(--border-color);
    display: flex;
    flex-direction: column;
    position: fixed;
    right: 0;
    top: 0;
    height: 100vh;
    z-index: 1000;
    transition: width var(--transition-normal);
    overflow-x: hidden;
}

/* رأس الشريط الجانبي */
.sidebar-header {
    padding: 24px 20px;
    border-bottom: 1px solid var(--border-color);
    text-align: center;
}

.bot-logo {
    width: 64px;
    height: 64px;
    border-radius: 50%;
    margin-bottom: 12px;
    border: 3px solid var(--primary-color);
    padding: 3px;
}

.bot-name {
    font-size: 1.25rem;
    font-weight: 700;
    margin-bottom: 8px;
}

.bot-status {
    font-size: 0.875rem;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
}

.bot-status.online {
    color: var(--success);
}

.bot-status.offline {
    color: var(--danger);
}

/* قائمة التنقل */
.sidebar-nav {
    flex: 1;
    padding: 16px 12px;
    overflow-y: auto;
}

.nav-list {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.nav-item {
    position: relative;
}

.nav-link {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 14px 16px;
    border-radius: var(--border-radius-sm);
    transition: all var(--transition-fast);
    color: var(--text-secondary);
    position: relative;
}

.nav-link:hover {
    background-color: var(--bg-hover);
    color: var(--text-primary);
}

.nav-item.active .nav-link {
    background-color: var(--primary-color);
    color: white;
}

.nav-item.active .nav-link::before {
    content: '';
    position: absolute;
    right: -12px;
    top: 50%;
    transform: translateY(-50%);
    width: 4px;
    height: 24px;
    background-color: var(--primary-color);
    border-radius: 2px;
}

.nav-icon {
    font-size: 1.25rem;
    width: 24px;
    text-align: center;
}

.nav-text {
    font-size: 0.9375rem;
    font-weight: 500;
}

/* شارة الإشعارات */
.badge {
    background-color: var(--danger);
    color: white;
    font-size: 0.75rem;
    padding: 2px 8px;
    border-radius: 10px;
    margin-right: auto;
}

/* تذييل الشريط الجانبي */
.sidebar-footer {
    padding: 16px;
    border-top: 1px solid var(--border-color);
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.user-profile {
    display: flex;
    align-items: center;
    gap: 12px;
}

.user-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: 2px solid var(--border-color);
}

.user-info {
    display: flex;
    flex-direction: column;
}

.user-name {
    font-size: 0.875rem;
    font-weight: 600;
}

.user-role {
    font-size: 0.75rem;
    color: var(--text-muted);
}

.logout-btn {
    width: 36px;
    height: 36px;
    border-radius: var(--border-radius-sm);
    background-color: var(--bg-card);
    color: var(--danger);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all var(--transition-fast);
}

.logout-btn:hover {
    background-color: var(--danger);
    color: white;
}

/* ============================================
   MAIN CONTENT - المحتوى الرئيسي
   ============================================ */

.main-content {
    flex: 1;
    margin-right: var(--sidebar-width);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* شريط العنوان العلوي */
.top-header {
    height: var(--header-height);
    background-color: var(--bg-darker);
    border-bottom: 1px solid var(--border-color);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 24px;
    position: sticky;
    top: 0;
    z-index: 100;
}

.menu-toggle {
    width: 40px;
    height: 40px;
    border-radius: var(--border-radius-sm);
    background-color: var(--bg-card);
    color: var(--text-primary);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.125rem;
    transition: all var(--transition-fast);
}

.menu-toggle:hover {
    background-color: var(--primary-color);
}

.page-title {
    font-size: 1.5rem;
    font-weight: 700;
    flex: 1;
    margin: 0 24px;
}

.header-actions {
    display: flex;
    align-items: center;
    gap: 12px;
}

.action-btn {
    width: 40px;
    height: 40px;
    border-radius: var(--border-radius-sm);
    background-color: var(--bg-card);
    color: var(--text-secondary);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    transition: all var(--transition-fast);
    position: relative;
}

.action-btn:hover {
    background-color: var(--bg-hover);
    color: var(--text-primary);
}

.notification-badge {
    position: absolute;
    top: -4px;
    left: -4px;
    background-color: var(--danger);
    color: white;
    font-size: 0.625rem;
    width: 18px;
    height: 18px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
}

/* منطقة المحتوى */
.content-area {
    flex: 1;
    padding: 24px;
    overflow-y: auto;
}

/* الأقسام */
.content-section {
    display: none;
    animation: fadeIn 0.3s ease;
}

.content-section.active {
    display: block;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.section-header {
    margin-bottom: 24px;
}

.section-header h2 {
    font-size: 1.75rem;
    font-weight: 700;
    margin-bottom: 8px;
}

.section-header p {
    color: var(--text-secondary);
    font-size: 0.9375rem;
}

/* ============================================
   STATS CARDS - بطاقات الإحصائيات
   ============================================ */

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-bottom: 24px;
}

.stat-card {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    padding: 24px;
    display: flex;
    align-items: center;
    gap: 16px;
    transition: all var(--transition-fast);
    border: 1px solid transparent;
}

.stat-card:hover {
    transform: translateY(-4px);
    border-color: var(--border-color);
    box-shadow: var(--shadow-lg);
}

.stat-icon {
    width: 56px;
    height: 56px;
    border-radius: var(--border-radius-sm);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}

.stat-icon.blue {
    background-color: rgba(88, 101, 242, 0.2);
    color: var(--primary-color);
}

.stat-icon.green {
    background-color: rgba(67, 181, 129, 0.2);
    color: var(--success);
}

.stat-icon.purple {
    background-color: rgba(155, 89, 182, 0.2);
    color: var(--purple);
}

.stat-icon.orange {
    background-color: rgba(230, 126, 34, 0.2);
    color: var(--orange);
}

.stat-info {
    display: flex;
    flex-direction: column;
}

.stat-number {
    font-size: 1.75rem;
    font-weight: 700;
    color: var(--text-primary);
}

.stat-label {
    font-size: 0.875rem;
    color: var(--text-secondary);
}

/* ============================================
   CHARTS - الرسوم البيانية
   ============================================ */

.charts-row {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
    gap: 20px;
}

.chart-card {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    padding: 24px;
}

.chart-card h3 {
    font-size: 1.125rem;
    font-weight: 600;
    margin-bottom: 20px;
}

.chart-placeholder {
    height: 250px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* قائمة الأوامر */
.commands-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.command-item {
    display: flex;
    align-items: center;
    gap: 12px;
}

.command-name {
    width: 80px;
    font-family: monospace;
    font-size: 0.875rem;
    color: var(--primary-color);
}

.command-bar {
    flex: 1;
    height: 8px;
    background-color: var(--bg-hover);
    border-radius: 4px;
    overflow: hidden;
}

.command-progress {
    height: 100%;
    background: linear-gradient(90deg, var(--primary-color), var(--primary-hover));
    border-radius: 4px;
    transition: width 0.5s ease;
}

.command-count {
    width: 60px;
    text-align: left;
    font-size: 0.875rem;
    color: var(--text-secondary);
}

/* ============================================
   SETTINGS - الإعدادات
   ============================================ */

.settings-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
    gap: 20px;
}

.settings-card {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    padding: 24px;
}

.settings-card h3 {
    font-size: 1.125rem;
    font-weight: 600;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
    color: var(--primary-color);
}

.settings-card h3 i {
    font-size: 1rem;
}

.setting-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 16px 0;
    border-bottom: 1px solid var(--border-color);
}

.setting-item:last-child {
    border-bottom: none;
}

.setting-item.vertical {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
}

.setting-info label {
    display: block;
    font-weight: 600;
    margin-bottom: 4px;
}

.setting-info p {
    font-size: 0.875rem;
    color: var(--text-secondary);
}

/* حقول الإدخال */
.prefix-input,
.setting-select,
.setting-textarea {
    background-color: var(--bg-hover);
    border: 1px solid var(--border-color);
    border-radius: var(--border-radius-sm);
    padding: 10px 14px;
    color: var(--text-primary);
    font-size: 0.9375rem;
    transition: all var(--transition-fast);
}

.prefix-input {
    width: 60px;
    text-align: center;
    font-family: monospace;
}

.setting-select {
    min-width: 150px;
    cursor: pointer;
}

.setting-textarea {
    width: 100%;
    resize: vertical;
    min-height: 100px;
}

.prefix-input:focus,
.setting-select:focus,
.setting-textarea:focus {
    outline: none;
    border-color: var(--primary-color);
}

/* Toggle Switch */
.toggle-switch {
    position: relative;
    width: 50px;
    height: 26px;
    cursor: pointer;
}

.toggle-switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.toggle-slider {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: var(--bg-hover);
    border-radius: 26px;
    transition: all var(--transition-fast);
}

.toggle-slider::before {
    content: '';
    position: absolute;
    height: 20px;
    width: 20px;
    right: 3px;
    bottom: 3px;
    background-color: white;
    border-radius: 50%;
    transition: all var(--transition-fast);
}

.toggle-switch input:checked + .toggle-slider {
    background-color: var(--primary-color);
}

.toggle-switch input:checked + .toggle-slider::before {
    transform: translateX(-24px);
}

/* ============================================
   TABLES - الجداول
   ============================================ */

.commands-table-container {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    overflow: hidden;
}

.commands-table {
    width: 100%;
    border-collapse: collapse;
}

.commands-table th,
.commands-table td {
    padding: 16px;
    text-align: right;
}

.commands-table th {
    background-color: var(--bg-hover);
    font-weight: 600;
    font-size: 0.875rem;
    color: var(--text-secondary);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.commands-table tbody tr {
    border-bottom: 1px solid var(--border-color);
    transition: all var(--transition-fast);
}

.commands-table tbody tr:hover {
    background-color: var(--bg-hover);
}

.commands-table tbody tr:last-child {
    border-bottom: none;
}

.commands-table code {
    background-color: var(--bg-hover);
    padding: 4px 8px;
    border-radius: 4px;
    font-family: monospace;
    font-size: 0.875rem;
    color: var(--primary-color);
}

.status-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
}

.status-badge.active {
    background-color: rgba(67, 181, 129, 0.2);
    color: var(--success);
}

.status-badge.inactive {
    background-color: rgba(240, 71, 71, 0.2);
    color: var(--danger);
}

.action-icon {
    width: 32px;
    height: 32px;
    border-radius: var(--border-radius-sm);
    background-color: transparent;
    color: var(--text-secondary);
    margin: 0 4px;
    transition: all var(--transition-fast);
}

.action-icon:hover {
    background-color: var(--bg-hover);
}

.action-icon.edit:hover {
    color: var(--primary-color);
}

.action-icon.delete:hover {
    color: var(--danger);
}

/* ============================================
   USERS - المستخدمين
   ============================================ */

.users-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
}

.user-card {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    overflow: hidden;
    transition: all var(--transition-fast);
}

.user-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-lg);
}

.user-card-header {
    position: relative;
    padding: 24px;
    text-align: center;
    background: linear-gradient(135deg, var(--primary-color), var(--purple));
}

.user-card-avatar {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    border: 4px solid var(--bg-card);
}

.user-status {
    position: absolute;
    bottom: 20px;
    right: calc(50% - 40px + 60px);
    width: 16px;
    height: 16px;
    border-radius: 50%;
    border: 3px solid var(--bg-card);
}

.user-status.online {
    background-color: var(--success);
}

.user-card-body {
    padding: 20px;
    text-align: center;
}

.user-card-body h4 {
    font-size: 1.125rem;
    margin-bottom: 4px;
}

.user-tag {
    color: var(--text-secondary);
    font-size: 0.875rem;
}

.user-stats {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 16px;
    padding-top: 16px;
    border-top: 1px solid var(--border-color);
}

.user-stats span {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 0.875rem;
    color: var(--text-secondary);
}

.user-card-footer {
    padding: 16px 20px;
    display: flex;
    gap: 12px;
    border-top: 1px solid var(--border-color);
}

.btn-small {
    flex: 1;
    padding: 10px;
    border-radius: var(--border-radius-sm);
    background-color: var(--primary-color);
    color: white;
    font-size: 0.875rem;
    font-weight: 500;
    transition: all var(--transition-fast);
}

.btn-small:hover {
    background-color: var(--primary-hover);
}

.btn-small.danger {
    background-color: transparent;
    color: var(--danger);
    border: 1px solid var(--danger);
}

.btn-small.danger:hover {
    background-color: var(--danger);
    color: white;
}

/* ============================================
   SERVERS - السيرفرات
   ============================================ */

.servers-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.server-item {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 16px;
    transition: all var(--transition-fast);
}

.server-item:hover {
    border: 1px solid var(--border-color);
}

.server-icon {
    width: 56px;
    height: 56px;
    border-radius: var(--border-radius-sm);
}

.server-info {
    flex: 1;
}

.server-info h4 {
    font-size: 1.125rem;
    margin-bottom: 4px;
}

.server-info span {
    color: var(--text-secondary);
    font-size: 0.875rem;
}

.server-actions {
    display: flex;
    gap: 12px;
}

.btn-outline {
    padding: 10px 20px;
    border-radius: var(--border-radius-sm);
    border: 1px solid var(--border-color);
    background-color: transparent;
    color: var(--text-primary);
    font-size: 0.875rem;
    transition: all var(--transition-fast);
}

.btn-outline:hover {
    background-color: var(--bg-hover);
}

.btn-outline.danger {
    color: var(--danger);
    border-color: var(--danger);
}

.btn-outline.danger:hover {
    background-color: var(--danger);
    color: white;
}

/* ============================================
   LOGS - السجلات
   ============================================ */

.logs-container {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.log-item {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 16px;
    background-color: var(--bg-hover);
    border-radius: var(--border-radius-sm);
}

.log-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.875rem;
}

.log-icon.success {
    background-color: rgba(67, 181, 129, 0.2);
    color: var(--success);
}

.log-icon.warning {
    background-color: rgba(250, 166, 26, 0.2);
    color: var(--warning);
}

.log-icon.error {
    background-color: rgba(240, 71, 71, 0.2);
    color: var(--danger);
}

.log-content {
    flex: 1;
}

.log-content p {
    margin-bottom: 4px;
}

.log-time {
    font-size: 0.75rem;
    color: var(--text-muted);
}

/* ============================================
   NOTIFICATIONS - الإشعارات
   ============================================ */

.notifications-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.notification-item {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 16px;
    transition: all var(--transition-fast);
    position: relative;
}

.notification-item.unread {
    border-right: 3px solid var(--primary-color);
}

.notification-item:hover {
    background-color: var(--bg-hover);
}

.notification-icon {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background-color: var(--primary-light);
    color: var(--primary-color);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.125rem;
}

.notification-content {
    flex: 1;
}

.notification-content h4 {
    font-size: 1rem;
    margin-bottom: 4px;
}

.notification-content p {
    font-size: 0.875rem;
    color: var(--text-secondary);
    margin-bottom: 4px;
}

.notification-time {
    font-size: 0.75rem;
    color: var(--text-muted);
}

.notification-dismiss {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    color: var(--text-muted);
    transition: all var(--transition-fast);
}

.notification-dismiss:hover {
    background-color: var(--bg-card);
    color: var(--danger);
}

/* ============================================
   RESPONSIVE DESIGN - التصميم المتجاوب
   ============================================ */

@media (max-width: 1024px) {
    .sidebar {
        width: var(--sidebar-collapsed);
    }
    
    .sidebar .bot-name,
    .sidebar .bot-status,
    .sidebar .nav-text,
    .sidebar .user-info,
    .sidebar .badge {
        display: none;
    }
    
    .sidebar-header {
        padding: 16px 10px;
    }
    
    .bot-logo {
        width: 48px;
        height: 48px;
    }
    
    .nav-link {
        justify-content: center;
        padding: 16px;
    }
    
    .nav-icon {
        margin: 0;
    }
    
    .sidebar-footer {
        justify-content: center;
    }
    
    .user-profile {
        display: none;
    }
    
    .main-content {
        margin-right: var(--sidebar-collapsed);
    }
}

@media (max-width: 768px) {
    .sidebar {
        transform: translateX(100%);
        width: var(--sidebar-width);
    }
    
    .sidebar.open {
        transform: translateX(0);
    }
    
    .sidebar .bot-name,
    .sidebar .bot-status,
    .sidebar .nav-text,
    .sidebar .user-info,
    .sidebar .badge {
        display: block;
    }
    
    .nav-link {
        justify-content: flex-start;
        padding: 14px 16px;
    }
    
    .main-content {
        margin-right: 0;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
    }
    
    .charts-row {
        grid-template-columns: 1fr;
    }
    
    .settings-container {
        grid-template-columns: 1fr;
    }
    
    .commands-table {
        font-size: 0.875rem;
    }
    
    .commands-table th,
    .commands-table td {
        padding: 12px;
    }
}

/* ============================================
   SCROLLBAR - شريط التمرير
   ============================================ */

::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

::-webkit-scrollbar-track {
    background: var(--bg-darker);
}

::-webkit-scrollbar-thumb {
    background: var(--border-color);
    border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
    background: var(--text-muted);
}

/* ============================================
   SELECTION - تحديد النص
   ============================================ */

::selection {
    background-color: var(--primary-color);
    color: white;
}
```

---

## التنقل بين الأقسام

### شرح آلية التنقل

التنقل بين أقسام الداشبورد يتم باستخدام JavaScript. هناك عدة طرق لتحقيق ذلك:

#### الطريقة 1: إظهار/إخفاء الأقسام (الأكثر شيوعاً)

```javascript
// app.js - نظام التنقل الأساسي

// انتظار تحميل الصفحة
document.addEventListener('DOMContentLoaded', function() {
    
    // ===== 1. اختيار العناصر =====
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('.content-section');
    const pageTitle = document.getElementById('pageTitle');
    
    // ===== 2. إضافة مستمعي الأحداث =====
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault(); // منع السلوك الافتراضي للرابط
            
            // الحصول على اسم القسم المستهدف
            const targetSection = this.getAttribute('data-section');
            
            // تغيير القسم النشط
            switchSection(targetSection);
            
            // تحديث القائمة النشطة
            updateActiveNav(this);
            
            // تحديث عنوان الصفحة
            updatePageTitle(this);
        });
    });
    
    // ===== 3. دالة تبديل الأقسام =====
    function switchSection(sectionName) {
        // إخفاء جميع الأقسام
        sections.forEach(section => {
            section.classList.remove('active');
        });
        
        // إظهار القسم المستهدف
        const targetSection = document.getElementById(sectionName + '-section');
        if (targetSection) {
            targetSection.classList.add('active');
            
            // إضافة تأثير حركة
            targetSection.style.animation = 'none';
            setTimeout(() => {
                targetSection.style.animation = 'fadeIn 0.3s ease';
            }, 10);
        }
        
        // حفظ القسم الحالي في localStorage
        localStorage.setItem('currentSection', sectionName);
    }
    
    // ===== 4. دالة تحديث القائمة النشطة =====
    function updateActiveNav(clickedLink) {
        // إزالة النشاط من جميع العناصر
        navLinks.forEach(link => {
            link.parentElement.classList.remove('active');
        });
        
        // إضافة النشاط للعنصر المضغوط
        clickedLink.parentElement.classList.add('active');
    }
    
    // ===== 5. دالة تحديث عنوان الصفحة =====
    function updatePageTitle(clickedLink) {
        const text = clickedLink.querySelector('.nav-text').textContent;
        pageTitle.textContent = text;
        
        // تحديث عنوان المتصفح
        document.title = text + ' | داشبورد البوت';
    }
    
    // ===== 6. استعادة القسم الأخير =====
    const savedSection = localStorage.getItem('currentSection');
    if (savedSection) {
        const savedLink = document.querySelector(`[data-section="${savedSection}"]`);
        if (savedLink) {
            savedLink.click();
        }
    }
    
});
```

#### الطريقة 2: استخدام Hash في URL

```javascript
// نظام التنقل مع تحديث URL

class NavigationManager {
    constructor() {
        this.sections = document.querySelectorAll('.content-section');
        this.navLinks = document.querySelectorAll('.nav-link');
        this.init();
    }
    
    init() {
        // مستمع تغيير الـ hash
        window.addEventListener('hashchange', () => this.handleHashChange());
        
        // التحميل الأولي
        this.handleHashChange();
        
        // إضافة مستمعي الأحداث للروابط
        this.navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const hash = link.getAttribute('href');
                window.location.hash = hash;
            });
        });
    }
    
    handleHashChange() {
        const hash = window.location.hash || '#dashboard';
        const sectionName = hash.replace('#', '');
        
        this.showSection(sectionName);
        this.updateActiveNav(hash);
        this.updateTitle(sectionName);
    }
    
    showSection(sectionName) {
        this.sections.forEach(section => {
            section.classList.remove('active');
        });
        
        const target = document.getElementById(sectionName + '-section');
        if (target) {
            target.classList.add('active');
        }
    }
    
    updateActiveNav(hash) {
        this.navLinks.forEach(link => {
            link.parentElement.classList.remove('active');
            if (link.getAttribute('href') === hash) {
                link.parentElement.classList.add('active');
            }
        });
    }
    
    updateTitle(sectionName) {
        const titles = {
            'dashboard': 'لوحة التحكم',
            'settings': 'الإعدادات',
            'commands': 'الأوامر',
            'users': 'المستخدمين',
            'statistics': 'الإحصائيات',
            'servers': 'السيرفرات',
            'logs': 'السجلات',
            'notifications': 'الإشعارات'
        };
        
        document.title = (titles[sectionName] || 'داشبورد') + ' | Bot Dashboard';
    }
}

// استخدام الكلاس
const navManager = new NavigationManager();
```

#### الطريقة 3: استخدام History API (الأكثر احترافية)

```javascript
// نظام التنقل المتقدم مع History API

class AdvancedNavigation {
    constructor() {
        this.routes = {
            '/dashboard': { section: 'dashboard', title: 'لوحة التحكم' },
            '/settings': { section: 'settings', title: 'الإعدادات' },
            '/commands': { section: 'commands', title: 'الأوامر' },
            '/users': { section: 'users', title: 'المستخدمين' },
            '/statistics': { section: 'statistics', title: 'الإحصائيات' },
            '/servers': { section: 'servers', title: 'السيرفرات' },
            '/logs': { section: 'logs', title: 'السجلات' },
            '/notifications': { section: 'notifications', title: 'الإشعارات' }
        };
        
        this.init();
    }
    
    init() {
        // منع السلوك الافتراضي للروابط
        document.addEventListener('click', (e) => {
            if (e.target.matches('.nav-link') || e.target.closest('.nav-link')) {
                e.preventDefault();
                const link = e.target.matches('.nav-link') ? e.target : e.target.closest('.nav-link');
                const path = link.getAttribute('href');
                this.navigateTo(path);
            }
        });
        
        // مستخدمي زر الرجوع/التقدم
        window.addEventListener('popstate', () => {
            this.handleRoute(window.location.pathname);
        });
        
        // التحميل الأولي
        this.handleRoute(window.location.pathname);
    }
    
    navigateTo(path) {
        // تحديث الـ URL بدون إعادة تحميل
        window.history.pushState({}, '', path);
        this.handleRoute(path);
    }
    
    handleRoute(path) {
        const route = this.routes[path] || this.routes['/dashboard'];
        
        // إخفاء جميع الأقسام
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.remove('active');
        });
        
        // إظهار القسم المستهدف
        const targetSection = document.getElementById(route.section + '-section');
        if (targetSection) {
            targetSection.classList.add('active');
        }
        
        // تحديث القائمة النشطة
        document.querySelectorAll('.nav-link').forEach(link => {
            link.parentElement.classList.remove('active');
            if (link.getAttribute('href') === path) {
                link.parentElement.classList.add('active');
            }
        });
        
        // تحديث العنوان
        document.title = route.title + ' | Bot Dashboard';
        document.getElementById('pageTitle').textContent = route.title;
    }
}

// استخدام الكلاس
const advancedNav = new AdvancedNavigation();
```

---

## الأيقونات واستبدال الإيموجيات

### لماذا نستخدم أيقونات بدلاً من الإيموجيات؟

1. **الاتساق**: الأيقونات تظهر بنفس الشكل على جميع الأجهزة
2. **التحكم**: يمكن تغيير ألوان وأحجام الأيقونات بسهولة
3. **الأداء**: لا حاجة لتحميل خطوط الإيموجي
4. **الاحترافية**: مظهر أكثر احترافية

### خيارات الأيقونات المتاحة

#### 1. Font Awesome (الأكثر شيوعاً)

```html
<!-- إضافة Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- استخدام الأيقونات -->
<i class="fas fa-home"></i>        <!-- منزل -->
<i class="fas fa-cog"></i>         <!-- إعدادات -->
<i class="fas fa-users"></i>       <!-- مستخدمين -->
<i class="fas fa-chart-line"></i>  <!-- إحصائيات -->
<i class="fas fa-bell"></i>        <!-- إشعارات -->
<i class="fas fa-sign-out-alt"></i> <!-- خروج -->
```

**أهم فئات Font Awesome:**

```
fas = Solid (صلبة)
far = Regular (عادية)
fab = Brands (علامات تجارية)
```

#### 2. Material Icons

```html
<!-- إضافة Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- استخدام الأيقونات -->
<span class="material-icons">dashboard</span>
<span class="material-icons">settings</span>
<span class="material-icons">people</span>
```

#### 3. Heroicons

```html
<!-- SVG مباشر -->
<svg xmlns="http://www.w3.org/2000/svg" class="icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
</svg>
```

#### 4. Phosphor Icons

```html
<!-- إضافة Phosphor Icons -->
<script src="https://unpkg.com/@phosphor-icons/web"></script>

<!-- استخدام الأيقونات -->
<i class="ph ph-house"></i>
<i class="ph ph-gear"></i>
<i class="ph ph-users"></i>
```

### مكتبة الأيقونات الكاملة للداشبورد

```css
/* ===== CSS للأيقونات ===== */

.icon {
    width: 24px;
    height: 24px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.icon-sm {
    width: 16px;
    height: 16px;
    font-size: 16px;
}

.icon-md {
    width: 24px;
    height: 24px;
    font-size: 24px;
}

.icon-lg {
    width: 32px;
    height: 32px;
    font-size: 32px;
}

.icon-xl {
    width: 48px;
    height: 48px;
    font-size: 48px;
}

/* ألوان الأيقونات */
.icon-primary { color: var(--primary-color); }
.icon-success { color: var(--success); }
.icon-warning { color: var(--warning); }
.icon-danger { color: var(--danger); }
.icon-info { color: var(--info); }
```

### جدول الأيقونات المناسبة لكل قسم

| القسم | Font Awesome | Material Icons |
|-------|--------------|----------------|
| لوحة التحكم | `fa-chart-line` | `dashboard` |
| الإعدادات | `fa-cog` | `settings` |
| الأوامر | `fa-terminal` | `code` |
| المستخدمين | `fa-users` | `people` |
| الإحصائيات | `fa-chart-bar` | `bar_chart` |
| السيرفرات | `fa-server` | `dns` |
| السجلات | `fa-history` | `history` |
| الإشعارات | `fa-bell` | `notifications` |
| البحث | `fa-search` | `search` |
| الوضع الليلي | `fa-moon` | `dark_mode` |
| الوضع النهاري | `fa-sun` | `light_mode` |
| الخروج | `fa-sign-out-alt` | `logout` |
| المستخدم | `fa-user` | `person` |
| الحظر | `fa-ban` | `block` |
| الحذف | `fa-trash` | `delete` |
| التعديل | `fa-edit` | `edit` |
| الحفظ | `fa-save` | `save` |
| الإضافة | `fa-plus` | `add` |
| الرجوع | `fa-arrow-right` | `arrow_back` |
| التحديث | `fa-sync` | `refresh` |

---

## JavaScript للتفاعل

### ملف app.js الكامل

```javascript
/**
 * ============================================
 * BOT DASHBOARD - JAVASCRIPT
 * ============================================
 */

// ===== الكلاس الرئيسي للداشبورد =====
class BotDashboard {
    constructor() {
        this.currentSection = 'dashboard';
        this.sidebarOpen = false;
        this.darkMode = true;
        
        this.init();
    }
    
    init() {
        this.initNavigation();
        this.initSidebar();
        this.initTheme();
        this.initCharts();
        this.loadData();
    }
    
    // ===== نظام التنقل =====
    initNavigation() {
        const navLinks = document.querySelectorAll('.nav-link');
        const sections = document.querySelectorAll('.content-section');
        
        navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                
                const targetSection = link.getAttribute('data-section');
                this.switchSection(targetSection);
                this.updateActiveNav(link);
                this.updatePageTitle(link);
                
                // إغلاق السايدبار في الموبايل
                if (window.innerWidth <= 768) {
                    this.closeSidebar();
                }
            });
        });
        
        // استعادة القسم الأخير
        const savedSection = localStorage.getItem('currentSection');
        if (savedSection) {
            const savedLink = document.querySelector(`[data-section="${savedSection}"]`);
            if (savedLink) {
                savedLink.click();
            }
        }
    }
    
    switchSection(sectionName) {
        const sections = document.querySelectorAll('.content-section');
        
        sections.forEach(section => {
            section.classList.remove('active');
        });
        
        const targetSection = document.getElementById(sectionName + '-section');
        if (targetSection) {
            targetSection.classList.add('active');
            this.animateSection(targetSection);
        }
        
        this.currentSection = sectionName;
        localStorage.setItem('currentSection', sectionName);
    }
    
    animateSection(section) {
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            section.style.transition = 'all 0.3s ease';
            section.style.opacity = '1';
            section.style.transform = 'translateY(0)';
        }, 50);
    }
    
    updateActiveNav(clickedLink) {
        document.querySelectorAll('.nav-item').forEach(item => {
            item.classList.remove('active');
        });
        clickedLink.parentElement.classList.add('active');
    }
    
    updatePageTitle(clickedLink) {
        const text = clickedLink.querySelector('.nav-text').textContent;
        document.getElementById('pageTitle').textContent = text;
        document.title = `${text} | داشبورد البوت`;
    }
    
    // ===== إدارة الشريط الجانبي =====
    initSidebar() {
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.getElementById('sidebar');
        
        menuToggle.addEventListener('click', () => {
            this.toggleSidebar();
        });
        
        // إغلاق السايدبار عند النقر خارجها في الموبايل
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 768 && 
                !sidebar.contains(e.target) && 
                !menuToggle.contains(e.target) && 
                this.sidebarOpen) {
                this.closeSidebar();
            }
        });
    }
    
    toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        this.sidebarOpen = !this.sidebarOpen;
        sidebar.classList.toggle('open', this.sidebarOpen);
    }
    
    closeSidebar() {
        const sidebar = document.getElementById('sidebar');
        this.sidebarOpen = false;
        sidebar.classList.remove('open');
    }
    
    // ===== نظام الثيم =====
    initTheme() {
        const themeToggle = document.getElementById('themeToggle');
        
        // استعادة الثيم المحفوظ
        const savedTheme = localStorage.getItem('darkMode');
        if (savedTheme !== null) {
            this.darkMode = savedTheme === 'true';
            this.applyTheme();
        }
        
        themeToggle.addEventListener('click', () => {
            this.darkMode = !this.darkMode;
            this.applyTheme();
            localStorage.setItem('darkMode', this.darkMode);
        });
    }
    
    applyTheme() {
        const themeToggle = document.getElementById('themeToggle');
        
        if (this.darkMode) {
            document.body.classList.remove('light-mode');
            themeToggle.classList.remove('fa-sun');
            themeToggle.classList.add('fa-moon');
        } else {
            document.body.classList.add('light-mode');
            themeToggle.classList.remove('fa-moon');
            themeToggle.classList.add('fa-sun');
        }
    }
    
    // ===== الرسوم البيانية =====
    initCharts() {
        this.initActivityChart();
        this.initServerGrowthChart();
    }
    
    initActivityChart() {
        const ctx = document.getElementById('activityChart');
        if (!ctx) return;
        
        // بيانات تجريبية
        const data = {
            labels: ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00'],
            datasets: [{
                label: 'الأوامر',
                data: [12, 19, 8, 25, 32, 45],
                borderColor: '#5865F2',
                backgroundColor: 'rgba(88, 101, 242, 0.1)',
                fill: true,
                tension: 0.4
            }]
        };
        
        // رسم بياني بسيط باستخدام Canvas
        this.drawSimpleChart(ctx, data);
    }
    
    drawSimpleChart(canvas, data) {
        const ctx = canvas.getContext('2d');
        const width = canvas.width = canvas.offsetWidth;
        const height = canvas.height = canvas.offsetHeight;
        
        // مساحة الرسم
        const padding = 40;
        const chartWidth = width - padding * 2;
        const chartHeight = height - padding * 2;
        
        // مسح Canvas
        ctx.clearRect(0, 0, width, height);
        
        // رسم الخطوط
        ctx.strokeStyle = '#363636';
        ctx.lineWidth = 1;
        
        // خطوط أفقية
        for (let i = 0; i <= 5; i++) {
            const y = padding + (chartHeight / 5) * i;
            ctx.beginPath();
            ctx.moveTo(padding, y);
            ctx.lineTo(width - padding, y);
            ctx.stroke();
        }
        
        // رسم البيانات
        const maxValue = Math.max(...data.datasets[0].data);
        const points = data.datasets[0].data.map((value, index) => ({
            x: padding + (chartWidth / (data.labels.length - 1)) * index,
            y: padding + chartHeight - (value / maxValue) * chartHeight
        }));
        
        // رسم المنحنى
        ctx.strokeStyle = data.datasets[0].borderColor;
        ctx.lineWidth = 3;
        ctx.beginPath();
        ctx.moveTo(points[0].x, points[0].y);
        
        for (let i = 1; i < points.length; i++) {
            const xc = (points[i].x + points[i - 1].x) / 2;
            const yc = (points[i].y + points[i - 1].y) / 2;
            ctx.quadraticCurveTo(points[i - 1].x, points[i - 1].y, xc, yc);
        }
        
        ctx.lineTo(points[points.length - 1].x, points[points.length - 1].y);
        ctx.stroke();
        
        // رسم النقاط
        ctx.fillStyle = data.datasets[0].borderColor;
        points.forEach(point => {
            ctx.beginPath();
            ctx.arc(point.x, point.y, 6, 0, Math.PI * 2);
            ctx.fill();
        });
    }
    
    initServerGrowthChart() {
        // يمكن إضافة رسم بياني آخر هنا
    }
    
    // ===== تحميل البيانات =====
    async loadData() {
        try {
            // محاكاة جلب البيانات من API
            const stats = await this.fetchStats();
            this.updateStats(stats);
        } catch (error) {
            console.error('Error loading data:', error);
        }
    }
    
    async fetchStats() {
        // في الواقع، هذا سيكون طلب fetch حقيقي
        return new Promise(resolve => {
            setTimeout(() => {
                resolve({
                    servers: 150,
                    users: 12450,
                    commands: 45,
                    uptime: 99.9
                });
            }, 500);
        });
    }
    
    updateStats(stats) {
        // تحديث الأرقام في البطاقات
        const statNumbers = document.querySelectorAll('.stat-number');
        if (statNumbers[0]) statNumbers[0].textContent = stats.servers;
        if (statNumbers[1]) statNumbers[1].textContent = stats.users.toLocaleString();
        if (statNumbers[2]) statNumbers[2].textContent = stats.commands;
        if (statNumbers[3]) statNumbers[3].textContent = stats.uptime + '%';
    }
}

// ===== دوال مساعدة =====

function logout() {
    // مسح البيانات المحفوظة
    localStorage.removeItem('currentSection');
    localStorage.removeItem('darkMode');
    
    // إعادة توجيه لصفحة تسجيل الدخول
    window.location.href = '/login';
}

function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification-toast ${type}`;
    notification.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'times-circle' : 'info-circle'}"></i>
        <span>${message}</span>
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('show');
    }, 100);
    
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// ===== تهيئة الداشبورد =====
document.addEventListener('DOMContentLoaded', () => {
    window.dashboard = new BotDashboard();
});
```

---

## ربط الداشبورد مع البوت

### هيكل المشروع الكامل

```
project/
├── client/                    # الواجهة الأمامية
│   ├── index.html
│   ├── styles.css
│   ├── app.js
│   └── assets/
│       ├── images/
│       └── icons/
│
├── server/                    # الخلفية
│   ├── index.js
│   ├── routes/
│   │   ├── auth.js
│   │   ├── bot.js
│   │   └── api.js
│   ├── middleware/
│   │   └── auth.js
│   └── config/
│       └── database.js
│
├── bot/                       # بوت Discord
│   ├── index.js
│   ├── commands/
│   │   ├── moderation.js
│   │   ├── fun.js
│   │   └── utility.js
│   ├── events/
│   │   ├── ready.js
│   │   └── messageCreate.js
│   └── config.js
│
└── package.json
```

### خادم Express الأساسي

```javascript
// server/index.js

const express = require('express');
const cors = require('cors');
const session = require('express-session');
const passport = require('passport');
const DiscordStrategy = require('passport-discord').Strategy;

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('client'));

// Session
app.use(session({
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: false
}));

// Passport Discord OAuth2
passport.use(new DiscordStrategy({
    clientID: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    callbackURL: 'http://localhost:3000/auth/discord/callback',
    scope: ['identify', 'guilds']
}, (accessToken, refreshToken, profile, done) => {
    return done(null, profile);
}));

passport.serializeUser((user, done) => done(null, user));
passport.deserializeUser((obj, done) => done(null, obj));

app.use(passport.initialize());
app.use(passport.session());

// Routes
app.get('/auth/discord', passport.authenticate('discord'));

app.get('/auth/discord/callback', 
    passport.authenticate('discord', { failureRedirect: '/' }),
    (req, res) => res.redirect('/dashboard')
);

// API Routes
app.get('/api/stats', async (req, res) => {
    // جلب إحصائيات البوت
    res.json({
        servers: 150,
        users: 12450,
        commands: 45,
        uptime: 99.9
    });
});

app.get('/api/guilds', (req, res) => {
    if (!req.user) return res.status(401).json({ error: 'Unauthorized' });
    res.json(req.user.guilds);
});

app.listen(3000, () => {
    console.log('Server running on http://localhost:3000');
});
```

### بوت Discord

```javascript
// bot/index.js

const { Client, GatewayIntentBits } = require('discord.js');

const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent
    ]
});

client.on('ready', () => {
    console.log(`Logged in as ${client.user.tag}`);
});

client.on('messageCreate', (message) => {
    if (message.author.bot) return;
    
    if (message.content === '!ping') {
        message.reply('Pong! 🏓');
    }
});

client.login('YOUR_BOT_TOKEN');

// تصدير للخادم
module.exports = client;
```

---

## أمثلة عملية كاملة

### مثال 1: زر يفتح نافذة منبثقة

```html
<!-- HTML -->
<button class="btn-primary" onclick="openModal('settingsModal')">
    <i class="fas fa-cog"></i>
    فتح الإعدادات
</button>

<div id="settingsModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>الإعدادات</h3>
            <button class="close-btn" onclick="closeModal('settingsModal')">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <!-- محتوى النافذة -->
        </div>
    </div>
</div>
```

```css
/* CSS */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 2000;
    align-items: center;
    justify-content: center;
}

.modal.active {
    display: flex;
}

.modal-content {
    background-color: var(--bg-card);
    border-radius: var(--border-radius);
    width: 90%;
    max-width: 500px;
    animation: modalSlide 0.3s ease;
}

@keyframes modalSlide {
    from {
        opacity: 0;
        transform: translateY(-50px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.modal-header {
    padding: 20px;
    border-bottom: 1px solid var(--border-color);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-body {
    padding: 20px;
}

.close-btn {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    color: var(--text-secondary);
    transition: all 0.2s;
}

.close-btn:hover {
    background-color: var(--bg-hover);
    color: var(--danger);
}
```

```javascript
// JavaScript
function openModal(modalId) {
    document.getElementById(modalId).classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('active');
    document.body.style.overflow = '';
}

// إغلاق النافذة عند النقر خارجها
document.querySelectorAll('.modal').forEach(modal => {
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.classList.remove('active');
        }
    });
});

// إغلاق بزر Escape
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        document.querySelectorAll('.modal.active').forEach(modal => {
            modal.classList.remove('active');
        });
    }
});
```

### مثال 2: نموذج إرسال بيانات

```html
<form id="settingsForm" class="settings-form">
    <div class="form-group">
        <label for="botName">اسم البوت</label>
        <input type="text" id="botName" name="botName" required>
    </div>
    
    <div class="form-group">
        <label for="botPrefix">بادئة الأوامر</label>
        <input type="text" id="botPrefix" name="botPrefix" value="!" maxlength="3">
    </div>
    
    <div class="form-group">
        <label for="botLanguage">اللغة</label>
        <select id="botLanguage" name="botLanguage">
            <option value="ar">العربية</option>
            <option value="en">English</option>
        </select>
    </div>
    
    <button type="submit" class="btn-primary">
        <i class="fas fa-save"></i>
        حفظ الإعدادات
    </button>
</form>
```

```javascript
document.getElementById('settingsForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData);
    
    try {
        const response = await fetch('/api/settings', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        
        if (response.ok) {
            showNotification('تم حفظ الإعدادات بنجاح!', 'success');
        } else {
            throw new Error('Failed to save');
        }
    } catch (error) {
        showNotification('حدث خطأ أثناء الحفظ', 'error');
    }
});
```

### مثال 3: تحديث البيانات في الوقت الفعلي مع WebSocket

```javascript
// إنشاء اتصال WebSocket
const ws = new WebSocket('ws://localhost:3000');

ws.onopen = () => {
    console.log('Connected to WebSocket');
};

ws.onmessage = (event) => {
    const data = JSON.parse(event.data);
    
    switch(data.type) {
        case 'stats':
            updateStats(data.payload);
            break;
        case 'notification':
            showNotification(data.payload.message);
            break;
        case 'log':
            addLogEntry(data.payload);
            break;
    }
};

ws.onerror = (error) => {
    console.error('WebSocket error:', error);
};

// إرسال بيانات
function sendCommand(command, data) {
    ws.send(JSON.stringify({
        type: command,
        payload: data
    }));
}
```

---

## نصائح وأفضل الممارسات

### 1. الأداء

```javascript
// استخدام Debounce للأحداث المتكررة
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// مثال: البحث
const searchInput = document.getElementById('search');
searchInput.addEventListener('input', debounce((e) => {
    performSearch(e.target.value);
}, 300));
```

### 2. الأمان

```javascript
// تطهير المدخلات
function sanitizeInput(input) {
    const div = document.createElement('div');
    div.textContent = input;
    return div.innerHTML;
}

// التحقق من CSRF Token
async function apiRequest(url, options = {}) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    
    return fetch(url, {
        ...options,
        headers: {
            ...options.headers,
            'X-CSRF-Token': csrfToken
        }
    });
}
```

### 3. التخزين المحلي

```javascript
// كائن للتعامل مع localStorage
const Storage = {
    set(key, value) {
        try {
            localStorage.setItem(key, JSON.stringify(value));
        } catch (e) {
            console.error('Storage error:', e);
        }
    },
    
    get(key, defaultValue = null) {
        try {
            const item = localStorage.getItem(key);
            return item ? JSON.parse(item) : defaultValue;
        } catch (e) {
            return defaultValue;
        }
    },
    
    remove(key) {
        localStorage.removeItem(key);
    },
    
    clear() {
        localStorage.clear();
    }
};
```

### 4. إدارة الأخطاء

```javascript
// معالج الأخطاء العام
window.addEventListener('error', (e) => {
    console.error('Global error:', e.error);
    // إرسال الخطأ للخادم
    reportError(e.error);
});

// معالج الأخطاء غير الممسوكة
window.addEventListener('unhandledrejection', (e) => {
    console.error('Unhandled promise rejection:', e.reason);
    e.preventDefault();
});

function reportError(error) {
    fetch('/api/error', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            message: error.message,
            stack: error.stack,
            url: window.location.href,
            timestamp: new Date().toISOString()
        })
    });
}
```

---

## الخلاصة

هذا الدليل الشامل يغطي جميع جوانب بناء داشبورد Discord بوت احترافي:

1. **HTML**: هيكل صفحة منظم وقابل للتوسع
2. **CSS**: تصميم عصري مع دعم الوضع الليلي والتصميم المتجاوب
3. **JavaScript**: نظام تنقل متقدم وتفاعلات ديناميكية
4. **الأيقونات**: استخدام Font Awesome للأيقونات الاحترافية
5. **الربط**: ربط الداشبورد مع البوت عبر API

### الخطوات التالية

1. تخصيص الألوان حسب هوية البوت
2. إضافة المزيد من الأقسام حسب احتياجاتك
3. ربط الداشبورد مع قاعدة بيانات حقيقية
4. إضافة مصادقة Discord OAuth2
5. نشر المشروع على استضافة

---

**تم إعداد هذا الدليل بعناية لمساعدتك في بناء داشبورد احترافي لبوت Discord**

**بالتوفيق! 🚀**
