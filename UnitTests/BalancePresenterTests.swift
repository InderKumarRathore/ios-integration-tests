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
        moneyFormatter.formatReturnValue = "$30"

        presenter.viewIsReady()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations.first,
            .init(balance: "Your balance is $30")
        )
        XCTAssertTrue(view.stopLoadingCalled)
    }

    func test_viewIsReady_whenApiIsFailed() {
        interactor.fetchBalanceClosure = {
            $0(Result.failure(NSError(domain: "", code: 4)))
        }

        presenter.viewIsReady()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(view.showErrorCalled)
        XCTAssertEqual(
            view.showErrorReceivedInvocations.first,
            "Something went wrong please try again"
        )
        XCTAssertTrue(view.stopLoadingCalled)
    }

    func test_sendMoneyTapped_whenApiIsSuccess() {
        interactor.sendMoneyClosure = {
            $1(.success(()))
        }

        presenter.sendMoneyTapped()
        
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations[0],
            .init(balance: "Sending money...")
        )
        XCTAssertEqual(
            view.configureReceivedInvocations[1],
            .init(balance: "Transaction successful")
        )
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertEqual(interactor.sendMoneyReceivedArguments?.money, 100)
    }

    func test_sendMoneyTapped_whenApiIsFailure() {
        interactor.sendMoneyClosure = {
            $1(.failure(.insufficientBalance))
        }

        presenter.sendMoneyTapped()

        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertEqual(
            view.configureReceivedInvocations[0],
            .init(balance: "Sending money...")
        )
        XCTAssertEqual(
            view.configureReceivedInvocations[1],
            .init(balance: "Insufficient balance")
        )
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertEqual(interactor.sendMoneyReceivedArguments?.money, 100)
    }
}
