@testable import IntegrationTestsSample
import XCTest

final class BalanceInteractorTests: XCTestCase {
    private var interactor: BalanceInteractorImpl!
    private var balancesApi: BalancesApiMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        balancesApi = BalancesApiMock()
        interactor = BalanceInteractorImpl(balancesApi: balancesApi)
    }

    override func tearDownWithError() throws {
        interactor = nil
        balancesApi = nil
        try super.tearDownWithError()
    }

    func test_fetchBalance() {
        balancesApi.getBalancesClosure = {
            $0(.success(10))
        }

        var result: Result<Int, Error>?
        interactor.fetchBalance {
            result = $0
        }

        XCTAssertTrue(balancesApi.getBalancesCalled)
        XCTAssertNotNil(result)
    }

    func test_sendMoney() {
        balancesApi.sendMoneyClosure = {
            $1(.success(()))
        }

        var result: Result<Void, BalanceError>?
        interactor.sendMoney(money: 10) {
            result = $0
        }

        XCTAssertTrue(balancesApi.sendMoneyCalled)
        XCTAssertEqual(balancesApi.sendMoneyReceivedArguments?.amount, 10)
        XCTAssertNotNil(result)
    }
}
