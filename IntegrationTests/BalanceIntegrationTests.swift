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

    func test_whenViewIsReadyAndApiReturnsSuccessfully() {
        api.getBalancesClosure = {
            $0(.success(30))
        }

        presenter.viewIsReady()
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations[0],
            .init(balance: "Your balance is $30")
        )
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertTrue(api.getBalancesCalled)
    }

    func test_whenViewIsReadyAndApiFails() {
        api.getBalancesClosure = {
            $0(.failure(NSError(domain: "", code: 5)))
        }

        presenter.viewIsReady()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(api.getBalancesCalled)
        XCTAssertEqual(
            view.showErrorReceivedInvocations[0],
            "Something went wrong please try again"
        )
        XCTAssertTrue(view.stopLoadingCalled)
    }

    func test_sendMoneyTapped_whenApiIsSuccess() {
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
        XCTAssertEqual(
            view.configureReceivedInvocations[1],
            .init(balance: "Transaction successful")
        )
        XCTAssertTrue(view.stopLoadingCalled)
    }

    func test_sendMoneyTapped_whenApiIsFailure() {
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
        XCTAssertEqual(
            view.configureReceivedInvocations[1],
            .init(balance: "Insufficient balance")
        )
        XCTAssertTrue(view.stopLoadingCalled)
    }
}

