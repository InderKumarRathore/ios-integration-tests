final class BalancePresenterImpl {
    weak var view: BalanceView?
    private let router: BalanceRouter
    private let interactor: BalanceInteractor

    init(router: BalanceRouter, interactor: BalanceInteractor) {
        self.router = router
        self.interactor = interactor
    }

}

extension BalancePresenterImpl: BalancePresenter {

    func viewIsReady() {
        view?.showLoading()
        interactor.fetchBalance() { [weak self] result in
            guard let self else { return }
            self.view?.stopLoading()
            switch result {
            case let .success(balance):
                self.view?.configure(viewModel: .init(balance: "Your balance is $\(balance)"))
            case .failure:
                self.view?.showError(message: "Something went wrong please try again")
            }
        }
    }

    func sendMoneyTapped() {
        view?.showLoading()
        view?.configure(viewModel: .init(balance: "Sending money..."))
        interactor.sendMoney(money: 100) { [weak self] result in
            guard let self else { return }
            self.view?.stopLoading()
            switch result {
            case .success:
                self.view?.configure(viewModel: .init(balance: "Transaction successful"))
            case .failure:
                self.view?.configure(viewModel: .init(balance: "Insufficient balance"))
            }
        }
    }
}
