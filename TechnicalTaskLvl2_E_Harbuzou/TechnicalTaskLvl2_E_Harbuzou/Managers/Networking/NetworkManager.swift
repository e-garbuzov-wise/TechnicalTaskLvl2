import Combine
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()

    func fetchShips() -> AnyPublisher<[Ship], Error> {
        guard let url = URL(string: Bundle.main.infoDictionary?["APIBaseURL"] as! String) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Ship].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
