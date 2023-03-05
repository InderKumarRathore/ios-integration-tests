import UIKit

struct BalanceFactory {

    func make() -> UIViewController {
        let router = BalanceRouterImpl()
        let interactor = BalanceInteractorImpl(balancesApi: BalancesApiImpl())
        let presenter = BalancePresenterImpl(
            router: router,
            interactor: interactor,
            moneyFormatter: MoneyFormatterImpl()
        )
        let viewController = BalanceViewController(presenter: presenter)

        router.viewController = viewController
        presenter.view = viewController
        return viewController
    }
}
