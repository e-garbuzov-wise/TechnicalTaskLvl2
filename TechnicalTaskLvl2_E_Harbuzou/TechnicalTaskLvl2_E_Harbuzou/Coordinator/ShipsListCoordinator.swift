import UIKit

final class ShipsListCoordinator {
    private let navigationController: UINavigationController
    
    private var rootViewController: UIViewController {
        navigationController.viewControllers.first ?? UIViewController()
    }
    
    init(rootNavigationController: UINavigationController) {
        self.navigationController = rootNavigationController
    }
    
    func closeProfile() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToShipDetails(with ship: Ship) {
        let detailsViewController = ShipDetailsViewController(ship: ship)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
