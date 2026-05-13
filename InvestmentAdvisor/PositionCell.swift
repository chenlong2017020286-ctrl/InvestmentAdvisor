import UIKit

class PositionCell: UITableViewCell {
    static let identifier = "PositionCell"
    
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
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let costPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private let marketValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    private let profitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
        contentView.addSubview(quantityLabel)
        contentView.addSubview(costPriceLabel)
        contentView.addSubview(currentPriceLabel)
        contentView.addSubview(marketValueLabel)
        contentView.addSubview(profitLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        costPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        marketValueLabel.translatesAutoresizingMaskIntoConstraints = false
        profitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            codeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            codeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            quantityLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 2),
            quantityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            costPriceLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 2),
            costPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            costPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            currentPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            currentPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            marketValueLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 2),
            marketValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            profitLabel.topAnchor.constraint(equalTo: marketValueLabel.bottomAnchor, constant: 2),
            profitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(with position: Position) {
        nameLabel.text = position.name
        codeLabel.text = position.code
        quantityLabel.text = "持仓: \(position.quantity)股"
        costPriceLabel.text = "成本: \(String(format: "%.2f", position.costPrice))"
        currentPriceLabel.text = String(format: "%.2f", position.currentPrice)
        marketValueLabel.text = "市值: \(String(format: "%.2f", position.marketValue))"
        
        if position.profit >= 0 {
            profitLabel.textColor = .red
            profitLabel.text = String(format: "+%.2f (+%.2f%%)", position.profit, position.profitPercent)
        } else {
            profitLabel.textColor = .green
            profitLabel.text = String(format: "%.2f (%.2f%%)", position.profit, position.profitPercent)
        }
    }
}