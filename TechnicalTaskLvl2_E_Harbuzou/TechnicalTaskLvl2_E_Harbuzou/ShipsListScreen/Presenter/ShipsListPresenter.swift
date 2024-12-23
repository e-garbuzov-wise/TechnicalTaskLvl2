import Combine
import UIKit

final class ShipsListPresenter {
    private var cancellables: Set<AnyCancellable> = []
    private weak var view: ShipsListViewController?
    
    private let coreDataManager: CoreDataManager
    private let networkManager: NetworkManager
    private let imageLoader: ImageLoader
    
    init(view: ShipsListViewController, locator: ServiceLocator = .shared) {
        self.view = view
        self.coreDataManager = locator.coreDataManager
        self.networkManager = locator.networkManager
        self.imageLoader = locator.imageLoader
    }
    
    func loadShips() {
        let cachedShips = coreDataManager.fetchShips().map { entity in
            Ship(
                name: entity.name ?? "",
                image: URL(string: entity.image ?? ""),
                type: entity.type ?? "",
                builtYear: entity.builtYear != 0 ? Int(entity.builtYear) : nil,
                weightRaw: entity.weight != 0 ? Int(entity.weight) : nil,
                homePort: entity.homePort,
                roles: entity.roles?.components(separatedBy: ", ") ?? []
            )
        }
        
        if !cachedShips.isEmpty {
            view?.updateShips(cachedShips)
        }
        networkManager.fetchShips()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error fetching ships: \(error)")
                    }
                },
                receiveValue: { [weak self] ships in
                    self?.view?.updateShips(ships)
                }
            )
            .store(in: &cancellables)
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        imageLoader.loadImage(from: url)
            .sink { image in
                completion(image)
            }
            .store(in: &cancellables)
    }
}
