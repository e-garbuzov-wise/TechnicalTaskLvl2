import UIKit

final class ShipCell: UITableViewCell {
    private var presenter: ShipsListPresenter?
    
    private let shipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [shipImageView, nameLabel, typeLabel, yearLabel].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            shipImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shipImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            shipImageView.widthAnchor.constraint(equalToConstant: 50),
            shipImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: shipImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typeLabel.leadingAnchor.constraint(equalTo: shipImageView.trailingAnchor, constant: 16),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            yearLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
            yearLabel.leadingAnchor.constraint(equalTo: shipImageView.trailingAnchor, constant: 16),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with ship: Ship, presenter: ShipsListPresenter?) {
        self.presenter = presenter
        nameLabel.text = ship.name
        typeLabel.text = ship.type
        guard let buildYear = ship.builtYear else { return }
        yearLabel.text = "\(Constants.buildYear + String(buildYear))"
        if let url = ship.image {
            presenter?.loadImage(from: url) { [weak self] image in
                self?.shipImageView.image = image ?? UIImage(named: Constants.mockImage)
            }
        } else {
            shipImageView.image = UIImage(named: Constants.mockImage)
        }
    }
}
