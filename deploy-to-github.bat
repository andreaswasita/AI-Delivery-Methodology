@echo off
echo ===================================
echo Fixing Git and Deploying to GitHub Pages
echo ===================================
echo.

cd /d c:\Users\anwasita\AI-Delivery-Methodology

echo Step 1: Cleaning up rebase state...
rmdir /s /q .git\rebase-merge 2>nul
del .git\REBASE_HEAD 2>nul
del .git\ORIG_HEAD 2>nul
echo Done.
echo.

echo Step 2: Checking current status...
git status
echo.

echo Step 3: Adding all files...
git add .
echo.

echo Step 4: Committing changes...
git commit -m "Add program governance framework and fix GitHub Pages deployment"
echo.

echo Step 5: Pushing to GitHub...
git push origin main --force-with-lease
echo.

echo Step 6: Verifying deployment...
timeout /t 3 /nobreak >nul
echo.
echo ===================================
echo Deployment Complete!
echo ===================================
echo.
echo Your site should be available at:
echo https://andreaswasita.github.io/AI-Delivery-Methodology/
echo.
echo Note: GitHub Pages may take 1-2 minutes to update.
echo.
pause
