# 🎯 GitHub Actions CI/CD 设置指南

## ✅ 已完成的工作

1. ✅ 创建了GitHub仓库: https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor
2. ✅ 上传了完整的iOS项目代码
3. ✅ 创建了GitHub Actions workflow文件 (build.yml)
4. ✅ 配置了自动构建和发布流程

## 📋 手动触发构建（重要！）

由于某些GitHub配置可能需要首次手动激活，请按以下步骤操作：

### 方法1：通过网页操作（推荐）

1. **打开Actions页面**
   访问: https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor/actions

2. **启用Workflow**
   - 如果看到 "Workflows aren't being run on this repository yet" 提示
   - 点击 "enable it on your account" 或类似按钮
   - 或者直接点击左侧的 "Build iOS IPA" workflow

3. **运行构建**
   - 点击 "Run workflow" 按钮（绿色）
   - Branch选择: `main`
   - 点击绿色 "Run workflow" 确认

4. **等待构建完成**
   - 预计时间: 5-10分钟
   - 状态会显示为黄色（运行中）→ 绿色（成功）

5. **下载IPA**
   - 构建成功后，点击构建任务
   - 在页面底部找到 "Artifacts" 部分
   - 点击 "InvestmentAdvisor-IPA" 下载IPA文件

### 方法2：推送代码触发

在本地修改任意文件并推送，GitHub Actions会自动触发构建：

```bash
# 添加一个测试文件
echo "test" > test.txt

# 提交并推送
git add .
git commit -m "Trigger CI/CD build"
git push origin master
```

## 📱 安装IPA到iPhone

下载IPA后，使用以下方式安装：

### 方式一：爱思助手（最简单）⭐推荐
1. 下载爱思助手: https://www.i4.cn
2. 连接iPhone
3. 将IPA文件拖入爱思助手
4. 点击安装

### 方式二：AltStore（免越狱）
1. 下载AltServer: https://altstore.io
2. 安装AltServer到电脑
3. 使用AltStore安装IPA

### 方式三：Xcode直接安装
如果你有Mac和Xcode，可以直接打开项目编译运行

## 🔧 GitHub Actions 配置说明

构建工作流包含以下步骤：

1. **Checkout** - 检出代码
2. **Setup Xcode** - 配置Xcode环境
3. **Build project** - 编译iOS项目
4. **Build IPA** - 打包成IPA文件
5. **Export IPA** - 导出IPA
6. **Upload artifact** - 上传构建产物
7. **Create Release** - 创建GitHub Release（自动发布）

## ⚠️ 重要提示

1. **未签名IPA**: GitHub Actions构建的是未签名IPA，需要使用第三方工具安装
2. **免费账户限制**: GitHub免费账户有使用限额，但构建iOS应用通常足够
3. **构建时间**: macos-latest 运行器可能需要等待队列
4. **签名证书**: 如需正式发布，需要配置苹果开发者证书

## 🆘 常见问题

**Q: 为什么Actions没有显示？**
A: GitHub可能需要几分钟来识别新的workflow文件，请稍等或手动访问Actions页面

**Q: 构建失败了怎么办？**
A: 点击失败的workflow，查看日志，通常是Xcode版本或模拟器问题

**Q: 如何获取正式签名的IPA？**
A: 需要配置苹果开发者账号和签名证书，或使用第三方签名服务

## 📞 需要帮助？

如有问题，请访问:
- GitHub仓库: https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor
- Issues页面: https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor/issues
