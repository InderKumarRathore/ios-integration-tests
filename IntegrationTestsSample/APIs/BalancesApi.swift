import Foundation

protocol BalancesApi {
    func getBalances(completion: @escaping (Result<Int, Error>) -> Void)
    func sendMoney(amount: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

final class BalancesApiImpl: BalancesApi {
    private var dispatchTime: DispatchTime { DispatchTime.now() + 3 }
    func getBalances(completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            completion(.success(50))
        }
    }
    func sendMoney(amount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            completion(.failure(NSError(domain: "", code: 25)))
        }
    }
}
