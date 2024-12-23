import UIKit
import Combine

final class ShipsListViewController: UIViewController {
    private let tableView = UITableView()
    private var ships: [Ship] = []
    private var presenter: ShipsListPresenter?
    private let isGuest: Bool
    private var coordinator: ShipsListCoordinator?
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var noInternetLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.noInternetWarning
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    init(isGuest: Bool, coordinator: ShipsListCoordinator, locator: ServiceLocator = .shared) {
        self.isGuest = isGuest
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    
        self.presenter = ShipsListPresenter(view: self, locator: locator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        setupTableView()
        setupNoInternetLabel()
        presenter?.loadShips()
        
        let networkMonitor = ServiceLocator.shared.networkMonitor
        networkMonitor.observeNetworkStatus { isConnected in
            self.noInternetLabel.isHidden = isConnected
        }
        .store(in: &cancellables)
    }
    
    func updateShips(_ ships: [Ship]) {
        self.ships = ships
        tableView.reloadData()
    }
    
    private func setupNoInternetLabel() {
        noInternetLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noInternetLabel)
        NSLayoutConstraint.activate([
            noInternetLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            noInternetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noInternetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noInternetLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ShipCell.self, forCellReuseIdentifier: ShipCell.identifier)
        view.addSubview(tableView)
    }
    
    private func setUpNavigationBar() {
        title = Constants.shipsListNavBarTitle
        navigationItem.hidesBackButton = true
        let buttonTitle = isGuest ? Constants.exit : Constants.logout
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: buttonTitle,
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped))
    }
    
    @objc private func logoutButtonTapped() {
        if isGuest {
             let alert = UIAlertController(
                title: Constants.thankYou,
                message: Constants.thankYouMore,
                 preferredStyle: .alert
             )
            alert.addAction(UIAlertAction(title: Constants.okButton, style: .default, handler: { [weak self] _ in
                 self?.coordinator?.closeProfile()
             }))
             present(alert, animated: true, completion: nil)
        } else {
            self.coordinator?.closeProfile()
        }
    }
}

extension ShipsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShipCell.identifier, for: indexPath) as? ShipCell else {
            return UITableViewCell()
        }
        
        let ship = ships[indexPath.row]
        cell.configure(with: ship, presenter: presenter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedShip = ships[indexPath.row]
        coordinator?.navigateToShipDetails(with: selectedShip)
    }
}
