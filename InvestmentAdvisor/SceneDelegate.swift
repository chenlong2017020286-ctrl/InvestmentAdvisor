import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
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
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}