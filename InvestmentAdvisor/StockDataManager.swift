import Foundation

struct Stock {
    let code: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let volume: Int
    let high: Double
    let low: Double
}

class StockDataManager {
    static let shared = StockDataManager()
    
    private let stocks: [Stock] = [
        Stock(code: "SH600519", name: "贵州茅台", price: 1688.00, change: 25.50, changePercent: 1.53, volume: 285600, high: 1700.00, low: 1665.00),
        Stock(code: "SZ000858", name: "五粮液", price: 145.80, change: -2.30, changePercent: -1.56, volume: 1568000, high: 148.50, low: 144.20),
        Stock(code: "SH601318", name: "中国平安", price: 48.25, change: 0.85, changePercent: 1.79, volume: 2345000, high: 48.80, low: 47.50),
        Stock(code: "SZ000001", name: "平安银行", price: 12.68, change: 0.15, changePercent: 1.20, volume: 3456000, high: 12.80, low: 12.50),
        Stock(code: "SH600036", name: "招商银行", price: 35.45, change: -0.45, changePercent: -1.25, volume: 1876000, high: 36.00, low: 35.20),
        Stock(code: "SH601899", name: "紫金矿业", price: 15.20, change: 0.35, changePercent: 2.35, volume: 5678000, high: 15.35, low: 14.85),
        Stock(code: "SZ002594", name: "比亚迪", price: 268.50, change: 8.20, changePercent: 3.16, volume: 892000, high: 270.00, low: 260.30),
        Stock(code: "SH601398", name: "工商银行", price: 5.28, change: 0.05, changePercent: 0.95, volume: 4567000, high: 5.32, low: 5.23),
    ]
    
    func getStocks() -> [Stock] {
        return stocks
    }
    
    func fetchStockData(completion: @escaping ([Stock]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            var updatedStocks = self.stocks.map { stock in
                let priceChange = (Double.random(in: -10...10) / 100) * stock.price
                let newPrice = stock.price + priceChange
                let newChange = stock.change + priceChange
                let newPercent = (newChange / (newPrice - newChange)) * 100
                return Stock(
                    code: stock.code,
                    name: stock.name,
                    price: newPrice,
                    change: newChange,
                    changePercent: newPercent,
                    volume: stock.volume + Int.random(in: -10000...10000),
                    high: max(stock.high, newPrice),
                    low: min(stock.low, newPrice)
                )
            }
            completion(updatedStocks)
        }
    }
}