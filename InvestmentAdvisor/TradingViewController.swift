import UIKit

class TradingViewController: UIViewController {
    
    var selectedStock: Stock?
    
    private let balanceLabel = UILabel()
    private let assetsLabel = UILabel()
    private let profitLabel = UILabel()
    private let tableView = UITableView()
    private let buyButton = UIButton(type: .system)
    private let sellButton = UIButton(type: .system)
    
    private var positions: [Position] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadPositions()
        updateAccountInfo()
        startRefreshTimer()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let titleLabel = UILabel()
        titleLabel.text = "模拟交易"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let accountStack = UIStackView()
        accountStack.axis = .vertical
        accountStack.spacing = 8
        accountStack.translatesAutoresizingMaskIntoConstraints = false
        
        let balanceStack = UIStackView()
        balanceStack.axis = .horizontal
        balanceStack.spacing = 8
        let balanceTitle = UILabel()
        balanceTitle.text = "可用余额:"
        balanceTitle.font = .systemFont(ofSize: 14)
        balanceTitle.textColor = .secondaryLabel
        balanceLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        balanceLabel.textColor = .label
        balanceStack.addArrangedSubview(balanceTitle)
        balanceStack.addArrangedSubview(balanceLabel)
        accountStack.addArrangedSubview(balanceStack)
        
        let assetsStack = UIStackView()
        assetsStack.axis = .horizontal
        assetsStack.spacing = 8
        let assetsTitle = UILabel()
        assetsTitle.text = "总资产:"
        assetsTitle.font = .systemFont(ofSize: 14)
        assetsTitle.textColor = .secondaryLabel
        assetsLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        assetsLabel.textColor = .label
        assetsStack.addArrangedSubview(assetsTitle)
        assetsStack.addArrangedSubview(assetsLabel)
        accountStack.addArrangedSubview(assetsStack)
        
        let profitStack = UIStackView()
        profitStack.axis = .horizontal
        profitStack.spacing = 8
        let profitTitle = UILabel()
        profitTitle.text = "总盈亏:"
        profitTitle.font = .systemFont(ofSize: 14)
        profitTitle.textColor = .secondaryLabel
        profitLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        profitStack.addArrangedSubview(profitTitle)
        profitStack.addArrangedSubview(profitLabel)
        accountStack.addArrangedSubview(profitStack)
        
        let accountView = UIView()
        accountView.backgroundColor = .secondarySystemBackground
        accountView.layer.cornerRadius = 12
        accountView.translatesAutoresizingMaskIntoConstraints = false
        accountView.addSubview(accountStack)
        view.addSubview(accountView)
        
        accountStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountStack.topAnchor.constraint(equalTo: accountView.topAnchor, constant: 16),
            accountStack.leadingAnchor.constraint(equalTo: accountView.leadingAnchor, constant: 16),
            accountStack.trailingAnchor.constraint(equalTo: accountView.trailingAnchor, constant: -16),
            accountStack.bottomAnchor.constraint(equalTo: accountView.bottomAnchor, constant: -16),
        ])
        
        buyButton.setTitle("买入", for: .normal)
        buyButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        buyButton.backgroundColor = .systemBlue
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.layer.cornerRadius = 8
        buyButton.addTarget(self, action: #selector(buyStock), for: .touchUpInside)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        sellButton.setTitle("卖出", for: .normal)
        sellButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        sellButton.backgroundColor = .systemRed
        sellButton.setTitleColor(.white, for: .normal)
        sellButton.layer.cornerRadius = 8
        sellButton.addTarget(self, action: #selector(sellStock), for: .touchUpInside)
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStack = UIStackView(arrangedSubviews: [buyButton, sellButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 16
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PositionCell.self, forCellReuseIdentifier: PositionCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 110
        tableView.separatorStyle = .singleLine
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            accountView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            accountView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            accountView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonStack.topAnchor.constraint(equalTo: accountView.bottomAnchor, constant: 16),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buyButton.heightAnchor.constraint(equalToConstant: 48),
            sellButton.heightAnchor.constraint(equalToConstant: 48),
            
            tableView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func loadPositions() {
        positions = TradingManager.shared.getPositions()
        tableView.reloadData()
    }
    
    private func updateAccountInfo() {
        let balance = TradingManager.shared.getBalance()
        let assets = TradingManager.shared.getTotalAssets()
        let profit = TradingManager.shared.getTotalProfit()
        
        balanceLabel.text = String(format: "¥%.2f", balance)
        assetsLabel.text = String(format: "¥%.2f", assets)
        
        if profit >= 0 {
            profitLabel.textColor = .red
            profitLabel.text = String(format: "+¥%.2f", profit)
        } else {
            profitLabel.textColor = .green
            profitLabel.text = String(format: "¥%.2f", profit)
        }
    }
    
    private func startRefreshTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.loadPositions()
                self?.updateAccountInfo()
            }
        }
    }
    
    @objc private func buyStock() {
        let stocks = StockDataManager.shared.getStocks()
        let stockNames = stocks.map { $0.name }
        
        let alert = UIAlertController(title: "买入股票", message: "选择要买入的股票", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "股票代码或名称"
        }
        alert.addTextField { textField in
            textField.placeholder = "数量（股）"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "确定", style: .default) { [weak self] _ in
            guard let codeOrName = alert.textFields?[0].text?.trimmingCharacters(in: .whitespaces),
                  let quantityText = alert.textFields?[1].text,
                  let quantity = Int(quantityText),
                  quantity > 0 else {
                return
            }
            
            let stock = stocks.first { $0.code == codeOrName || $0.name == codeOrName }
            if let stock = stock {
                let success = TradingManager.shared.buyStock(code: stock.code, name: stock.name, price: stock.price, quantity: quantity)
                if success {
                    self?.showMessage("买入成功", message: "\(stock.name) \(quantity)股")
                    self?.loadPositions()
                    self?.updateAccountInfo()
                } else {
                    self?.showMessage("买入失败", message: "余额不足")
                }
            } else {
                self?.showMessage("错误", message: "未找到该股票")
            }
        })
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func sellStock() {
        let positions = TradingManager.shared.getPositions()
        if positions.isEmpty {
            showMessage("提示", message: "暂无持仓")
            return
        }
        
        let alert = UIAlertController(title: "卖出股票", message: "选择要卖出的股票", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "股票代码或名称"
        }
        alert.addTextField { textField in
            textField.placeholder = "数量（股）"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "确定", style: .default) { [weak self] _ in
            guard let codeOrName = alert.textFields?[0].text?.trimmingCharacters(in: .whitespaces),
                  let quantityText = alert.textFields?[1].text,
                  let quantity = Int(quantityText),
                  quantity > 0 else {
                return
            }
            
            let position = positions.first { $0.code == codeOrName || $0.name == codeOrName }
            if let position = position {
                if quantity > position.quantity {
                    self?.showMessage("错误", message: "卖出数量超过持仓数量")
                    return
                }
                let success = TradingManager.shared.sellStock(code: position.code, quantity: quantity)
                if success {
                    self?.showMessage("卖出成功", message: "\(position.name) \(quantity)股")
                    self?.loadPositions()
                    self?.updateAccountInfo()
                } else {
                    self?.showMessage("卖出失败", message: "操作失败")
                }
            } else {
                self?.showMessage("错误", message: "未找到该持仓")
            }
        })
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showMessage(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension TradingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionCell.identifier, for: indexPath) as? PositionCell else {
            return UITableViewCell()
        }
        cell.configure(with: positions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "我的持仓"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = positions[indexPath.row]
        
        let alert = UIAlertController(title: position.name, message: """
            持仓数量: \(position.quantity)股
            成本价: \(String(format: "%.2f", position.costPrice))
            当前价: \(String(format: "%.2f", position.currentPrice))
            市值: \(String(format: "%.2f", position.marketValue))
            盈亏: \(position.profit >= 0 ? "+" : "")\(String(format: "%.2f", position.profit)) (\(position.profitPercent >= 0 ? "+" : "")\(String(format: "%.2f%%", position.profitPercent)))
            """, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "卖出", style: .default) { [weak self] _ in
            let sellAlert = UIAlertController(title: "卖出 \(position.name)", message: "输入卖出数量", preferredStyle: .alert)
            sellAlert.addTextField { textField in
                textField.placeholder = "数量（股）"
                textField.keyboardType = .numberPad
            }
            
            sellAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
                if let quantityText = sellAlert.textFields?.first?.text,
                   let quantity = Int(quantityText),
                   quantity > 0,
                   quantity <= position.quantity {
                    let success = TradingManager.shared.sellStock(code: position.code, quantity: quantity)
                    if success {
                        self?.showMessage("卖出成功", message: "\(position.name) \(quantity)股")
                        self?.loadPositions()
                        self?.updateAccountInfo()
                    }
                }
            })
            sellAlert.addAction(UIAlertAction(title: "取消", style: .cancel))
            self?.present(sellAlert, animated: true)
        })
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        present(alert, animated: true)
    }
}