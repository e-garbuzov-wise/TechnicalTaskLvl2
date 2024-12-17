import UIKit

final class AuthViewController: UIViewController, AuthView {
    private var presenter: AuthPresenter!
    
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
        presenter = AuthPresenter(view: self)
    }
    
    func showLoginSuccess() {
           print("Login success!")
       }
       
       func showLoginError(_ message: String) {
           print("Login Error: \(message)")
       }
       
       func showGuestLoginSuccess() {
           print("Guest Login Success!")
       }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(guestLoginButton)
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        guestLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            loginTextField.widthAnchor.constraint(equalToConstant: 250),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            guestLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            guestLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        guestLoginButton.addTarget(self, action: #selector(handleGuestLogin), for: .touchUpInside)
    }
    
    @objc private func handleLogin() {
           let login = loginTextField.text
           let password = passwordTextField.text
           presenter.loginTapped(login: login, password: password)
       }
    @objc private func handleGuestLogin() {
            presenter.guestLoginTapped()
        }
}


