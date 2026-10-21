# ⚡ Modern Discord Bot Architecture (2025/2026 Edition)
## التحديثات الكودية الجديدة والمعمارية الحديثة لبوتات Discord بـ discord.js v14+

---

### 📌 التحديثات البرمجية الجديدة (Modern Discord.js Core Updates)
يركز هذا البرومبت على أحدث الممارسات البرمجية المعتمدة لعام **2025/2026** لمكتبة `discord.js` (الإصدارات 14.18.0 وما بعدها):
1. **Gateway Intents & Partials المحدثة**: تحديد الـ Intents بدقة لمنع استهلاك الذاكرة وتفعيل الـ Partials للأحداث المباشرة (Direct Messages & Reactions).
2. **Autocomplete Interactions**: دعم الإكمال التلقائي الذكي داخل الأوامر عبر `interaction.respond()` مع تخزين مؤقت للنتائج الشائعة.
3. **Subcommands & SubcommandGroups**: تقسيم الأوامر الضخمة إلى مجموعات فرعية منظمة داخل مجلدات مستقلة لمنع تضخم الكود.
4. **PermissionFlagsBits الحديثة**: فحص الصلاحيات عبر الـ Bitfields الجديدة واستبدال النصوص القديمة المرفوضة في الإصدارات الحالية.
5. **Cooldown & Rate Limit Management**: نظام Cooldown متكامل قائم على `Collection<string, number>` لمنع استهلاك API Discord بشكل غير مدروس.

---

### 📂 الهيكل المعماري الموصى به للمشروع (Production Project Structure)
```text
discord-bot/
├── src/
│   ├── index.js                  # نقطة البداية وتشغيل العميل
│   ├── config.js                 # إعدادات البوت والبيئة
│   ├── handlers/                 # محركات تحميل الأوامر والأحداث
│   │   ├── commandHandler.js
│   │   ├── eventHandler.js
│   │   └── componentHandler.js
│   ├── commands/                 # الأوامر مقسمة حسب الفئات
│   │   ├── utility/
│   │   ├── moderation/
│   │   └── economy/
│   ├── events/                   # أحداث البوت (Client & Guild)
│   │   ├── client/ready.js
│   │   └── interactions/interactionCreate.js
│   └── utils/                    # دوال مساعدة ومكتبات مشتركة
│       ├── logger.js
│       └── cooldown.js
├── package.json
└── .env
```

---

### ⚙️ نموذج كود حديث لنقطة البداية (Modern Client Boilerplate)
```javascript
const { Client, GatewayIntentBits, Partials, Collection } = require('discord.js');
require('dotenv').config();

const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent,
        GatewayIntentBits.GuildMembers
    ],
    partials: [Partials.Message, Partials.Channel, Partials.Reaction],
    sweepers: {
        messages: { interval: 300, lifetime: 900 }
    }
});

client.commands = new Collection();
client.cooldowns = new Collection();

// Loading Handlers
['commandHandler', 'eventHandler', 'componentHandler'].forEach(handler => {
    require(`./src/handlers/${handler}`)(client);
});

// Process Error Safety
process.on('unhandledRejection', error => {
    console.error('Unhandled Rejection Caught:', error);
});
process.on('uncaughtException', error => {
    console.error('Uncaught Exception Caught:', error);
});

client.login(process.env.DISCORD_TOKEN);
```

---

### 🚀 قواعد البرمجة والتوجيه (Execution Directive)
```text
[DISCORD_MODERN_ARCH: ACTIVE]
1. Write 100% complete files with strict ES6+ / CommonJS syntax matching modern Node.js 22+.
2. Always validate permissions using PermissionFlagsBits and provide friendly ephemeral feedback.
3. Use deferReply() when operations may exceed 2.5 seconds (Database queries, external APIs).
4. Zero deprecated methods: No message.reply for slash commands, no outdated embed fields.
5. All handlers must support hot-reloading and modular file-based registration.
```
