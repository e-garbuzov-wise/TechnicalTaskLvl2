import Foundation
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
        guard let login = login, !login.isEmpty, isValidLogin(login) else {
            errorPublisher.send("Invalid login format.")
            return
        }
        
        guard let password = password, !password.isEmpty else {
            errorPublisher.send("Password cannot be empty.")
            return
        }
        
        loadingPublisher.send(true)
        authService.validateUser(login: login, password: password) { [weak self] success in
            self?.loadingPublisher.send(false)
            if success {
                self?.loginResultPublisher.send(false)
            } else {
                self?.errorPublisher.send("Invalid login or password.")
            }
        }
    }
    
    private func isValidLogin(_ login: String) -> Bool {
        let loginRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let loginTest = NSPredicate(format: "SELF MATCHES %@", loginRegex)
        return loginTest.evaluate(with: login)
    }
}
