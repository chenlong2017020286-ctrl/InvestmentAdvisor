# 🚀 投资顾问 - iOS股票行情监控应用

## ✅ 项目已成功部署到GitHub！

**仓库地址**: https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor

## 📦 下载IPA文件

### 方法1：直接从Releases下载（推荐）
1. 访问 https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor/releases
2. 下载最新的 `InvestmentAdvisor.ipa` 文件
3. 使用以下方式安装到iPhone：
   - **爱思助手**（推荐）
   - **AltStore**
   - **Xcode** 直接安装

### 方法2：手动触发CI/CD构建
由于GitHub Actions需要一些时间来识别workflow文件，请按以下步骤操作：

1. 访问: https://github.com/chenlong2017020286-ctrl/InvestmentAdvisor/actions
2. 点击 "Build iOS IPA" workflow
3. 点击 "Run workflow" 按钮
4. 选择 `main` 分支并点击运行
5. 等待构建完成（约5-10分钟）
6. 在Artifacts中下载生成的IPA文件

## 📱 功能特性

- 📈 **股票行情监控** - 实时显示股票价格、涨跌幅、成交量
- 💰 **基金行情监控** - 显示基金净值、估算净值、涨跌幅  
- 🎯 **模拟盘交易** - 支持买入/卖出股票，实时持仓管理
- 💵 **初始资金** - 10万元虚拟资金
- 📊 **盈亏统计** - 实时计算持仓盈亏

## 🔧 技术栈

- Swift 5
- UIKit
- Xcode
- GitHub Actions (CI/CD)

## 📥 安装说明

### iPhone安装步骤（需要已签名IPA）：

**方法一：使用爱思助手（最简单）**
1. 下载并安装爱思助手
2. 连接iPhone到电脑
3. 将IPA文件拖入爱思助手
4. 点击"安装"即可

**方法二：使用AltStore（免越狱）**
1. 下载AltServer并安装
2. 在电脑上登录Apple ID
3. 将IPA文件通过AltStore安装

**方法三：使用Xcode直接安装（开发测试）**
1. 在Mac上打开Xcode
2. 打开本项目 `InvestmentAdvisor.xcodeproj`
3. 连接iPhone并选择为目标设备
4. 编译运行即可

## ⚠️ 注意事项

1. **未签名IPA**: GitHub Actions构建的IPA是未签名版本，需要使用上述工具安装
2. **真机测试**: 如需在真机上长期使用，建议申请苹果开发者账号并配置签名证书
3. **数据模拟**: 本应用中的股票/基金数据为模拟数据，非真实行情

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

MIT License

---

**开发者**: chenlong2017020286-ctrl  
**创建时间**: 2026-05-13
