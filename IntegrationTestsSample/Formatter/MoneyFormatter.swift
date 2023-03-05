protocol MoneyFormatter {
    func format(money: Int) -> String
}

struct MoneyFormatterImpl: MoneyFormatter {
    func format(money: Int) -> String {
        if money < 100 {
            return "$\(money)"
        } else {
            return "$\(money) 💰"
        }
    }
}
