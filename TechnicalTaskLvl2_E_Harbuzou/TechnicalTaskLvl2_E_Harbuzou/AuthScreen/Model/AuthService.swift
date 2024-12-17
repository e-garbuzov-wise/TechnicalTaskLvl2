import UIKit

protocol Authentifable {
    func validateUser(login: String, password: String, completion: @escaping (Bool) -> Void)
}

final class AuthService: Authentifable {
    private let validUserData: [String: String] = ["login": "1", "password": "1"]
    
    func validateUser(login: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let isValid = (login == self.validUserData["login"] && password == self.validUserData["password"])
            completion(isValid)
        }
    }
}
