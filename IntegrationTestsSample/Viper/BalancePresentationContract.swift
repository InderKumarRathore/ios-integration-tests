struct ViewModel: Equatable {
    let balance: String
}

protocol BalanceView: AnyObject {
    func configure(viewModel: ViewModel)
    func showError(message: String)
    func showLoading()
    func stopLoading()
}

protocol BalancePresenter {
    func viewIsReady()
    func sendMoneyTapped()
}

protocol BalanceRouter {

}
