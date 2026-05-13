import UIKit

class StockCell: UITableViewCell {
    static let identifier = "StockCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(codeLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(changeLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            codeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            codeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            codeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            changeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            changeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(with stock: Stock) {
        nameLabel.text = stock.name
        codeLabel.text = stock.code
        priceLabel.text = String(format: "%.2f", stock.price)
        
        if stock.changePercent >= 0 {
            priceLabel.textColor = .red
            changeLabel.textColor = .red
            changeLabel.text = String(format: "+%.2f (+%.2f%%)", stock.change, stock.changePercent)
        } else {
            priceLabel.textColor = .green
            changeLabel.textColor = .green
            changeLabel.text = String(format: "%.2f (%.2f%%)", stock.change, stock.changePercent)
        }
    }
}