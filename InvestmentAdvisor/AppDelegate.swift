import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let tabBarController = UITabBarController()
        
        let stockVC = StockViewController()
        stockVC.tabBarItem = UITabBarItem(title: "股票", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 0)
        
        let fundVC = FundViewController()
        fundVC.tabBarItem = UITabBarItem(title: "基金", image: UIImage(systemName: "building.columns"), tag: 1)
        
        let tradingVC = TradingViewController()
        tradingVC.tabBarItem = UITabBarItem(title: "交易", image: UIImage(systemName: "arrow.left.arrow.right"), tag: 2)
        
        tabBarController.viewControllers = [stockVC, fundVC, tradingVC]
        window?.rootViewController = tabBarController
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}