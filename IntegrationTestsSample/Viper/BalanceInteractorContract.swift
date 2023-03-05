
enum BalanceError: Error {
    case insufficientBalance
}
protocol BalanceInteractor {
    func fetchBalance(completion: @escaping (Result<Int, Error>) -> Void)
    func sendMoney(money: Int, completion: @escaping (Result<Void, BalanceError>) -> Void)
}
