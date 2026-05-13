import Foundation

struct Position {
    let code: String
    let name: String
    let quantity: Int
    let costPrice: Double
    let currentPrice: Double
    let marketValue: Double
    let profit: Double
    let profitPercent: Double
}

struct Transaction {
    let id: String
    let code: String
    let name: String
    let type: String
    let price: Double
    let quantity: Int
    let amount: Double
    let time: String
}

class TradingManager {
    static let shared = TradingManager()
    
    private var balance: Double = 100000.0
    private var positions: [Position] = []
    private var transactions: [Transaction] = []
    
    func getBalance() -> Double {
        return balance
    }
    
    func getPositions() -> [Position] {
        updatePositions()
        return positions
    }
    
    func getTransactions() -> [Transaction] {
        return transactions
    }
    
    func buyStock(code: String, name: String, price: Double, quantity: Int) -> Bool {
        let totalAmount = price * Double(quantity)
        if totalAmount > balance {
            return false
        }
        
        balance -= totalAmount
        
        if let index = positions.firstIndex(where: { $0.code == code }) {
            let existing = positions[index]
            let newQuantity = existing.quantity + quantity
            let newCostPrice = (existing.costPrice * Double(existing.quantity) + price * Double(quantity)) / Double(newQuantity)
            positions[index] = Position(
                code: code,
                name: name,
                quantity: newQuantity,
                costPrice: newCostPrice,
                currentPrice: price,
                marketValue: price * Double(newQuantity),
                profit: (price - newCostPrice) * Double(newQuantity),
                profitPercent: ((price - newCostPrice) / newCostPrice) * 100
            )
        } else {
            positions.append(Position(
                code: code,
                name: name,
                quantity: quantity,
                costPrice: price,
                currentPrice: price,
                marketValue: price * Double(quantity),
                profit: 0,
                profitPercent: 0
            ))
        }
        
        transactions.append(Transaction(
            id: UUID().uuidString,
            code: code,
            name: name,
            type: "买入",
            price: price,
            quantity: quantity,
            amount: totalAmount,
            time: Date().formatted()
        ))
        
        return true
    }
    
    func sellStock(code: String, quantity: Int) -> Bool {
        guard let index = positions.firstIndex(where: { $0.code == code }) else {
            return false
        }
        
        let position = positions[index]
        if quantity > position.quantity {
            return false
        }
        
        let amount = position.currentPrice * Double(quantity)
        balance += amount
        
        if quantity == position.quantity {
            positions.remove(at: index)
        } else {
            let newQuantity = position.quantity - quantity
            positions[index] = Position(
                code: code,
                name: position.name,
                quantity: newQuantity,
                costPrice: position.costPrice,
                currentPrice: position.currentPrice,
                marketValue: position.currentPrice * Double(newQuantity),
                profit: (position.currentPrice - position.costPrice) * Double(newQuantity),
                profitPercent: ((position.currentPrice - position.costPrice) / position.costPrice) * 100
            )
        }
        
        transactions.append(Transaction(
            id: UUID().uuidString,
            code: code,
            name: position.name,
            type: "卖出",
            price: position.currentPrice,
            quantity: quantity,
            amount: amount,
            time: Date().formatted()
        ))
        
        return true
    }
    
    private func updatePositions() {
        positions = positions.map { position in
            let stocks = StockDataManager.shared.getStocks()
            if let stock = stocks.first(where: { $0.code == position.code }) {
                let profit = (stock.price - position.costPrice) * Double(position.quantity)
                let profitPercent = ((stock.price - position.costPrice) / position.costPrice) * 100
                return Position(
                    code: position.code,
                    name: position.name,
                    quantity: position.quantity,
                    costPrice: position.costPrice,
                    currentPrice: stock.price,
                    marketValue: stock.price * Double(position.quantity),
                    profit: profit,
                    profitPercent: profitPercent
                )
            }
            return position
        }
    }
    
    func getTotalAssets() -> Double {
        updatePositions()
        let positionsValue = positions.reduce(0.0) { $0 + $1.marketValue }
        return balance + positionsValue
    }
    
    func getTotalProfit() -> Double {
        updatePositions()
        return positions.reduce(0.0) { $0 + $1.profit }
    }
}