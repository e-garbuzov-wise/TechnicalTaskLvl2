import UIKit
import Combine

final class ShipDetailsPresenter {
    private let ship: Ship
    private var cancellables: Set<AnyCancellable> = []
    
    init(ship: Ship) {
        self.ship = ship
    }
    
    func configure() -> Ship {
        return ship
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        ImageLoader.shared.loadImage(from: url)
            .sink { image in
                completion(image)
            }
            .store(in: &cancellables)
    }
}
