@echo off
chcp 65001 >nul

echo [1/3] 正在生成最新网页到 public 文件夹...
hugo --gc --minify

echo [2/3] 正在将所有源码备份到 main 分支...
git add .
git commit -m "Blog update"
git push origin main

echo [3/3] 魔法启动：单独将 public 文件夹发布到 gh-pages 分支...
git subtree push --prefix public origin gh-pages

echo.
echo ==============================================
echo   发布完成！请去 GitHub 设置一下 Pages 分支。
echo ==============================================
pause