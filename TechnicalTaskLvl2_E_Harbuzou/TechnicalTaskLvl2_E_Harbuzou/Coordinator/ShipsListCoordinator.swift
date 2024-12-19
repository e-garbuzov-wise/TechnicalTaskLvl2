import UIKit

final class ShipsListCoordinator {
    private let navigationController: UINavigationController
    
    private var rootViewController: UIViewController {
        navigationController.viewControllers.first ?? UIViewController()
    }
    
    init(rootNavigationController: UINavigationController) {
        self.navigationController = rootNavigationController
    }
    
    func start() {
        //TODO: start shipDetailesSceen
    }
    
    func closeProfile() {
        navigationController.popViewController(animated: true)
    }
}
