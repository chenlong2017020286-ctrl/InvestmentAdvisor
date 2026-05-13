import UIKit

class StockViewController: UIViewController {
    
    private let tableView = UITableView()
    private var stocks: [Stock] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadStocks()
        startRefreshTimer()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let titleLabel = UILabel()
        titleLabel.text = "股票行情"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label
        
        let refreshButton = UIButton(type: .system)
        refreshButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, refreshButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func loadStocks() {
        stocks = StockDataManager.shared.getStocks()
        tableView.reloadData()
    }
    
    private func startRefreshTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            StockDataManager.shared.fetchStockData { stocks in
                DispatchQueue.main.async {
                    self?.stocks = stocks
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func refreshData() {
        StockDataManager.shared.fetchStockData { [weak self] stocks in
            DispatchQueue.main.async {
                self?.stocks = stocks
                self?.tableView.reloadData()
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension StockViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier, for: indexPath) as? StockCell else {
            return UITableViewCell()
        }
        cell.configure(with: stocks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stock = stocks[indexPath.row]
        let alert = UIAlertController(title: stock.name, message: """
            代码: \(stock.code)
            当前价: \(String(format: "%.2f", stock.price))
            涨跌额: \(stock.change >= 0 ? "+" : "")\(String(format: "%.2f", stock.change))
            涨跌幅: \(stock.changePercent >= 0 ? "+" : "")\(String(format: "%.2f%%", stock.changePercent))
            成交量: \(stock.volume)
            最高价: \(String(format: "%.2f", stock.high))
            最低价: \(String(format: "%.2f", stock.low))
            """, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        alert.addAction(UIAlertAction(title: "买入", style: .default) { _ in
            let tradingVC = TradingViewController()
            tradingVC.selectedStock = stock
            self.navigationController?.pushViewController(tradingVC, animated: true)
        })
        present(alert, animated: true)
    }
}