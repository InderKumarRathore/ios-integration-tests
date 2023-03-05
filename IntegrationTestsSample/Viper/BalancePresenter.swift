final class BalancePresenterImpl {
    weak var view: BalanceView?
    private let router: BalanceRouter
    private let interactor: BalanceInteractor
    private let moneyFormatter: MoneyFormatter

    init(
        router: BalanceRouter,
        interactor: BalanceInteractor,
        moneyFormatter: MoneyFormatter
    ) {
        self.router = router
        self.interactor = interactor
        self.moneyFormatter = moneyFormatter
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
                let money = self.moneyFormatter.format(money: balance)
                self.view?.configure(viewModel: .init(balance: "Your balance is \(money)"))
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
