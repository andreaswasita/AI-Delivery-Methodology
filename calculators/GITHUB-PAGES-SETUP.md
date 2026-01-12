# Deploying AI Calculators to GitHub Pages

Host your calculators website for **FREE** on GitHub Pages!

## 🚀 Quick Setup (3 Steps)

### Step 1: Enable GitHub Pages

1. Go to your repository: https://github.com/andreaswasita/AI-Delivery-Methodology
2. Click **Settings** (top right)
3. Click **Pages** (left sidebar)
4. Under **Source**, select:
   - Source: **GitHub Actions**
5. Click **Save**

**That's it for configuration!**

---

### Step 2: Trigger Deployment

The GitHub Action is already configured. Just:

```bash
git add .
git commit -m "Enable GitHub Pages deployment"
git push origin main
```

Or click **Actions** tab → **Deploy Calculators to GitHub Pages** → **Run workflow**

---

### Step 3: Access Your Website

After deployment (takes ~1-2 minutes), your site will be live at:

**https://andreaswasita.github.io/AI-Delivery-Methodology/**

Specific pages:
- Homepage: `https://andreaswasita.github.io/AI-Delivery-Methodology/`
- ROI Calculator: `https://andreaswasita.github.io/AI-Delivery-Methodology/roi-calculator.html`

---

## ✅ What's Configured

The GitHub Action (`.github/workflows/deploy-github-pages.yml`) automatically:
- ✅ Deploys on every push to `main` that changes `calculators/` files
- ✅ Can be manually triggered from the Actions tab
- ✅ Deploys the entire `calculators/` folder
- ✅ Provides the URL after deployment

---

## 🎯 Features

### Free & Unlimited
- **Cost**: $0 forever
- **Bandwidth**: Unlimited (within GitHub's fair use)
- **Storage**: 1 GB site size limit
- **SSL**: Automatic HTTPS
- **Uptime**: 99.9%+ (GitHub's infrastructure)

### Custom Domain (Optional)
1. Add a `CNAME` file to `calculators/` folder:
   ```
   calculators.yourdomain.com
   ```
2. Configure DNS with your domain provider:
   ```
   Type: CNAME
   Name: calculators
   Value: andreaswasita.github.io
   ```
3. In GitHub Settings → Pages → Custom domain, enter: `calculators.yourdomain.com`

---

## 🔄 Update Your Website

Every time you push changes to the `calculators/` folder:

```bash
# Make changes to your files
# Then commit and push
git add calculators/
git commit -m "Update calculator feature"
git push origin main
```

GitHub Actions will automatically deploy the changes in ~1-2 minutes!

---

## 🧪 Local Testing

Before pushing, test locally:

```bash
# Option 1: Python HTTP server
cd calculators
python -m http.server 8000

# Option 2: Node.js http-server
npx http-server calculators -p 8000

# Option 3: VS Code Live Server extension
# Right-click index.html → Open with Live Server
```

Then visit: http://localhost:8000

---

## 📊 Monitor Deployments

### View Deployment Status

1. Go to **Actions** tab: https://github.com/andreaswasita/AI-Delivery-Methodology/actions
2. Click on the latest workflow run
3. See deployment status and logs

### Check Live Site

```bash
curl -I https://andreaswasita.github.io/AI-Delivery-Methodology/
```

Should return `200 OK`

---

## 🔧 Troubleshooting

### Issue: 404 Page Not Found
**Cause**: GitHub Pages not enabled  
**Solution**: 
1. Go to Settings → Pages
2. Set Source to "GitHub Actions"
3. Re-run the workflow

### Issue: CSS/JS not loading
**Cause**: Incorrect paths in HTML  
**Solution**: All paths in HTML files should be relative:
- ✅ `href="css/styles.css"` 
- ✅ `src="js/roi-calculator.js"`
- ❌ `href="/css/styles.css"` (won't work with subpath)

### Issue: Workflow not running
**Cause**: Permissions not set  
**Solution**:
1. Settings → Actions → General
2. Workflow permissions → Select "Read and write permissions"
3. Check "Allow GitHub Actions to create and approve pull requests"
4. Save

### Issue: Old version still showing
**Cause**: Browser cache  
**Solution**: Hard refresh:
- Windows: `Ctrl + Shift + R`
- Mac: `Cmd + Shift + R`

---

## 🆚 GitHub Pages vs Azure Static Web Apps

| Feature | GitHub Pages | Azure Static Web Apps |
|---------|-------------|---------------------|
| **Cost** | FREE | FREE tier available |
| **Setup Time** | 1 minute | 5 minutes |
| **Custom Domain** | ✅ Free | ✅ Free (2 domains on free tier) |
| **SSL** | ✅ Automatic | ✅ Automatic |
| **Bandwidth** | Unlimited* | 100 GB/month (free tier) |
| **Deployment** | Git push | Git push or manual |
| **Best For** | Public sites | Public or private apps |

*Within GitHub's fair use policy (100 GB soft limit)

**Recommendation**: Use GitHub Pages for this calculator (it's perfect!)

---

## 📚 Additional Features

### Add Google Analytics

Add to your HTML `<head>`:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

### SEO Optimization

Already configured in your HTML files:
- ✅ Meta descriptions
- ✅ Title tags
- ✅ Semantic HTML

### Social Media Previews

Add to `<head>` for better sharing:

```html
<!-- Open Graph / Facebook -->
<meta property="og:type" content="website">
<meta property="og:url" content="https://andreaswasita.github.io/AI-Delivery-Methodology/">
<meta property="og:title" content="AI Project Calculators">
<meta property="og:description" content="Free tools for AI project planning and ROI analysis">
<meta property="og:image" content="https://andreaswasita.github.io/AI-Delivery-Methodology/preview.png">

<!-- Twitter -->
<meta property="twitter:card" content="summary_large_image">
<meta property="twitter:url" content="https://andreaswasita.github.io/AI-Delivery-Methodology/">
<meta property="twitter:title" content="AI Project Calculators">
<meta property="twitter:description" content="Free tools for AI project planning and ROI analysis">
<meta property="twitter:image" content="https://andreaswasita.github.io/AI-Delivery-Methodology/preview.png">
```

---

## 🎉 Summary

1. ✅ GitHub Action already configured
2. ✅ Enable GitHub Pages in repository settings
3. ✅ Push to main branch
4. ✅ Your site goes live automatically!

**Your future URL**: https://andreaswasita.github.io/AI-Delivery-Methodology/

---

**Questions?** Check the [GitHub Pages documentation](https://docs.github.com/en/pages)

**Last Updated**: January 13, 2026
