import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let rootViewController = Configurator.configure(navigationController: navigationController)
        let navigation = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}
