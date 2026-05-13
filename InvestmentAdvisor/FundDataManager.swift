import Foundation

struct Fund {
    let code: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let nav: Double
    let date: String
}

class FundDataManager {
    static let shared = FundDataManager()
    
    private let funds: [Fund] = [
        Fund(code: "163407", name: "兴全合宜混合A", price: 1.2850, change: 0.0120, changePercent: 0.94, nav: 1.2730, date: "2024-01-15"),
        Fund(code: "005911", name: "天弘沪深300ETF", price: 1.4520, change: -0.0080, changePercent: -0.55, nav: 1.4600, date: "2024-01-15"),
        Fund(code: "110022", name: "易方达消费行业", price: 2.6850, change: 0.0350, changePercent: 1.32, nav: 2.6500, date: "2024-01-15"),
        Fund(code: "000001", name: "华夏成长混合", price: 1.1230, change: 0.0050, changePercent: 0.45, nav: 1.1180, date: "2024-01-15"),
        Fund(code: "001595", name: "天弘中证食品饮料", price: 1.3560, change: 0.0210, changePercent: 1.57, nav: 1.3350, date: "2024-01-15"),
        Fund(code: "519732", name: "交银定期支付双息", price: 1.0890, change: -0.0030, changePercent: -0.27, nav: 1.0920, date: "2024-01-15"),
        Fund(code: "001838", name: "博时沪深300ETF", price: 1.4250, change: -0.0120, changePercent: -0.84, nav: 1.4370, date: "2024-01-15"),
        Fund(code: "260108", name: "景顺长城新兴成长", price: 1.8560, change: 0.0280, changePercent: 1.53, nav: 1.8280, date: "2024-01-15"),
    ]
    
    func getFunds() -> [Fund] {
        return funds
    }
    
    func fetchFundData(completion: @escaping ([Fund]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            var updatedFunds = self.funds.map { fund in
                let priceChange = (Double.random(in: -5...5) / 100) * fund.price
                let newPrice = max(0.01, fund.price + priceChange)
                let newChange = fund.change + priceChange
                let newPercent = (newChange / (newPrice - newChange)) * 100
                return Fund(
                    code: fund.code,
                    name: fund.name,
                    price: newPrice,
                    change: newChange,
                    changePercent: newPercent,
                    nav: newPrice - (Double.random(in: 0...5) / 1000),
                    date: fund.date
                )
            }
            completion(updatedFunds)
        }
    }
}