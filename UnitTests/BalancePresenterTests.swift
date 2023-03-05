@testable import IntegrationTestsSample
import XCTest

final class BalancePresenterTests: XCTestCase {
    private var presenter: BalancePresenterImpl!
    private var router: BalanceRouterMock!
    private var interactor: BalanceInteractorMock!
    private var view: BalanceViewMock!
    private var moneyFormatter: MoneyFormatterMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        router = BalanceRouterMock()
        interactor = BalanceInteractorMock()
        view = BalanceViewMock()
        moneyFormatter = MoneyFormatterMock()
        presenter = BalancePresenterImpl(
            router: router,
            interactor: interactor,
            moneyFormatter: moneyFormatter
        )
        presenter.view = view
    }

    override func tearDownWithError() throws {
        presenter = nil
        router = nil
        view = nil
        interactor = nil
        moneyFormatter = nil
        try super.tearDownWithError()
    }


    func test_viewIsReady_whenApiIsSuccess() {
        interactor.fetchBalanceClosure = {
            $0(Result.success(100))
        }
        presenter.viewIsReady()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations.first,
            .init(balance: "asdfasd")
        )
    }
}
