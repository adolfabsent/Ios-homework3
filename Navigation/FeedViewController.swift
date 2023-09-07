import UIKit

class FeedViewController: UIViewController {

    var post = Post.init(title: "Мой пост")

    struct Post {
        var title: String
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
        let button = CustomButton(title: "Перейти на пост", titleColor: .white, backgroundColor: .blue, buttonTap: pressPost)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(postButton)
        buttonsStackView.addArrangedSubview(postTwoButton)
        buttonsStackView.addArrangedSubview(guessWordView)

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
    
    @objc private func pressPost(sender: UIButton!) {
        let postVC = PostViewController()
        postVC.navigationItem.title = post.title
        self.navigationController?.pushViewController(postVC, animated: true)
        print("Post")
    }
    
    @objc func buttonCheckWord(sender: UIButton!) {

        let word = wordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if word != "" {
            let feedModel = FeedModel()
            checkGuessLabel.backgroundColor = feedModel.check(word) ? .green : .red

            let alert = UIAlertController(
                title: feedModel.check(word) ? "Right" : "Wrong",
                message: feedModel.check(word) ? "Correct word" : "Try again.",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            alert.view.tintColor = .black
            self.present(alert, animated: true, completion: nil)
        } else {
            checkGuessLabel.text = ""
            checkGuessLabel.backgroundColor  = .gray

            let alert = UIAlertController(
                title: "Enter a word",
                message: "Enter a word and try again.",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            alert.view.tintColor = .black
            self.present(alert, animated: true, completion: nil)
        }
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
