import Combine

final class AuthPresenter {
    let loginResultPublisher = PassthroughSubject<Bool, Never>()
    //TODO: change the data before PR
    private let validUserData: [String: String] = ["login": "1", "password": "1"]
    
    func loginTapped(login: String?, password: String?) {
        guard let login = login, let password = password, !login.isEmpty, !password.isEmpty else {
            loginResultPublisher.send(false)
            return
        }
        
        if login == validUserData["login"] && password == validUserData["password"]  {
            loginResultPublisher.send(true)
        } else {
            loginResultPublisher.send(false)
        }
    }
    
    func guestLoginTapped() {
        loginResultPublisher.send(true)
    }
}
