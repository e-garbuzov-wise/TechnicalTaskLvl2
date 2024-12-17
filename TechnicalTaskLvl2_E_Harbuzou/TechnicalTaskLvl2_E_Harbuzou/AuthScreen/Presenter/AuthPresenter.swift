import Foundation

final class AuthPresenter {
    weak var view: AuthView?
    private let validUserData: [String: String] = ["login": "admin@gmail.com", "password": "12345678"]
    
    init(view: AuthView) {
        self.view = view
    }
    
    func loginTapped(login: String?, password: String?) {
        guard let login = login, let password = password, !login.isEmpty, !password.isEmpty else {
            view?.showLoginError("All fields are required")
            return
        }
        
        if login == validUserData["login"] && password == validUserData["password"]  {
            view?.showLoginSuccess()
        } else {
            view?.showLoginError("One of deteils is incorrect")
        }
    }
    
    func guestLoginTapped() {
        view?.showGuestLoginSuccess()
    }
}
