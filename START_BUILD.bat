@echo off
echo ========================================
echo  投资顾问 iOS应用 - CI/CD 启动器
echo ========================================
echo.
echo 正在检查GitHub认证状态...
gh auth status
echo.
echo 仓库信息：
gh repo view chenlong2017020286-ctrl/InvestmentAdvisor --json name,url
echo.
echo ========================================
echo  重要提示
echo ========================================
echo.
echo 由于GitHub Actions需要首次手动激活，
echo 请在浏览器中执行以下操作：
echo.
echo 1. 打开以下链接：
echo    https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor/actions
echo.
echo 2. 点击 "Build iOS IPA" workflow
echo.
echo 3. 点击 "Run workflow" 按钮（绿色）
echo.
echo 4. Branch选择 main，然后点击运行
echo.
echo 5. 等待5-10分钟构建完成
echo.
echo 6. 构建成功后，点击构建任务，
echo    在底部下载 "InvestmentAdvisor-IPA"
echo.
echo ========================================
echo.
pause
