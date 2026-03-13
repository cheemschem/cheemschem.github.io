@echo off
chcp 65001 >nul

:: 自动获取你当前的 GitHub 仓库连接地址（非常关键）
for /f "tokens=2" %%i in ('git remote -v ^| findstr "(push)"') do set GIT_URL=%%i

echo [1/3] 正在清理并生成最新网页...
hugo --gc --minify

echo [2/3] 正在备份你的博客源码到 main 分支...
git add .
git commit -m "Backup blog source"
git push origin main

echo [3/3] 正在将 public 网页强行推送到 gh-pages 分支...
cd public
git init
git checkout -b gh-pages
git add .
git commit -m "Deploy to gh-pages"
:: 强行覆盖线上的 gh-pages 分支
git push -f %GIT_URL% gh-pages
cd ..

echo.
echo ==============================================
echo   部署成功！那只讨人厌的 404 应该马上就要消失了！
echo ==============================================
pause