import UIKit

final class BalanceViewController: UIViewController {

    private let presenter: BalancePresenter

    private let titleLabel = UILabel()
    private let button = UIButton()
    private let loader = UIActivityIndicatorView(style: .large)

    init(presenter: BalancePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Balance"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.viewIsReady()
    }

}

// MARK: - BalanceViewInput

extension BalanceViewController: BalanceView {
    func configure(viewModel: ViewModel) {
        titleLabel.text = viewModel.balance
    }

    func showError(message: String) {
        titleLabel.text = message
    }
    func showLoading() {
        loader.startAnimating()
    }

    func stopLoading() {
        loader.stopAnimating()
    }
}

private extension BalanceViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        titleLabel.textAlignment = .center

        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loader.stopAnimating()

        button.setTitle("Send $100", for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        button.backgroundColor = UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    }

    @objc
    func sendButtonTapped() {
        presenter.sendMoneyTapped()
    }
}
