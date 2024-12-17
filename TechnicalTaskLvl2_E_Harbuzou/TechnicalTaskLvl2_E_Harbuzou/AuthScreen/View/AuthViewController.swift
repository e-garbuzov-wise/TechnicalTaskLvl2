import UIKit
import Combine

final class AuthViewController: UIViewController {
    private var presenter = AuthPresenter()
    private var cancellables = Set<AnyCancellable>()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.login
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.password
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.login, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    private let guestLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.guestLoginTitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindPresenter()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [loginTextField, passwordTextField, loginButton, guestLoginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            loginTextField.widthAnchor.constraint(equalToConstant: 250),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            guestLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            guestLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        guestLoginButton.addTarget(self, action: #selector(handleGuestLogin), for: .touchUpInside)
    }
    
    private func bindPresenter() {
        presenter.loginResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSuccess in
                if isSuccess {
                    self?.showActivityIndicatorAndNavigate()
                } else {
                    self?.showErrorAlert()
                }
            }
            .store(in: &cancellables)
    }
    
    private func showActivityIndicatorAndNavigate() {
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.navigateToShipList()
        }
    }
    
    private func navigateToShipList() {
        let shipListVC = ShipsListViewController()
        shipListVC.modalPresentationStyle = .fullScreen
        present(shipListVC, animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "One of fields is invalid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func handleLogin() {
        let login = loginTextField.text
        let password = passwordTextField.text
        presenter.loginTapped(login: login, password: password)
    }
    
    @objc private func handleGuestLogin() {
        navigateToShipList()
    }
}
