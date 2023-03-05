@testable import IntegrationTestsSample
import XCTest

final class BalancePresenter: XCTestCase {
    private var presenter: BalancePresenterImpl!
    private var router: BalanceRouterMock!
    private var interactor: BalanceInteractorMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = BalancePresenterImpl(
            router: router,
            interactor: interactor
        )
    }

    override func tearDownWithError() throws {
        presenter = nil
        router = nil
        interactor = nil
        try super.tearDownWithError()
    }


}
