import UIKit

struct BalanceAssembly {

    func build() -> UIViewController {
        let router = BalanceRouterImpl()
        let interactor = BalanceInteractorImpl(balancesApi: BalancesApiImpl())
        let presenter = BalancePresenterImpl(router: router, interactor: interactor)
        let viewController = BalanceViewController(presenter: presenter)

        router.viewController = viewController
        presenter.view = viewController
        return viewController
    }
}
