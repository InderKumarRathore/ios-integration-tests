@testable import IntegrationTestsSample

final class BalanceInteractorMock: BalanceInteractor {
    // MARK: - fetchBalance

    private(set) var fetchBalanceReceivedCompletion: ((Result<Int, Error>) -> Void)?
    private(set) var fetchBalanceReceivedInvocations: [(Result<Int, Error>) -> Void] = []
    private(set) var fetchBalanceCallsCount = 0
    var fetchBalanceClosure: ((@escaping (Result<Int, Error>) -> Void) -> Void)?
    var fetchBalanceCalled: Bool {
        fetchBalanceCallsCount > 0
    }

    func fetchBalance(completion: @escaping (Result<Int, Error>) -> Void) {
        fetchBalanceCallsCount += 1
        fetchBalanceReceivedCompletion = completion
        fetchBalanceReceivedInvocations.append(completion)
        fetchBalanceClosure?(completion)
    }

    // MARK: - sendMoney

    private(set) var sendMoneyReceivedArguments: (money: Int, completion: (Result<Void, BalanceError>) -> Void)?
    private(set) var sendMoneyReceivedInvocations: [(money: Int, completion: (Result<Void, BalanceError>) -> Void)] = []
    private(set) var sendMoneyCallsCount = 0
    var sendMoneyClosure: ((Int, @escaping (Result<Void, BalanceError>) -> Void) -> Void)?
    var sendMoneyCalled: Bool {
        sendMoneyCallsCount > 0
    }

    func sendMoney(money: Int, completion: @escaping (Result<Void, BalanceError>) -> Void) {
        sendMoneyCallsCount += 1
        sendMoneyReceivedArguments = (money: money, completion: completion)
        sendMoneyReceivedInvocations.append((money: money, completion: completion))
        sendMoneyClosure?(money, completion)
    }
}

final class BalancePresenterMock: BalancePresenter {
    // MARK: - viewIsReady

    private(set) var viewIsReadyCallsCount = 0
    var viewIsReadyClosure: (() -> Void)?
    var viewIsReadyCalled: Bool {
        viewIsReadyCallsCount > 0
    }

    func viewIsReady() {
        viewIsReadyCallsCount += 1
        viewIsReadyClosure?()
    }

    // MARK: - sendMoneyTapped

    private(set) var sendMoneyTappedCallsCount = 0
    var sendMoneyTappedClosure: (() -> Void)?
    var sendMoneyTappedCalled: Bool {
        sendMoneyTappedCallsCount > 0
    }

    func sendMoneyTapped() {
        sendMoneyTappedCallsCount += 1
        sendMoneyTappedClosure?()
    }
}

final class BalanceRouterMock: BalanceRouter {}

final class BalanceViewMock: BalanceView {
    // MARK: - configure

    private(set) var configureReceivedViewModel: ViewModel?
    private(set) var configureReceivedInvocations: [ViewModel] = []
    private(set) var configureCallsCount = 0
    var configureClosure: ((ViewModel) -> Void)?
    var configureCalled: Bool {
        configureCallsCount > 0
    }

    func configure(viewModel: ViewModel) {
        configureCallsCount += 1
        configureReceivedViewModel = viewModel
        configureReceivedInvocations.append(viewModel)
        configureClosure?(viewModel)
    }

    // MARK: - showError

    private(set) var showErrorReceivedMessage: String?
    private(set) var showErrorReceivedInvocations: [String] = []
    private(set) var showErrorCallsCount = 0
    var showErrorClosure: ((String) -> Void)?
    var showErrorCalled: Bool {
        showErrorCallsCount > 0
    }

    func showError(message: String) {
        showErrorCallsCount += 1
        showErrorReceivedMessage = message
        showErrorReceivedInvocations.append(message)
        showErrorClosure?(message)
    }

    // MARK: - showLoading

    private(set) var showLoadingCallsCount = 0
    var showLoadingClosure: (() -> Void)?
    var showLoadingCalled: Bool {
        showLoadingCallsCount > 0
    }

    func showLoading() {
        showLoadingCallsCount += 1
        showLoadingClosure?()
    }

    // MARK: - stopLoading

    private(set) var stopLoadingCallsCount = 0
    var stopLoadingClosure: (() -> Void)?
    var stopLoadingCalled: Bool {
        stopLoadingCallsCount > 0
    }

    func stopLoading() {
        stopLoadingCallsCount += 1
        stopLoadingClosure?()
    }
}

final class BalancesApiMock: BalancesApi {
    // MARK: - getBalances

    private(set) var getBalancesReceivedCompletion: ((Result<Int, Error>) -> Void)?
    private(set) var getBalancesReceivedInvocations: [(Result<Int, Error>) -> Void] = []
    private(set) var getBalancesCallsCount = 0
    var getBalancesClosure: ((@escaping (Result<Int, Error>) -> Void) -> Void)?
    var getBalancesCalled: Bool {
        getBalancesCallsCount > 0
    }

    func getBalances(completion: @escaping (Result<Int, Error>) -> Void) {
        getBalancesCallsCount += 1
        getBalancesReceivedCompletion = completion
        getBalancesReceivedInvocations.append(completion)
        getBalancesClosure?(completion)
    }

    // MARK: - sendMoney

    private(set) var sendMoneyReceivedArguments: (amount: Int, completion: (Result<Void, Error>) -> Void)?
    private(set) var sendMoneyReceivedInvocations: [(amount: Int, completion: (Result<Void, Error>) -> Void)] = []
    private(set) var sendMoneyCallsCount = 0
    var sendMoneyClosure: ((Int, @escaping (Result<Void, Error>) -> Void) -> Void)?
    var sendMoneyCalled: Bool {
        sendMoneyCallsCount > 0
    }

    func sendMoney(amount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        sendMoneyCallsCount += 1
        sendMoneyReceivedArguments = (amount: amount, completion: completion)
        sendMoneyReceivedInvocations.append((amount: amount, completion: completion))
        sendMoneyClosure?(amount, completion)
    }
}
