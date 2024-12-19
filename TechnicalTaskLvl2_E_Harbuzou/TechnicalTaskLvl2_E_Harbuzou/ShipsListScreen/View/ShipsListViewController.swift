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
        Ship(name: "Black Pearl",
             image: UIImage(named: "black_pearl"),
             type: "Pirate Ship",
             builtYear: "1710",
             weight: "500 tons",
             homePort: "Tortuga",
             roles: "Piracy, Treasure Hunting"),
        
        Ship(name: "USS Enterprise",
             image: UIImage(named: "black_pearl"),
             type: "Starship",
             builtYear: "2245",
             weight: "190,000 metric tons",
             homePort: "Earth Spacedock",
             roles: "Exploration, Defense"),
        
        Ship(name: "HMS Victory",
             image: UIImage(named: "black_pearl"),
             type: "Warship",
             builtYear: "1765",
             weight: "3,556 tons",
             homePort: "Portsmouth, UK",
             roles: "Combat, Flagship"),
        
        Ship(name: "Titanic",
             image: UIImage(named: "black_pearl"),
             type: "Ocean Liner",
             builtYear: "1912",
             weight: "46,328 tons",
             homePort: "Southampton, UK",
             roles: "Passenger Transport"),
        
        Ship(name: "Queen Mary 2",
             image: UIImage(named: "black_pearl"),
             type: "Cruise Ship",
             builtYear: "2004",
             weight: "148,528 tons",
             homePort: "Southampton, UK",
             roles: "Luxury Cruises"),
        
        Ship(name: "Bismarck",
             image: UIImage(named: "black_pearl"),
             type: "Battleship",
             builtYear: "1939",
             weight: "50,300 tons",
             homePort: "Hamburg, Germany",
             roles: "Naval Warfare"),
        
        Ship(name: "Santa Maria",
             image: UIImage(named: "black_pearl"),
             type: "Exploration Ship",
             builtYear: "1492",
             weight: "100 tons",
             homePort: "Palos de la Frontera, Spain",
             roles: "Exploration"),
        
        Ship(name: "Endeavour",
             image: UIImage(named: "black_pearl"),
             type: "Research Vessel",
             builtYear: "1764",
             weight: "368 tons",
             homePort: "Plymouth, UK",
             roles: "Scientific Exploration"),
        
        Ship(name: "Argo",
             image: UIImage(named: "black_pearl"),
             type: "Mythological Ship",
             builtYear: "-1300",
             weight: "Unknown",
             homePort: "Iolcos, Greece",
             roles: "Quest for the Golden Fleece"),
        
        Ship(name: "Yamato",
             image: UIImage(named: "black_pearl"),
             type: "Battleship",
             builtYear: "1940",
             weight: "72,800 tons",
             homePort: "Kure, Japan",
             roles: "Naval Warfare")
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
            let selectedShip = ships[indexPath.row]
            coordinator?.navigateToShipDetails(with: selectedShip)
        }
}
