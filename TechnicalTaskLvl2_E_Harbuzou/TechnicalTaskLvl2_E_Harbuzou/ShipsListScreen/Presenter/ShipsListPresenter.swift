import Combine
import UIKit

final class ShipsListPresenter {
    private var cancellables: Set<AnyCancellable> = []
    private weak var view: ShipsListViewController?
    
    init(view: ShipsListViewController) {
        self.view = view
    }
    
    func loadShips() {
        NetworkManager.shared.fetchShips()
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
        ImageLoader.shared.loadImage(from: url)
            .sink { image in
                completion(image)
            }
            .store(in: &cancellables)
    }
}
