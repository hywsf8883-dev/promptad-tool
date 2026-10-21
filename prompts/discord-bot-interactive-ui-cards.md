# 🎛️ Discord Interactive Cards & Widget Systems
## تصميم وتطوير البطاقات التفاعلية، أنظمة الصفحات، ولوحات التحكم المصغرة داخل ديسكورد

---

### 📌 مفهوم البطاقات التفاعلية (Micro-Dashboard Widgets)
البطاقة التفاعلية داخل ديسكورد هي واجهة متكاملة تمكن العضو أو المشرف من إنجاز المهام دون مغادرة التطبيق:
1. **نظام التنقل بالصفحات (Pagination Engine)**:
   - التنقل بين صفحات القوائم الطويلة (المتصدرين، المتجر، السجلات) بسلاسة مع مؤشر ديناميكي `صفحة 1 من 6`.
2. **لوحة التحكم الموسيقية (Music Player Controller)**:
   - شريط تقدم مباشر، أزرار إيقاف مؤقت، تخطي، إعادة، وتعديل مستوى الصوت.
3. **نظام التذاكر المتقدم (Interactive Ticket Widget)**:
   - إنشاء تذكرة عبر القوائم المنسدلة، تعيين المشرفين، وقفل التذكرة مع تصدير Transcript.
4. **نظام المتجر والحقيبة (Shop & Inventory Grid)**:
   - استعراض الأسلحة أو الرتب، واختيار العنصر من `StringSelectMenu` وتأكيد الشراء بـ Modal منبثق.

---

### 💻 كود تطبيقي كامل لنظام صفحات تفاعلي حديث (Modern Pagination Engine)
```javascript
const { ActionRowBuilder, ButtonBuilder, ButtonStyle, ComponentType } = require('discord.js');

async function createInteractivePagination(interaction, pages, timeoutMs = 120000) {
    if (!pages || pages.length === 0) return;
    if (pages.length === 1) {
        return interaction.reply({ ...pages[0], fetchReply: true });
    }

    let currentPage = 0;

    const getButtons = (pageIndex) => {
        return new ActionRowBuilder().addComponents(
            new ButtonBuilder()
                .setCustomId('btn_first')
                .setLabel('⏮️ البداية')
                .setStyle(ButtonStyle.Secondary)
                .setDisabled(pageIndex === 0),
            new ButtonBuilder()
                .setCustomId('btn_prev')
                .setLabel('◀️ السابق')
                .setStyle(ButtonStyle.Primary)
                .setDisabled(pageIndex === 0),
            new ButtonBuilder()
                .setCustomId('btn_page_num')
                .setLabel(`${pageIndex + 1} / ${pages.length}`)
                .setStyle(ButtonStyle.Secondary)
                .setDisabled(true),
            new ButtonBuilder()
                .setCustomId('btn_next')
                .setLabel('التالي ▶️')
                .setStyle(ButtonStyle.Primary)
                .setDisabled(pageIndex === pages.length - 1),
            new ButtonBuilder()
                .setCustomId('btn_last')
                .setLabel('النهاية ⏭️')
                .setStyle(ButtonStyle.Secondary)
                .setDisabled(pageIndex === pages.length - 1)
        );
    };

    const initialMessage = await interaction.reply({
        ...pages[currentPage],
        components: [getButtons(currentPage)],
        fetchReply: true
    });

    const collector = initialMessage.createMessageComponentCollector({
        componentType: ComponentType.Button,
        time: timeoutMs,
        filter: (i) => i.user.id === interaction.user.id
    });

    collector.on('collect', async (i) => {
        if (i.customId === 'btn_first') currentPage = 0;
        else if (i.customId === 'btn_prev') currentPage = Math.max(0, currentPage - 1);
        else if (i.customId === 'btn_next') currentPage = Math.min(pages.length - 1, currentPage + 1);
        else if (i.customId === 'btn_last') currentPage = pages.length - 1;

        await i.update({
            ...pages[currentPage],
            components: [getButtons(currentPage)]
        });
    });

    collector.on('end', async () => {
        // Disable buttons on timeout
        const disabledRow = new ActionRowBuilder().addComponents(
            getButtons(currentPage).components.map(btn => ButtonBuilder.from(btn).setDisabled(true))
        );
        await interaction.editReply({ components: [disabledRow] }).catch(() => null);
    });
}

module.exports = { createInteractivePagination };
```

---

### 🚀 توجيه التنفيذ للذكاء الاصطناعي (Interactive Widgets Directive)
```text
[INTERACTIVE_WIDGETS: ACTIVE]
1. Always handle interaction collectors with proper timeouts and auto-disable inactive buttons.
2. Filter collector events by interaction.user.id to prevent other members from hijacking the menu.
3. For destructive actions (Kick, Ban, Reset Data), always display a secondary confirmation button row (Confirm / Cancel).
4. For multi-step forms, prioritize Modals with TextInputBuilder over multiple chat messages.
```
