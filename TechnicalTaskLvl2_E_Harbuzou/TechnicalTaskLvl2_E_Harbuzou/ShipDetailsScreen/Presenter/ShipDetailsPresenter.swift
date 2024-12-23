import UIKit
import Combine

final class ShipDetailsPresenter {
    private let ship: Ship
    private var cancellables: Set<AnyCancellable> = []
    
    private let imageLoader: ImageLoader

    init(ship: Ship, locator: ServiceLocator = .shared) {
        self.ship = ship
        self.imageLoader = locator.imageLoader
    }
    
    func configure() -> Ship {
        return ship
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        imageLoader.loadImage(from: url)
            .sink { image in
                completion(image)
            }
            .store(in: &cancellables)
    }
}
