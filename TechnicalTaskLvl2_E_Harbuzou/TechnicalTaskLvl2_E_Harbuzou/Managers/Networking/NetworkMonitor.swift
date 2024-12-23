import Network
import Combine

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    @Published private(set) var isConnected: Bool = true

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func observeNetworkStatus(
         onQueue queue: DispatchQueue = .main,
         update: @escaping (Bool) -> Void
     ) -> AnyCancellable {
         $isConnected
             .receive(on: queue)
             .sink { isConnected in
                 update(isConnected)
             }
     }
}
