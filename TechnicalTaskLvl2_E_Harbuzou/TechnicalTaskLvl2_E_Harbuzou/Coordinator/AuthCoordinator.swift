import UIKit

final class AuthCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let authVC = AuthViewController(coordinator: self)
        navigationController.setViewControllers([authVC], animated: false)
    }

    func navigateToShipList() {
        let shipListVC = ShipsListViewController()
        shipListVC.modalPresentationStyle = .fullScreen
        shipListVC.modalTransitionStyle = .flipHorizontal
        navigationController.pushViewController(shipListVC, animated: true)
    }
}
