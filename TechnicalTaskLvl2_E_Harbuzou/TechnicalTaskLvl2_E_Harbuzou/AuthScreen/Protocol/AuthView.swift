protocol AuthView: AnyObject {
    func showLoginSuccess()
    func showLoginError(_ message: String)
    func showGuestLoginSuccess()
}
