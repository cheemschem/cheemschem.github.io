@echo off
:: 设置字符集为 UTF-8，防止命令行的中文变成乱码
chcp 65001 >nul

echo ==============================================
echo       Cheems 的博客 - 一键构建与发布脚本
echo ==============================================
echo.

echo [1/3] 正在清理旧文件并生成最新网页...
:: --gc 表示清理不再使用的无用文件，--minify 表示压缩网页体积，让加载更快
hugo --gc --minify
echo.

echo [2/3] 正在将变动添加到 Git...
git add .
echo.

echo [3/3] 正在提交并推送到云端仓库...
:: 自动用当前的日期和时间作为提交备注
set commit_msg=Blog update: %date:~0,10% %time:~0,8%
git commit -m "%commit_msg%"
git push origin main
:: 注意：如果你的默认分支叫 master 而不是 main，请把上面这行的 main 改成 master

echo.
echo ==============================================
echo   发布完成！稍等一两分钟即可在线上看到更新。
echo ==============================================
pause