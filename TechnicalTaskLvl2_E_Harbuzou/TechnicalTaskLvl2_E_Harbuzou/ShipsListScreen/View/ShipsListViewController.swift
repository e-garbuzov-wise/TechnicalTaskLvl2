import UIKit

final class ShipsListViewController: UIViewController {
    private let tableView = UITableView()
    private var ships: [Ship] = []
    private var presenter: ShipsListPresenter?
    private let isGuest: Bool
    private var coordinator: ShipsListCoordinator?
    
    init(isGuest: Bool, coordinator: ShipsListCoordinator) {
        self.isGuest = isGuest
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.presenter = ShipsListPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadShips()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        setupTableView()
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
    
    func updateShips(_ ships: [Ship]) {
        self.ships = ships
        tableView.reloadData()
    }
    
    @objc private func logoutButtonTapped() {
        coordinator?.closeProfile()
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
