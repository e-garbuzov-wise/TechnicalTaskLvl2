final class ServiceLocator {
    static let shared = ServiceLocator()
    
    private(set) var coreDataManager: CoreDataManager
    private(set) var imageLoader: ImageLoader
    private(set) var networkManager: NetworkManager
    private(set) var networkMonitor: NetworkMonitor

    private init() {
        self.coreDataManager = CoreDataManager.shared
        self.imageLoader = ImageLoader.shared
        self.networkManager = NetworkManager.shared
        self.networkMonitor = NetworkMonitor.shared
    }
}

let coreDataManager = ServiceLocator.shared.coreDataManager
let imageLoader = ServiceLocator.shared.imageLoader
let networkManager = ServiceLocator.shared.networkManager
let networkMonitor = ServiceLocator.shared.networkMonitor
