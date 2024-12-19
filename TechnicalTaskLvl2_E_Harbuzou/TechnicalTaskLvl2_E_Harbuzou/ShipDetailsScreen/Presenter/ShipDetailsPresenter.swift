import UIKit

final class ShipDetailsPresenter {
    private let ship: Ship
    
    init(ship: Ship) {
        self.ship = ship
    }
    
    func configure() -> ShipDetailsModel {
        return ShipDetailsModel(
            name: ship.name,
            image: ship.image,
            type: ship.type,
            builtYear: ship.builtYear,
            weight: ship.weight,
            homePort: ship.homePort,
            roles: ship.roles)
    }
}
