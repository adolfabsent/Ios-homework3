import UIKit

class FeedViewController: UIViewController {

    private var timer: Timer?
    var post = Post.init(title: "Мой пост")


    struct Post {
        var title: String
    }

    let coordinator: FeedCoordinator
    private let viewModel: FeedModel
    var checkWord: String = ""

    init(coordinator: FeedCoordinator, viewModel: FeedModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let guessWordView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var postButton: CustomButton = {
        let button = CustomButton(title: "Перейти на пост", titleColor: .black, backgroundColor: .green, buttonTap: pressPost)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postTwoButton: CustomButton = {
        let button = CustomButton(title: "InfoView", titleColor: .white, backgroundColor: .blue, buttonTap: secondPost)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()

    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check word", titleColor: .black, backgroundColor: .orange, buttonTap: buttonCheckWord)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var wordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a word"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var checkGuessLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .systemGray6
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var changeColorButton: CustomButton {
        let button = CustomButton(title: "Change background color", titleColor: .white, backgroundColor: .systemIndigo, buttonTap: timerChangeColor)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(postButton)
        buttonsStackView.addArrangedSubview(postTwoButton)
        buttonsStackView.addArrangedSubview(guessWordView)
        buttonsStackView.addArrangedSubview(changeColorButton)


        guessWordView.addArrangedSubview(wordTextField)
        guessWordView.addArrangedSubview(checkGuessButton)
        guessWordView.addArrangedSubview(checkGuessLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 110),

        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = ""
    }

    @objc func timerChangeColor(sender: UIButton!) {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] Timer in
                self?.view.backgroundColor = self?.getRandomColor()
            })
        } else {
            timer?.invalidate()
            timer = nil
        }

    }

    private func getRandomColor() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())

        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }

    @objc private func pressPost(sender: UIButton!) {
        let postVC = PostViewController()
        postVC.navigationItem.title = post.title
        self.navigationController?.pushViewController(postVC, animated: true)
        print("Post")
    }

    @objc private func secondPost(sender: UIButton!) {
        let infoVC = InfoViewController()
        self.navigationController?.pushViewController(infoVC, animated: true)
    }


    @objc func buttonCheckWord(sender: UIButton!) {
        let word = wordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var isCorrect = false
        do {
            isCorrect = try FeedModel().check(word: word)
            coordinator.present(.autorized)
        } catch feedError.unauthorized {
            coordinator.present(.error(.unauthorized))
        } catch feedError.notFound {
            coordinator.present(.error(.notFound))
        } catch feedError.isEmpty {
            coordinator.present(.error(.isEmpty))
        } catch {
            coordinator.present(.error(.unauthorized))
        }

        checkGuessLabel.textColor = isCorrect ? .green : .red
        checkGuessLabel.text = isCorrect ? "Верно" : "Не верно"
    }

}

extension UIView {
    func hideKeyboardTapped() {
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        self.addGestureRecognizer(press)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension UIColor {
    static var random:  UIColor {
        return  UIColor(red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1),
                        alpha: 1.0)
    }
}




