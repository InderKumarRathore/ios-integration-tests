protocol MoneyFormatter {
    func format(money: Int) -> String
}

struct MoneyFormatterImpl: MoneyFormatter {
    func format(money: Int) -> String { "$\(money)" }
}
