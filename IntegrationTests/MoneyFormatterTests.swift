@testable import IntegrationTestsSample
import XCTest

final class MoneyFormatterTests: XCTestCase {
    private var formatter: MoneyFormatterImpl!

    override func setUpWithError() throws {
        try super.setUpWithError()
        formatter = MoneyFormatterImpl()
    }

    override func tearDownWithError() throws {
        formatter = nil
        try super.tearDownWithError()
    }

    func test_whenAmountIsLessThanHundred() {
        let result = formatter.format(money: 99)
        XCTAssertEqual(result, "$99")
    }

    func test_whenAmountIsGreaterThanHundred() {
        let result = formatter.format(money: 101)
        XCTAssertEqual(result, "$101 💰")
    }
}
