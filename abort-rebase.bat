@echo off
cd /d c:\Users\anwasita\AI-Delivery-Methodology
echo Aborting rebase by removing rebase-merge directory...
rmdir /s /q .git\rebase-merge
del .git\REBASE_HEAD
del .git\.COMMIT_EDITMSG.swp
echo.
echo Checking status...
git status --short
echo.
echo Checking last commit...
git log --oneline -1
echo.
echo DONE
pause
