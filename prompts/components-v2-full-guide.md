# 🚀 الدليل الشامل لـ Discord.js Components V2
## برومت متكامل لتحويل أي ملف Embed عادي إلى Components V2

---

## 📌 أولاً: ما هو Components V2 ولماذا استُحدث؟

**Components V2** هو نظام مكونات رسائل جديد أطلقته Discord في **مارس 2025**، يُتيح للبوتات بناء رسائل كاملة من مكونات بصرية مترابطة بدلاً من الاعتماد على Embeds والنص العادي. النظام يُعطي تحكماً كاملاً في تخطيط الرسالة وترتيب العناصر داخلها.

### الفرق الجوهري بين النظامين:

| النقطة | النظام القديم | Components V2 |
|---|---|---|
| التخطيط | Embed + ActionRow في الأسفل فقط | حرية كاملة في ترتيب كل العناصر |
| النص | `content` أو `.setDescription()` | `TextDisplayBuilder` |
| الصور | `.setImage()` أو `.setThumbnail()` | `MediaGalleryBuilder` / `ThumbnailBuilder` |
| الألوان | `.setColor()` | `.setAccentColor()` على Container |
| الأزرار | فقط في آخر الرسالة | في أي مكان داخل الرسالة |
| Flag | لا يوجد | `MessageFlags.IsComponentsV2` **إلزامي** |

---

## ⚙️ ثانياً: متطلبات النظام والإصدارات

### 🔹 إصدار discord.js المطلوب
```
discord.js >= 14.18.0  ← الحد الأدنى لدعم Components V2
discord.js >= 14.19.3  ← الإصدار الموصى به (الأكثر استقراراً)
discord.js latest       ← الأفضل دائماً
```
> Components V2 أُضيف رسمياً في الإصدار **14.18.0** (أبريل 2025).

### تحديث discord.js:
```bash
npm install discord.js@latest
```

### 🔹 إصدار Node.js المطلوب
```
Node.js >= 22.12.0   ← المطلوب لأحدث إصدارات discord.js
```
للتحقق من إصدارك الحالي:
```bash
node -v
```

### 🔹 الحزم الاختيارية (لتحسين الأداء)
```bash
npm install zlib-sync     # ضغط WebSocket (أسرع)
npm install bufferutil    # اتصال WebSocket أسرع
```

### 🔹 ملخص package.json المطلوب
```json
{
  "dependencies": {
    "discord.js": "^14.19.3"
  },
  "engines": {
    "node": ">=22.12.0"
  }
}
```

---

## 📦 ثالثاً: شرح كل مكون بالتفصيل

### 1. 🗃️ ContainerBuilder — الحاوية الرئيسية

الـ Container هو بديل الـ Embed. يجمع المحتوى داخل صندوق مرئي مستدير الحواف مع شريط لوني جانبي اختياري.

```js
const { ContainerBuilder } = require('discord.js');

const container = new ContainerBuilder()
    .setAccentColor(0x5865F2)   // اللون الجانبي (اختياري) - بصيغة HEX
    .setSpoiler(false);          // إخفاء المحتوى كـ spoiler (اختياري)
```

**إضافة مكونات داخل Container:**
```js
container.addTextDisplayComponents(...)    // إضافة نص
container.addSeparatorComponents(...)      // إضافة فاصل
container.addMediaGalleryComponents(...)   // إضافة صور
container.addSectionComponents(...)        // إضافة قسم (نص + صورة جانبية)
container.addActionRowComponents(...)      // إضافة أزرار أو قائمة منسدلة داخل Container
```

> ⚠️ Container يستوعب حتى **10 مكونات** بداخله كحد أقصى.

---

### 2. 📝 TextDisplayBuilder — عرض النص

بديل `.setTitle()` و `.setDescription()` و `.setFooter()`.

```js
const { TextDisplayBuilder } = require('discord.js');

// عنوان كبير (H1)
new TextDisplayBuilder().setContent('# عنوان كبير')

// عنوان متوسط (H2)
new TextDisplayBuilder().setContent('## عنوان متوسط')

// عنوان صغير (H3)
new TextDisplayBuilder().setContent('### عنوان صغير')

// نص عادي
new TextDisplayBuilder().setContent('هذا نص وصفي عادي')

// نص Footer صغير (Subtext)
new TextDisplayBuilder().setContent('-# نص صغير مثل Footer')

// Bold و Italic
new TextDisplayBuilder().setContent('**Bold** و *Italic* و __Underline__')

// كود
new TextDisplayBuilder().setContent('`كود مضمّن` أو\n```js\nكود متعدد الأسطر\n```')

// نص متعدد الأسطر
new TextDisplayBuilder().setContent('سطر أول\nسطر ثاني\nسطر ثالث')
```

> ✅ يدعم **كل Markdown** المتاح في Discord بما في ذلك mentions.

---

### 3. ➖ SeparatorBuilder — الفاصل البصري

يُضاف بين العناصر لتحسين المظهر والتنظيم.

```js
const { SeparatorBuilder, SeparatorSpacingSize } = require('discord.js');

// فاصل مع خط مرئي ومسافة صغيرة
new SeparatorBuilder()
    .setDivider(true)                      // يظهر خط أفقي مرئي
    .setSpacing(SeparatorSpacingSize.Small) // مسافة صغيرة

// فاصل بدون خط ومسافة كبيرة (مسافة بيضاء فقط)
new SeparatorBuilder()
    .setDivider(false)
    .setSpacing(SeparatorSpacingSize.Large)
```

**قيم SeparatorSpacingSize:**
- `SeparatorSpacingSize.Small` ← مسافة صغيرة
- `SeparatorSpacingSize.Large` ← مسافة كبيرة

---

### 4. 🖼️ MediaGalleryBuilder — عرض الصور (بديل setImage)

```js
const { MediaGalleryBuilder, MediaGalleryItemBuilder } = require('discord.js');

// صورة واحدة
const gallery = new MediaGalleryBuilder().addItems(
    new MediaGalleryItemBuilder()
        .setURL('https://رابط-الصورة.png')
        .setDescription('وصف بديل للصورة') // اختياري - alt text
        .setSpoiler(false)                   // اختياري
);

// عدة صور (حتى 10 صور)
const multiGallery = new MediaGalleryBuilder().addItems(
    new MediaGalleryItemBuilder().setURL('https://صورة1.png'),
    new MediaGalleryItemBuilder().setURL('https://صورة2.png'),
    new MediaGalleryItemBuilder().setURL('https://صورة3.png')
);
```

> ⚠️ يجب أن يكون الرابط **عاماً (Public URL)** أو رابط من Discord CDN.

---

### 5. 📐 SectionBuilder — قسم (نص + صورة جانبية أو زر)

بديل `.setThumbnail()` — يعرض نصاً بجانب صورة مصغرة أو زر.

```js
const { SectionBuilder, TextDisplayBuilder, ThumbnailBuilder } = require('discord.js');

// قسم بنص وصورة جانبية (Thumbnail)
const section = new SectionBuilder()
    .addTextDisplayComponents(
        new TextDisplayBuilder().setContent('**عنوان القسم**'),
        new TextDisplayBuilder().setContent('وصف تفصيلي للقسم هنا') // يقبل حتى 3 TextDisplay
    )
    .setThumbnailAccessory(
        new ThumbnailBuilder()
            .setURL('https://رابط-الصورة.png')
            .setDescription('وصف بديل') // اختياري
    );

// قسم بنص وزر جانبي
const sectionWithButton = new SectionBuilder()
    .addTextDisplayComponents(
        new TextDisplayBuilder().setContent('اضغط الزر للمتابعة')
    )
    .setButtonAccessory(
        new ButtonBuilder()
            .setCustomId('my_button')
            .setLabel('اضغط هنا')
            .setStyle(ButtonStyle.Primary)
    );
```

> ⚠️ Section يقبل من **1 إلى 3** مكونات `TextDisplay` فقط.

---

### 6. 🎛️ ActionRowBuilder مع Buttons — الأزرار

**الأزرار لا تتغير** في بنيتها، فقط طريقة وضعها في الرسالة تغيرت.

```js
const { ActionRowBuilder, ButtonBuilder, ButtonStyle } = require('discord.js');

// إنشاء الأزرار
const btnPrimary = new ButtonBuilder()
    .setCustomId('btn_primary')
    .setLabel('زر أساسي')
    .setStyle(ButtonStyle.Primary)    // أزرق
    .setEmoji('✅')                   // اختياري
    .setDisabled(false);              // اختياري

const btnSecondary = new ButtonBuilder()
    .setCustomId('btn_secondary')
    .setLabel('زر ثانوي')
    .setStyle(ButtonStyle.Secondary); // رمادي

const btnSuccess = new ButtonBuilder()
    .setCustomId('btn_success')
    .setLabel('نجاح')
    .setStyle(ButtonStyle.Success);   // أخضر

const btnDanger = new ButtonBuilder()
    .setCustomId('btn_danger')
    .setLabel('خطر')
    .setStyle(ButtonStyle.Danger);    // أحمر

const btnLink = new ButtonBuilder()
    .setLabel('رابط خارجي')
    .setURL('https://discord.com')
    .setStyle(ButtonStyle.Link);      // رابط - لا يحتاج customId

// وضع الأزرار في ActionRow (حتى 5 أزرار في صف واحد)
const btnRow = new ActionRowBuilder().addComponents(
    btnPrimary, btnSecondary, btnSuccess, btnDanger
);
```

**أنواع ButtonStyle:**

| الاسم | اللون | ملاحظة |
|---|---|---|
| `ButtonStyle.Primary` | 🔵 أزرق | |
| `ButtonStyle.Secondary` | ⚪ رمادي | |
| `ButtonStyle.Success` | 🟢 أخضر | |
| `ButtonStyle.Danger` | 🔴 أحمر | |
| `ButtonStyle.Link` | 🔗 رمادي | يفتح رابط، لا يُصدر interaction |

---

### 7. 📋 ActionRowBuilder مع Select Menus — القوائم المنسدلة

القوائم المنسدلة تبقى داخل `ActionRowBuilder`، وكل `ActionRow` يحتوي على **قائمة واحدة فقط**.

#### أ) StringSelectMenu — قائمة خيارات نصية

```js
const {
    ActionRowBuilder,
    StringSelectMenuBuilder,
    StringSelectMenuOptionBuilder
} = require('discord.js');

const selectMenu = new StringSelectMenuBuilder()
    .setCustomId('my_select_menu')          // معرف فريد إلزامي
    .setPlaceholder('اختر خياراً...')      // النص الافتراضي قبل الاختيار
    .setMinValues(1)                         // الحد الأدنى للاختيارات (افتراضي: 1)
    .setMaxValues(1)                         // الحد الأقصى للاختيارات (1 = اختيار واحد فقط)
    .setDisabled(false)                      // تعطيل القائمة (اختياري)
    .addOptions(
        new StringSelectMenuOptionBuilder()
            .setLabel('الخيار الأول')       // النص الظاهر
            .setValue('option_1')            // القيمة المُرسلة للكود
            .setDescription('وصف الخيار')   // وصف اختياري يظهر تحت اللابل
            .setEmoji('⚒️')                  // إيموجي اختياري
            .setDefault(false),              // هل هذا الخيار محدد افتراضياً؟

        new StringSelectMenuOptionBuilder()
            .setLabel('الخيار الثاني')
            .setValue('option_2')
            .setEmoji('💍'),

        new StringSelectMenuOptionBuilder()
            .setLabel('الخيار الثالث')
            .setValue('option_3')
            .setEmoji('🏗️')
    );

const selectRow = new ActionRowBuilder().addComponents(selectMenu);
```

> ⚠️ القائمة تستوعب من **1 إلى 25 خياراً** كحد أقصى.

#### ب) UserSelectMenu — اختيار مستخدم

```js
const { ActionRowBuilder, UserSelectMenuBuilder } = require('discord.js');

const userSelect = new UserSelectMenuBuilder()
    .setCustomId('user_select')
    .setPlaceholder('اختر مستخدماً')
    .setMinValues(1)
    .setMaxValues(1);

const userRow = new ActionRowBuilder().addComponents(userSelect);
```

#### ج) RoleSelectMenu — اختيار رول

```js
const { ActionRowBuilder, RoleSelectMenuBuilder } = require('discord.js');

const roleSelect = new RoleSelectMenuBuilder()
    .setCustomId('role_select')
    .setPlaceholder('اختر رولاً');

const roleRow = new ActionRowBuilder().addComponents(roleSelect);
```

#### د) ChannelSelectMenu — اختيار قناة

```js
const { ActionRowBuilder, ChannelSelectMenuBuilder, ChannelType } = require('discord.js');

const channelSelect = new ChannelSelectMenuBuilder()
    .setCustomId('channel_select')
    .setPlaceholder('اختر قناة')
    .addChannelTypes(ChannelType.GuildText); // تصفية حسب نوع القناة (اختياري)

const channelRow = new ActionRowBuilder().addComponents(channelSelect);
```

---

## 🔧 رابعاً: كيفية وضع الأزرار والقوائم في الرسالة

### الطريقة 1 — خارج Container (في مستوى الرسالة)

الأكثر شيوعاً، الـ ActionRow يكون في نفس مستوى الـ Container:

```js
await message.reply({
    components: [
        container,      // الـ Container مع المحتوى
        selectRow,      // القائمة المنسدلة
        btnRow          // الأزرار
    ],
    flags: MessageFlags.IsComponentsV2
});
```

### الطريقة 2 — داخل Container

يمكن وضع ActionRow **داخل** Container مباشرة باستخدام `.addActionRowComponents()`:

```js
const container = new ContainerBuilder()
    .setAccentColor(0x5865F2)
    .addTextDisplayComponents(
        new TextDisplayBuilder().setContent('## اختر من القائمة')
    )
    .addSeparatorComponents(
        new SeparatorBuilder().setDivider(true).setSpacing(SeparatorSpacingSize.Small)
    )
    .addActionRowComponents(selectRow)   // القائمة داخل Container
    .addSeparatorComponents(
        new SeparatorBuilder().setDivider(false).setSpacing(SeparatorSpacingSize.Small)
    )
    .addActionRowComponents(btnRow);     // الأزرار داخل Container

await message.reply({
    components: [container],
    flags: MessageFlags.IsComponentsV2
});
```

---

## 🔄 خامساً: كيفية التعامل مع التفاعلات (Collectors)

### Collector للأزرار والقوائم (بدون تغيير)

```js
const collector = msg.createMessageComponentCollector({
    filter: i => i.user.id === message.author.id, // فقط صاحب الأمر
    time: 60_000 // 60 ثانية
});

collector.on('collect', async interaction => {

    // التعامل مع القائمة المنسدلة
    if (interaction.isStringSelectMenu()) {
        const selectedValue = interaction.values[0]; // الخيار المختار
        console.log('اختار المستخدم:', selectedValue);
    }

    // التعامل مع الأزرار
    if (interaction.isButton()) {
        const buttonId = interaction.customId;
        console.log('ضغط المستخدم الزر:', buttonId);
    }

    // تحديث الرسالة بـ Container جديد
    const newContainer = new ContainerBuilder()
        .setAccentColor(0x00ff00)
        .addTextDisplayComponents(
            new TextDisplayBuilder().setContent('## تم التحديث ✅')
        );

    // ⚠️ إلزامي: الـ flag في كل update
    await interaction.update({
        components: [newContainer, selectRow],
        flags: MessageFlags.IsComponentsV2
    });
});

// إيقاف المكونات بعد انتهاء الوقت
collector.on('end', () => {
    selectMenu.setDisabled(true);
    const disabledRow = new ActionRowBuilder().addComponents(selectMenu);
    
    // ⚠️ إلزامي: الـ flag في edit
    msg.edit({
        components: [container, disabledRow],
        flags: MessageFlags.IsComponentsV2
    }).catch(() => {});
});
```

---

## ⚠️ سادساً: القواعد الإلزامية التي لا تُخالَف

### 1. `MessageFlags.IsComponentsV2` في كل مكان
```js
// ✅ صح
await message.reply({ components: [...], flags: MessageFlags.IsComponentsV2 });
await interaction.update({ components: [...], flags: MessageFlags.IsComponentsV2 });
await msg.edit({ components: [...], flags: MessageFlags.IsComponentsV2 });

// ❌ خطأ — سيُرسل كـ Legacy بدون Flags
await message.reply({ components: [...] });
```

### 2. لا تخلط Embeds مع V2 في نفس الرسالة
```js
// ❌ خطأ — embeds لا يعمل مع IsComponentsV2
await message.reply({
    embeds: [embed],
    components: [container],
    flags: MessageFlags.IsComponentsV2
});

// ✅ صح — استخدم Container بدلاً عن Embed
await message.reply({
    components: [container],
    flags: MessageFlags.IsComponentsV2
});
```

### 3. لا تُرسل content مع IsComponentsV2
```js
// ❌ خطأ — content لا يظهر مع IsComponentsV2
await message.reply({
    content: 'هذا النص لن يظهر',
    components: [container],
    flags: MessageFlags.IsComponentsV2
});

// ✅ صح — استخدم TextDisplay بدلاً عن content
```

### 4. بمجرد إرسال IsComponentsV2 لا يمكن إزالته
```
⚠️ بعد ما ترسل الرسالة بالـ Flag ده، مش ممكن تعدلها وتشيله.
الرسالة بتفضل V2 للأبد.
```

### 5. كل interactive component يحتاج customId فريد
```js
// ❌ خطأ — نفس الـ customId على مكونين
new ButtonBuilder().setCustomId('btn_ok')
new ButtonBuilder().setCustomId('btn_ok') // مكرر!

// ✅ صح
new ButtonBuilder().setCustomId('btn_confirm')
new ButtonBuilder().setCustomId('btn_cancel')
```

### 6. ActionRow يحتوي على نوع واحد فقط
```js
// ❌ خطأ — لا تخلط زر وقائمة في نفس ActionRow
const row = new ActionRowBuilder().addComponents(button, selectMenu); // خطأ!

// ✅ صح — كل نوع في ActionRow منفصل
const btnRow = new ActionRowBuilder().addComponents(button1, button2);
const selectRow = new ActionRowBuilder().addComponents(selectMenu);
```

### 7. حد 5 أزرار لكل ActionRow وقائمة واحدة فقط
```
ActionRow ← أقصى 5 أزرار
ActionRow ← قائمة واحدة فقط (Select Menu)
```

---

## 📋 سابعاً: الـ Imports الكاملة لكل المكونات

```js
const {
    // ===== Layout =====
    ActionRowBuilder,       // حاوية الأزرار والقوائم
    ContainerBuilder,       // الحاوية الرئيسية البديل للـ Embed
    SectionBuilder,         // قسم يجمع نص + صورة جانبية أو زر

    // ===== Content (عرض المحتوى) =====
    TextDisplayBuilder,     // عرض النص (بديل setTitle/setDescription/setFooter)
    SeparatorBuilder,       // الفاصل البصري
    SeparatorSpacingSize,   // حجم الفاصل (Small / Large)
    MediaGalleryBuilder,    // عرض الصور (بديل setImage)
    MediaGalleryItemBuilder,// عنصر صورة واحدة داخل Gallery
    ThumbnailBuilder,       // صورة مصغرة جانبية (بديل setThumbnail)

    // ===== Interactive (تفاعلي) =====
    ButtonBuilder,          // الأزرار
    ButtonStyle,            // أنماط الأزرار
    StringSelectMenuBuilder,        // قائمة منسدلة نصية
    StringSelectMenuOptionBuilder,  // عنصر خيار داخل القائمة
    UserSelectMenuBuilder,          // قائمة اختيار مستخدم
    RoleSelectMenuBuilder,          // قائمة اختيار رول
    ChannelSelectMenuBuilder,       // قائمة اختيار قناة
    ChannelType,                    // أنواع القنوات (للتصفية)

    // ===== Flags =====
    MessageFlags,           // ⚠️ إلزامي — يحتوي على IsComponentsV2

    // ===== Misc =====
    ComponentType,          // أنواع المكونات
    EmbedBuilder,           // ❌ لا تستخدمه مع V2
} = require('discord.js');
```

---

## 💡 ثامناً: مثال كامل شامل (Select Menu + Buttons داخل وخارج Container)

```js
const {
    ActionRowBuilder, ContainerBuilder, TextDisplayBuilder,
    SeparatorBuilder, SeparatorSpacingSize, MediaGalleryBuilder,
    MediaGalleryItemBuilder, ButtonBuilder, ButtonStyle,
    StringSelectMenuBuilder, StringSelectMenuOptionBuilder,
    MessageFlags
} = require('discord.js');

module.exports = {
    name: 'مثال',
    async execute(message, args) {

        // ==============================
        // بناء الـ Container الرئيسي
        // ==============================
        const mainContainer = new ContainerBuilder()
            .setAccentColor(0x5865F2)
            .addTextDisplayComponents(
                new TextDisplayBuilder().setContent('## 🎮 لوحة التحكم')
            )
            .addSeparatorComponents(
                new SeparatorBuilder().setDivider(true).setSpacing(SeparatorSpacingSize.Small)
            )
            .addTextDisplayComponents(
                new TextDisplayBuilder().setContent(
                    '⚒️ **الأوامر العامة** — متاحة للجميع\n' +
                    '💍 **أوامر الزواج** — خاص بالأزواج\n' +
                    '✨ **الإدارة** — للمشرفين فقط'
                )
            )
            .addSeparatorComponents(
                new SeparatorBuilder().setDivider(true).setSpacing(SeparatorSpacingSize.Small)
            )
            .addTextDisplayComponents(
                new TextDisplayBuilder().setContent(`-# طلب بواسطة: ${message.author.username}`)
            );

        // ==============================
        // القائمة المنسدلة
        // ==============================
        const selectMenu = new StringSelectMenuBuilder()
            .setCustomId('main_select')
            .setPlaceholder('اختر قسماً...')
            .addOptions(
                new StringSelectMenuOptionBuilder()
                    .setLabel('الأوامر العامة').setValue('general').setEmoji('⚒️'),
                new StringSelectMenuOptionBuilder()
                    .setLabel('أوامر الزواج').setValue('marriage').setEmoji('💍'),
                new StringSelectMenuOptionBuilder()
                    .setLabel('الإدارة').setValue('admin').setEmoji('✨')
            );

        const selectRow = new ActionRowBuilder().addComponents(selectMenu);

        // ==============================
        // أزرار التنقل
        // ==============================
        const btnRow = new ActionRowBuilder().addComponents(
            new ButtonBuilder()
                .setCustomId('prev_page')
                .setEmoji('⬅️')
                .setStyle(ButtonStyle.Secondary),
            new ButtonBuilder()
                .setCustomId('next_page')
                .setEmoji('➡️')
                .setStyle(ButtonStyle.Secondary),
            new ButtonBuilder()
                .setCustomId('close')
                .setLabel('إغلاق')
                .setStyle(ButtonStyle.Danger)
        );

        // ==============================
        // إرسال الرسالة — ⚠️ Flag إلزامي
        // ==============================
        const msg = await message.reply({
            components: [mainContainer, selectRow, btnRow],
            flags: MessageFlags.IsComponentsV2
        });

        // ==============================
        // Collector للتفاعلات
        // ==============================
        const collector = msg.createMessageComponentCollector({
            filter: i => i.user.id === message.author.id,
            time: 120_000
        });

        let currentPage = 0;
        let currentCategory = 'general';

        collector.on('collect', async interaction => {

            // التعامل مع القائمة المنسدلة
            if (interaction.isStringSelectMenu()) {
                currentCategory = interaction.values[0];
                currentPage = 0;
            }

            // التعامل مع الأزرار
            if (interaction.isButton()) {
                if (interaction.customId === 'close') {
                    collector.stop('closed');
                    return;
                }
                if (interaction.customId === 'prev_page') currentPage--;
                if (interaction.customId === 'next_page') currentPage++;
            }

            // بناء Container جديد بناءً على الاختيار
            const titles = {
                general: '⚒️ الأوامر العامة',
                marriage: '💍 أوامر الزواج',
                admin: '✨ أوامر الإدارة'
            };

            const updatedContainer = new ContainerBuilder()
                .setAccentColor(0x5865F2)
                .addTextDisplayComponents(
                    new TextDisplayBuilder().setContent(`## ${titles[currentCategory]}`)
                )
                .addSeparatorComponents(
                    new SeparatorBuilder().setDivider(true).setSpacing(SeparatorSpacingSize.Small)
                )
                .addTextDisplayComponents(
                    new TextDisplayBuilder().setContent(`لا توجد أوامر بعد في هذا القسم.\nالصفحة: ${currentPage + 1}`)
                )
                .addSeparatorComponents(
                    new SeparatorBuilder().setDivider(true).setSpacing(SeparatorSpacingSize.Small)
                )
                .addTextDisplayComponents(
                    new TextDisplayBuilder().setContent(`-# طلب بواسطة: ${message.author.username}`)
                );

            // ⚠️ Flag إلزامي في update
            await interaction.update({
                components: [updatedContainer, selectRow, btnRow],
                flags: MessageFlags.IsComponentsV2
            });
        });

        // إيقاف المكونات عند انتهاء الوقت أو الإغلاق
        collector.on('end', (_, reason) => {
            selectMenu.setDisabled(true);
            const disabledSelect = new ActionRowBuilder().addComponents(selectMenu);

            const closedContainer = new ContainerBuilder()
                .setAccentColor(0xff0000)
                .addTextDisplayComponents(
                    new TextDisplayBuilder().setContent('## ❌ انتهت الجلسة')
                )
                .addTextDisplayComponents(
                    new TextDisplayBuilder().setContent('-# استخدم الأمر مرة أخرى للتفاعل')
                );

            // ⚠️ Flag إلزامي في edit
            msg.edit({
                components: [closedContainer, disabledSelect],
                flags: MessageFlags.IsComponentsV2
            }).catch(() => {});
        });
    }
};
```

---

## 🗺️ تاسعاً: خريطة المكونات — أين يُوضع كل شيء؟

```
📨 الرسالة (components: [...])
│
├── 🗃️ ContainerBuilder          ← حاوية مرئية (بديل Embed)
│   ├── 📝 TextDisplayBuilder    ← نص (title / description / footer)
│   ├── ➖ SeparatorBuilder      ← فاصل بصري
│   ├── 🖼️ MediaGalleryBuilder   ← صور (بديل setImage)
│   ├── 📐 SectionBuilder        ← نص + Thumbnail جانبي
│   │   ├── 📝 TextDisplayBuilder (1 إلى 3)
│   │   └── 🖼️ ThumbnailBuilder أو 🔘 ButtonBuilder
│   └── 🎛️ ActionRowBuilder      ← أزرار أو قائمة داخل Container
│       ├── 🔘 ButtonBuilder (حتى 5)
│       └── 📋 SelectMenuBuilder (واحدة فقط)
│
├── 📝 TextDisplayBuilder        ← نص مستقل خارج Container
├── ➖ SeparatorBuilder          ← فاصل خارج Container
│
└── 🎛️ ActionRowBuilder          ← أزرار أو قائمة خارج Container
    ├── 🔘 ButtonBuilder (حتى 5)
    └── 📋 SelectMenuBuilder (واحدة فقط)
```

---

## 📊 عاشراً: الحدود القصوى (Limits)

| المكون | الحد الأقصى |
|---|---|
| Container → عدد المكونات بداخله | 10 مكونات |
| ActionRow → عدد الأزرار | 5 أزرار |
| ActionRow → Select Menus | 1 قائمة فقط |
| StringSelect → عدد الخيارات | 25 خياراً |
| Section → عدد TextDisplay | من 1 إلى 3 |
| MediaGallery → عدد الصور | حتى 10 صور |
| customId → عدد الحروف | حتى 100 حرف |
| ActionRows في رسالة V2 | غير محدود (مقارنة بـ 5 في Legacy) |
