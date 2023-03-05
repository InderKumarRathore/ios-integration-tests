import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }

    @IBAction func showBalance(_ sender: Any) {
        let assembly = BalanceFactory()
        let viewController = assembly.make()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
