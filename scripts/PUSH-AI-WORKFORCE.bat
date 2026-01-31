@echo off
echo ========================================
echo Pushing AI Workforce Use Case to GitHub
echo ========================================
echo.

cd /d "c:\Users\anwasita\AI-Delivery-Methodology"

echo Step 1: Aborting any stuck rebase...
git rebase --abort 2>nul

echo.
echo Step 2: Removing rebase state files...
if exist .git\rebase-merge rmdir /s /q .git\rebase-merge
if exist .git\REBASE_HEAD del /f /q .git\REBASE_HEAD
if exist .git\.COMMIT_EDITMSG.swp del /f /q .git\.COMMIT_EDITMSG.swp

echo.
echo Step 3: Checking current status...
git status --short

echo.
echo Step 4: Adding all files...
git add .

echo.
echo Step 5: Committing changes...
git commit -m "Add AI Workforce Agent365 use case and planning documentation" -m "- Add comprehensive AI Workforce use case (15,000+ words)" -m "- Add 10 specialized agent definitions (BA, PM, Data Analyst, Architect, Dev, Test, DevOps, Security, Risk, Compliance)" -m "- Add 5 agent orchestration patterns" -m "- Add planning and execution how-to guide" -m "- Add 90-day objectives planning template" -m "- Add long-range planning roadmap template" -m "- Add 5-10 minute executive pitch presentation" -m "- Update README with AI Workforce references"

echo.
echo Step 6: Pushing to GitHub...
git push origin main

echo.
echo ========================================
echo DONE!
echo ========================================
echo.
echo Check the file at:
echo https://github.com/andreaswasita/AI-Delivery-Methodology/blob/main/guides/industry-use-cases/ai-workforce-agent365-use-case.md
echo.
pause
