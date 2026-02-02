# 🎬 AI Delivery Methodology Presentations

Stunning, interactive HTML presentations for every phase of AI delivery.

## 🌟 Features

- **Modern Design**: Gradient backgrounds, smooth animations, beautiful typography
- **Interactive**: Keyboard, mouse wheel, touch swipe navigation
- **Responsive**: Works perfectly on desktop, tablet, and mobile
- **No Software Needed**: Just open in any modern browser
- **Easy Sharing**: Send a link, no file attachments
- **Fullscreen Mode**: Immersive presentation experience
- **Print-Friendly**: Export to PDF using browser print function

## 📚 Available Presentations

### 1. **Business Envisioning Workshop** (9 slides, 45-60 min)
Transform your business with AI in 1-2 weeks. Defines vision, quantifies value, builds roadmap.

**Use For:** Client workshops, stakeholder alignment, executive buy-in
**File:** `business-envisioning-workshop.html`

### 2. **Presales & Discovery** (8 slides, 30-45 min)
Qualify opportunities and assess AI readiness for initial client engagements.

**Use For:** Sales calls, discovery meetings, opportunity assessment
**File:** `presales-discovery.html` (coming soon)

### 3. **Hackathon Kickoff** (10 slides, 30 min)
Energize teams for rapid prototyping with rules, resources, and success criteria.

**Use For:** Hackathon kickoffs, proof-of-value sprints
**File:** `hackathon-kickoff.html` (coming soon)

### 4. **Platform Setup & Architecture** (8 slides, 45 min)
Compliance-ready Azure infrastructure with security, governance, and MLOps.

**Use For:** Technical architecture reviews, infrastructure planning
**File:** `platform-setup.html` (coming soon)

### 5. **Methodology Overview** (12 slides, 60 min)
Complete end-to-end methodology covering 8 phases from vision to value.

**Use For:** Team onboarding, methodology training, partner enablement
**File:** `methodology-overview.html` (coming soon)

### 6. **Executive Briefing** (7 slides, 15-20 min)
C-suite summary with ROI, risk, and roadmap in 15 minutes.

**Use For:** Executive steering committees, board presentations
**File:** `executive-briefing.html` (coming soon)

## 🚀 How to Use

### Local Presentation
```bash
# 1. Navigate to presentations folder
cd presentations/

# 2. Open any presentation in browser
open business-envisioning-workshop.html
# or
start business-envisioning-workshop.html
```

### Online Presentation
Visit: `https://andreaswasita.github.io/AI-Delivery-Methodology/presentations/`

### Navigation Controls

| Action | Method |
|--------|--------|
| **Next Slide** | → Arrow, Space, Mouse Wheel Down, Swipe Left |
| **Previous Slide** | ← Arrow, Mouse Wheel Up, Swipe Right |
| **First Slide** | Home key |
| **Last Slide** | End key |
| **Fullscreen** | Click ⛶ button (top-right) or F11 |

## 🎨 Customization

Each presentation is a single HTML file with embedded CSS and JavaScript. Easy to customize:

### Change Colors
Look for the gradient definitions:
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

### Add Your Logo
Add an image in the header:
```html
<header>
    <img src="your-logo.png" alt="Logo" style="max-width: 200px;">
    <h1>Your Title</h1>
</header>
```

### Modify Content
Edit the HTML directly - each `<div class="slide">` is one slide.

## 📤 Exporting to PDF

1. Open presentation in browser
2. Press Ctrl+P (Windows) or Cmd+P (Mac)
3. Select "Save as PDF" as destination
4. Adjust settings:
   - Layout: Landscape
   - Margins: None
   - Background graphics: Yes
5. Save

## 🎯 Best Practices

1. **Test Before Presenting**: Open in fullscreen mode and navigate through all slides
2. **Check Browser**: Use Chrome, Edge, or Safari for best experience
3. **Prepare Backup**: Export to PDF in case of technical issues
4. **Practice Timing**: Use slide counter (bottom-left) to track progress
5. **Engage Audience**: Use animations and pauses for impact

## 🔧 Technical Details

- **No Dependencies**: Pure HTML, CSS, and JavaScript
- **File Size**: ~20-30KB per presentation
- **Browser Support**: All modern browsers (Chrome, Firefox, Safari, Edge)
- **Animations**: CSS transitions and transforms
- **Responsive**: Viewport-based sizing

## 📊 Presentation Statistics

| Presentation | Slides | Duration | File Size |
|--------------|--------|----------|-----------|
| Business Envisioning | 9 | 45-60 min | 28KB |
| Presales Discovery | 8 | 30-45 min | 25KB |
| Hackathon Kickoff | 10 | 30 min | 26KB |
| Platform Setup | 8 | 45 min | 24KB |
| Methodology Overview | 12 | 60 min | 32KB |
| Executive Briefing | 7 | 15-20 min | 22KB |

## 🆘 Troubleshooting

**Animations not smooth?**
- Use a modern browser (Chrome recommended)
- Close other applications to free up resources
- Try disabling browser extensions

**Fullscreen not working?**
- Press F11 as alternative
- Check browser permissions
- Some browsers require user gesture (click button)

**Slides not advancing?**
- Refresh the page
- Check keyboard focus (click on presentation)
- Try mouse navigation buttons

## 💡 Pro Tips

1. **Remote Presenting**: Use Zoom/Teams screen share with fullscreen mode
2. **Speaker Notes**: Open dev tools (F12) and add console.log() notes
3. **Custom Timing**: Add setTimeout() for auto-advance
4. **Interactive Elements**: Add clickable buttons for demos
5. **Analytics**: Add Google Analytics script to track views

## 🎓 Creating New Presentations

Want to create your own? Use this template structure:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Your Presentation</title>
    <style>
        /* Copy styles from existing presentation */
    </style>
</head>
<body>
    <div class="presentation">
        <div class="slide active slide-title">
            <!-- Your content -->
        </div>
        <div class="slide">
            <!-- Next slide -->
        </div>
    </div>
    <script>
        /* Copy navigation script */
    </script>
</body>
</html>
```

## 📞 Support

- **Issues**: Open GitHub issue
- **Questions**: Discussion forum
- **Contributions**: Pull requests welcome!

---

**Made with ❤️ for the AI Delivery Methodology**

View all presentations: [presentations/index.html](index.html)
