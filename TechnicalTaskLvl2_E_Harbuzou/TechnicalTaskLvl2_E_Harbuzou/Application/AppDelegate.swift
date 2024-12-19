import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window =  UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        let coordinator = AuthCoordinator(navigationController: navigationController)
        coordinator.start()
        return true
    }
}
