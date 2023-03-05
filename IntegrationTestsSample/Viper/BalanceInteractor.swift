final class BalanceInteractorImpl {
    private let balancesApi: BalancesApi

    init(balancesApi: BalancesApi) {
        self.balancesApi = balancesApi
    }

}

// MARK: - BalanceInteractorInput

extension BalanceInteractorImpl: BalanceInteractor {
    func fetchBalance(completion: @escaping (Result<Int, Error>) -> Void) {
        balancesApi.getBalances {
            completion($0)
        }
    }

    func sendMoney(money: Int, completion: @escaping (Result<Void, BalanceError>) -> Void) {
        balancesApi.sendMoney(amount: money) {
            switch $0 {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.insufficientBalance))
            }
        }
    }
}
