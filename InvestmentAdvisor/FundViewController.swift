import UIKit

class FundViewController: UIViewController {
    
    private let tableView = UITableView()
    private var funds: [Fund] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadFunds()
        startRefreshTimer()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let titleLabel = UILabel()
        titleLabel.text = "基金行情"
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
        tableView.register(FundCell.self, forCellReuseIdentifier: FundCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
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
    
    private func loadFunds() {
        funds = FundDataManager.shared.getFunds()
        tableView.reloadData()
    }
    
    private func startRefreshTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            FundDataManager.shared.fetchFundData { funds in
                DispatchQueue.main.async {
                    self?.funds = funds
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func refreshData() {
        FundDataManager.shared.fetchFundData { [weak self] funds in
            DispatchQueue.main.async {
                self?.funds = funds
                self?.tableView.reloadData()
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension FundViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FundCell.identifier, for: indexPath) as? FundCell else {
            return UITableViewCell()
        }
        cell.configure(with: funds[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fund = funds[indexPath.row]
        let alert = UIAlertController(title: fund.name, message: """
            代码: \(fund.code)
            净值日期: \(fund.date)
            单位净值: \(String(format: "%.4f", fund.nav))
            估算净值: \(String(format: "%.4f", fund.price))
            涨跌幅: \(fund.changePercent >= 0 ? "+" : "")\(String(format: "%.2f%%", fund.changePercent))
            """, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}