import UIKit

final class ShipDetailsViewController: UIViewController {
    private let presenter: ShipDetailsPresenter
    
    private let shipNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let shipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let shipTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let builtYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let homePortLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let rolesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    init(ship: Ship) {
        self.presenter = ShipDetailsPresenter(ship: ship)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        let leftStackView = UIStackView(arrangedSubviews: [shipTypeLabel, builtYearLabel])
        leftStackView.axis = .vertical
        leftStackView.spacing = 8
        
        let rightStackView = UIStackView(arrangedSubviews: [weightLabel, homePortLabel, rolesLabel])
        rightStackView.axis = .vertical
        rightStackView.spacing = 8
        
        let infoStackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        infoStackView.axis = .horizontal
        infoStackView.spacing = 16
        infoStackView.distribution = .fillEqually
        
        [shipNameLabel, shipImageView, infoStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            shipNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            shipNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shipNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            shipImageView.topAnchor.constraint(equalTo: shipNameLabel.bottomAnchor, constant: 16),
            shipImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shipImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            shipImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            infoStackView.topAnchor.constraint(equalTo: shipImageView.bottomAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func configureUI() {
        let model = presenter.configure()
        shipNameLabel.text = model.name
        shipImageView.image = model.image
        shipTypeLabel.text = "Ship type: \(model.type)"
        builtYearLabel.text = "Built year: \(model.builtYear)"
        weightLabel.text = "Weight in kg: \(model.weight)"
        homePortLabel.text = "Home port: \(model.homePort)"
        rolesLabel.text = "Roles: \(model.roles)"
    }
}
