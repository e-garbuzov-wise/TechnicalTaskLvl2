import UIKit

final class Configurator {
    static func configure(navigationController: UINavigationController) -> UIViewController {
        let coordinator = AuthCoordinator(navigationController: navigationController)
        let authViewController = AuthViewController(coordinator: coordinator)
        return authViewController
    }
}
