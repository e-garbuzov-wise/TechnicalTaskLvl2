import UIKit

final class ShipsListViewController: UIViewController {
    private let tableView = UITableView()
    private let isGuest: Bool
    private var coordinator: ShipsListCoordinator?
    
    init(isGuest: Bool, coordinator: ShipsListCoordinator) {
        self.isGuest = isGuest
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let ships: [Ship] = [
        Ship(name: "Black Pearl", type: "Pirate Ship", year: 1710, image: UIImage(named: "black_pearl")),
        Ship(name: "USS Enterprise", type: "Starship", year: 2245, image: UIImage(named: "black_pearl")),
        Ship(name: "HMS Victory", type: "Warship", year: 1765, image: UIImage(named: "black_pearl")),
        Ship(name: "Titanic", type: "Ocean Liner", year: 1912, image: UIImage(named: "black_pearl")),
        Ship(name: "Queen Mary 2", type: "Cruise Ship", year: 2004, image: UIImage(named: "black_pearl")),
        Ship(name: "Bismarck", type: "Battleship", year: 1939, image: UIImage(named: "black_pearl")),
        Ship(name: "Santa Maria", type: "Exploration Ship", year: 1492, image: UIImage(named: "black_pearl")),
        Ship(name: "Endeavour", type: "Research Vessel", year: 1764, image: UIImage(named: "black_pearl")),
        Ship(name: "Argo", type: "Mythological Ship", year: -1300, image: UIImage(named: "black_pearl")),
        Ship(name: "Yamato", type: "Battleship", year: 1940, image: UIImage(named: "black_pearl"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpnavigationBar()
        setupTableView()
    }
    
    private func setUpnavigationBar() {
        title = Constants.shipsListNavBarTitle
        navigationItem.hidesBackButton = true
        let buttonTitle = isGuest ? Constants.exit : Constants.logout
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: buttonTitle,
            style: .plain,
            target: self,
            action: #selector(actionButtonTapped))
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ShipCell.self, forCellReuseIdentifier: ShipCell.identifier)
        
        view.addSubview(tableView)
    }
    
    @objc private func actionButtonTapped() {
        coordinator?.closeProfile()
    }
}

extension ShipsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShipCell.identifier,
            for: indexPath) as? ShipCell else {
            return UITableViewCell()
        }
        
        let ship = ships[indexPath.row]
        cell.configure(with: ship)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
