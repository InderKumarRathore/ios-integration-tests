
internal final class BalanceInteractorMock: BalanceInteractor {
    // MARK: - fetchBalance

    internal private(set) var fetchBalanceReceivedCompletion: ((Result<Int, Error>) -> Void)?
    internal private(set) var fetchBalanceReceivedInvocations: [(Result<Int, Error>) -> Void] = []
    internal private(set) var fetchBalanceCallsCount = 0
    internal var fetchBalanceClosure: ((@escaping (Result<Int, Error>) -> Void) -> Void)?
    internal var fetchBalanceCalled: Bool {
        fetchBalanceCallsCount > 0
    }

    internal func fetchBalance(completion: @escaping (Result<Int, Error>) -> Void) {
        fetchBalanceCallsCount += 1
        fetchBalanceReceivedCompletion = completion
        fetchBalanceReceivedInvocations.append(completion)
        fetchBalanceClosure?(completion)
    }

    // MARK: - sendMoney

    internal private(set) var sendMoneyReceivedArguments: (money: Int, completion: (Result<Void, BalanceError>) -> Void)?
    internal private(set) var sendMoneyReceivedInvocations: [(money: Int, completion: (Result<Void, BalanceError>) -> Void)] = []
    internal private(set) var sendMoneyCallsCount = 0
    internal var sendMoneyClosure: ((Int, @escaping (Result<Void, BalanceError>) -> Void) -> Void)?
    internal var sendMoneyCalled: Bool {
        sendMoneyCallsCount > 0
    }

    internal func sendMoney(money: Int, completion: @escaping (Result<Void, BalanceError>) -> Void) {
        sendMoneyCallsCount += 1
        sendMoneyReceivedArguments = (money: money, completion: completion)
        sendMoneyReceivedInvocations.append((money: money, completion: completion))
        sendMoneyClosure?(money, completion)
    }
}

internal final class BalancePresenterMock: BalancePresenter {
    // MARK: - viewIsReady

    internal private(set) var viewIsReadyCallsCount = 0
    internal var viewIsReadyClosure: (() -> Void)?
    internal var viewIsReadyCalled: Bool {
        viewIsReadyCallsCount > 0
    }

    internal func viewIsReady() {
        viewIsReadyCallsCount += 1
        viewIsReadyClosure?()
    }

    // MARK: - sendMoneyTapped

    internal private(set) var sendMoneyTappedCallsCount = 0
    internal var sendMoneyTappedClosure: (() -> Void)?
    internal var sendMoneyTappedCalled: Bool {
        sendMoneyTappedCallsCount > 0
    }

    internal func sendMoneyTapped() {
        sendMoneyTappedCallsCount += 1
        sendMoneyTappedClosure?()
    }
}

internal final class BalanceRouterMock: BalanceRouter {}

internal final class BalanceViewMock: BalanceView {
    // MARK: - configure

    internal private(set) var configureReceivedViewModel: ViewModel?
    internal private(set) var configureReceivedInvocations: [ViewModel] = []
    internal private(set) var configureCallsCount = 0
    internal var configureClosure: ((ViewModel) -> Void)?
    internal var configureCalled: Bool {
        configureCallsCount > 0
    }

    internal func configure(viewModel: ViewModel) {
        configureCallsCount += 1
        configureReceivedViewModel = viewModel
        configureReceivedInvocations.append(viewModel)
        configureClosure?(viewModel)
    }

    // MARK: - showError

    internal private(set) var showErrorReceivedMessage: String?
    internal private(set) var showErrorReceivedInvocations: [String] = []
    internal private(set) var showErrorCallsCount = 0
    internal var showErrorClosure: ((String) -> Void)?
    internal var showErrorCalled: Bool {
        showErrorCallsCount > 0
    }

    internal func showError(message: String) {
        showErrorCallsCount += 1
        showErrorReceivedMessage = message
        showErrorReceivedInvocations.append(message)
        showErrorClosure?(message)
    }

    // MARK: - showLoading

    internal private(set) var showLoadingCallsCount = 0
    internal var showLoadingClosure: (() -> Void)?
    internal var showLoadingCalled: Bool {
        showLoadingCallsCount > 0
    }

    internal func showLoading() {
        showLoadingCallsCount += 1
        showLoadingClosure?()
    }

    // MARK: - stopLoading

    internal private(set) var stopLoadingCallsCount = 0
    internal var stopLoadingClosure: (() -> Void)?
    internal var stopLoadingCalled: Bool {
        stopLoadingCallsCount > 0
    }

    internal func stopLoading() {
        stopLoadingCallsCount += 1
        stopLoadingClosure?()
    }
}

internal final class BalancesApiMock: BalancesApi {
    // MARK: - getBalances

    internal private(set) var getBalancesReceivedCompletion: ((Result<Int, Error>) -> Void)?
    internal private(set) var getBalancesReceivedInvocations: [(Result<Int, Error>) -> Void] = []
    internal private(set) var getBalancesCallsCount = 0
    internal var getBalancesClosure: ((@escaping (Result<Int, Error>) -> Void) -> Void)?
    internal var getBalancesCalled: Bool {
        getBalancesCallsCount > 0
    }

    internal func getBalances(completion: @escaping (Result<Int, Error>) -> Void) {
        getBalancesCallsCount += 1
        getBalancesReceivedCompletion = completion
        getBalancesReceivedInvocations.append(completion)
        getBalancesClosure?(completion)
    }

    // MARK: - sendMoney

    internal private(set) var sendMoneyReceivedArguments: (amount: Int, completion: (Result<Void, Error>) -> Void)?
    internal private(set) var sendMoneyReceivedInvocations: [(amount: Int, completion: (Result<Void, Error>) -> Void)] = []
    internal private(set) var sendMoneyCallsCount = 0
    internal var sendMoneyClosure: ((Int, @escaping (Result<Void, Error>) -> Void) -> Void)?
    internal var sendMoneyCalled: Bool {
        sendMoneyCallsCount > 0
    }

    internal func sendMoney(amount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        sendMoneyCallsCount += 1
        sendMoneyReceivedArguments = (amount: amount, completion: completion)
        sendMoneyReceivedInvocations.append((amount: amount, completion: completion))
        sendMoneyClosure?(amount, completion)
    }
}
