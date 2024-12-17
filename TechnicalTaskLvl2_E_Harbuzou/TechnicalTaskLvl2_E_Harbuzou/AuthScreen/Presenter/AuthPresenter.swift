import Combine

final class AuthPresenter {
    let loginResultPublisher = PassthroughSubject<Bool, Never>()
    let loadingPublisher = PassthroughSubject<Bool, Never>()
    let errorPublisher = PassthroughSubject<String, Never>()
    
    private let authService: Authentifable
    
    init(authService: Authentifable = AuthService()) {
        self.authService = authService
    }
    
    func loginTapped(login: String?, password: String?) {
        guard let login = login, let password = password, !login.isEmpty, !password.isEmpty else {
            errorPublisher.send("Fields cannot be empty.")
            return
        }
        
        loadingPublisher.send(true)
        authService.validateUser(login: login, password: password) { [weak self] success in
            self?.loadingPublisher.send(false)
            if success {
                self?.loginResultPublisher.send(true)
            } else {
                self?.errorPublisher.send("Invalid login or password.")
            }
        }
    }
    
    func guestLoginTapped() {
        loginResultPublisher.send(true)
    }
}
