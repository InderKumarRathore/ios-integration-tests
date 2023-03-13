@testable import IntegrationTestsSample
import XCTest

final class BalanceIntegrationTests: XCTestCase {
    private var presenter: BalancePresenter!
    private var view: BalanceViewMock!
    private var api: BalancesApiMock!
    private var viewController: UIViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()

        // module setup
        api = BalancesApiMock()
        view = BalanceViewMock()
        let router = BalanceRouterImpl()
        let interactor = BalanceInteractorImpl(balancesApi: api)
        let presenter = BalancePresenterImpl(
            router: router,
            interactor: interactor,
            moneyFormatter: MoneyFormatterImpl()
        )
        viewController = UIViewController()
        router.viewController = viewController
        presenter.view = view
        self.presenter = presenter
    }

    override func tearDownWithError() throws {
        presenter = nil
        view = nil
        api = nil
        viewController = nil
        try super.tearDownWithError()
    }

    func test_whenViewIsReadyAndApiReturnsSuccessfully_thenBalanceIsShown() {
        api.getBalancesClosure = {
            $0(.success(30))
        }

        presenter.viewIsReady()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(api.getBalancesCalled)
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations[0],
            .init(balance: "Your balance is $30")
        )
    }

    func test_whenViewIsReadyAndApiFails_thenErrorMessageIsShown() {
        api.getBalancesClosure = {
            $0(.failure(NSError(domain: "", code: 5)))
        }

        presenter.viewIsReady()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(api.getBalancesCalled)
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertEqual(
            view.showErrorReceivedInvocations[0],
            "Something went wrong please try again"
        )
    }

    func test_sendMoneyTapped_whenApiIsSuccess_thenSuccessMessageIsShown() {
        api.sendMoneyClosure = {
            $1(.success(()))
        }

        presenter.sendMoneyTapped()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(api.sendMoneyCalled)
        XCTAssertEqual(api.sendMoneyReceivedArguments?.amount, 100)
        XCTAssertEqual(
            view.configureReceivedInvocations[0],
            .init(balance: "Sending money...")
        )
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations[1],
            .init(balance: "Transaction successful")
        )
    }

    func test_sendMoneyTapped_whenApiIsFailure_thenErrorMessageIsShown() {
        api.sendMoneyClosure = {
            $1(.failure(NSError(domain: "", code: 10)))
        }

        presenter.sendMoneyTapped()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(api.sendMoneyCalled)
        XCTAssertEqual(api.sendMoneyReceivedArguments?.amount, 100)
        XCTAssertEqual(
            view.configureReceivedInvocations[0],
            .init(balance: "Sending money...")
        )
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations[1],
            .init(balance: "Insufficient balance")
        )
    }
}

