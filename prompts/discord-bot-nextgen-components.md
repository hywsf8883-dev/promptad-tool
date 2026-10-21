# 🧩 Next-Gen Components V2 & Advanced Interactions (2025/2026)
## بنية مكونات الديسكورد الحديثة: Containers, Sections, Galleries & Interactive Modals

---

### 📌 الثورة البرمجية لـ Components V2
تمثل **Components V2** النقلة الكبرى في واجهات بوتات ديسكورد، حيث تحل الحاويات (`Containers`) والمكونات المستقلة محل الـ Embeds التقليدية:
- **تحكم حر في التخطيط**: وضع الأزرار والقوائم في أي مكان داخل الرسالة وليس فقط في الأسفل.
- **تنسيق مرئي متعدد**: دمج النصوص مع الصور الجانبية عبر `SectionBuilder`، وعرض معارض الصور عبر `MediaGalleryBuilder`.
- **العلم الإلزامي**: تتطلب كل رسالة تستخدم هذا النظام إضافة علم `MessageFlags.IsComponentsV2`.

---

### 🛠️ المكونات الأساسية وطريقة استدعائها (Core Component Builders)

```javascript
const {
    ContainerBuilder,
    TextDisplayBuilder,
    SectionBuilder,
    ThumbnailBuilder,
    SeparatorBuilder,
    MediaGalleryBuilder,
    MediaItemBuilder,
    ActionRowBuilder,
    ButtonBuilder,
    ButtonStyle,
    MessageFlags
} = require('discord.js');
```

---

### 💻 نموذج كود تطبيقي كامل لرسالة Components V2 متقدمة
```javascript
module.exports = {
    data: {
        name: 'profile-v2',
        description: 'Displays a user profile using modern Components V2 layout'
    },
    async execute(interaction) {
        // 1. Text Section with User Avatar Thumbnail
        const userSection = new SectionBuilder()
            .setTextDisplayComponents(
                new TextDisplayBuilder()
                    .setContent(`## 👑 الملف الشخصي: ${interaction.user.username}\n**الرتبة**: VIP Platinum ⭐\n**المستوى**: 48 | **النقاط**: 14,250 XP`)
            )
            .setAccessoryComponents(
                new ThumbnailBuilder().setUrl(interaction.user.displayAvatarURL({ size: 256 }))
            );

        // 2. Visual Separator
        const separator = new SeparatorBuilder().setDivider(true);

        // 3. Stats & Details Text
        const statsDisplay = new TextDisplayBuilder()
            .setContent(`> 🛡️ **تاريخ الانضمام**: <t:${Math.floor(interaction.member.joinedTimestamp / 1000)}:R>\n> 💰 **الرصيد المالي**: 85,400 عملة\n> 🏆 **الإنجازات المكتملة**: 24 / 30`);

        // 4. Interactive Action Buttons
        const buttonRow = new ActionRowBuilder().addComponents(
            new ButtonBuilder()
                .setCustomId('claim_daily')
                .setLabel('استلام المكافأة اليومية')
                .setStyle(ButtonStyle.Success)
                .setEmoji('🎁'),
            new ButtonBuilder()
                .setCustomId('view_inventory')
                .setLabel('حقيبة العناصر')
                .setStyle(ButtonStyle.Primary)
                .setEmoji('🎒')
        );

        // 5. Main Root Container
        const container = new ContainerBuilder()
            .setAccentColor(0x5865F2)
            .addSectionComponents(userSection)
            .addSeparatorComponents(separator)
            .addTextDisplayComponents(statsDisplay)
            .addActionRowComponents(buttonRow);

        // 6. Send with Mandatory IsComponentsV2 Flag
        await interaction.reply({
            components: [container],
            flags: MessageFlags.IsComponentsV2
        });
    }
};
```

---

### 🚀 قواعد البرمجة والتنفيذ (Component Rules)
```text
[COMPONENTS_V2_DIRECTIVE: ACTIVE]
1. Never mix legacy EmbedBuilder with Components V2 in the same message.
2. Always apply flags: MessageFlags.IsComponentsV2 on interaction replies/edits.
3. Keep containers clean: max 10 sub-components per container.
4. Ensure all customIds in buttons/select menus follow structured namespaces: module:action:targetId (e.g., eco:daily:user).
5. Always provide responsive fallbacks if executing in older discord.js environments.
```
