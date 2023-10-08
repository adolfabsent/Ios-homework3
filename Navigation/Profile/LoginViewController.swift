import UIKit


final class LogInViewController: UIViewController {

    private let notificationCenter = NotificationCenter.default

    public var loginDelegate: LoginViewControllerDelegate?

    let coordinator: ProfileCoordinator?

    private lazy var password: String = ""

    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        self.loginDelegate = LoginInspector()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logoVK"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var labelAlert: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.alpha = 0
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.red.cgColor
        label.backgroundColor = .yellow
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let separatingLine: UIView = {
            let separatingLine = UIView()
            separatingLine.backgroundColor = .lightGray
            return separatingLine
        }()

    private lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.masksToBounds = true
        return stackView
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textField.textColor = UIColor(named: "labelColor")
        textField.font = .systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = UIColor(named: "textFildBackgroundColor")
        textField.placeholder = "Email or phone"
        textField.text = "Raymond"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        textField.textColor = UIColor(named: "labelColor")
        textField.font = .systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = UIColor(named: "textFildBackgroundColor")
        textField.placeholder = "Введите Password"
        textField.text = "Raymond11"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var checkPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate Password", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.checkPasswordButtonDidTap), for: .touchUpInside)
        return button
    }()

    private let activityIndicator: UIActivityIndicatorView = {
          let indicator = UIActivityIndicatorView(style: .large)
          indicator.translatesAutoresizingMaskIntoConstraints = false
          return indicator
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
               navigationController?.setNavigationBarHidden(true, animated: true)
        self.configureSubviews()
        self.setupConstraints()
        self.setupLabelAlert()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        self.setupCheckPasswordButton()
        self.setupActivityIndicator()
    }

    private func setupCheckPasswordButton() {
            self.view.addSubview(checkPasswordButton)

            NSLayoutConstraint.activate([
                self.checkPasswordButton.topAnchor.constraint(equalTo: self.loginPasswordStackView.bottomAnchor, constant: 80),
                self.checkPasswordButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
                self.checkPasswordButton.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
                self.checkPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        }

        private func setupActivityIndicator() {
            self.view.addSubview(activityIndicator)
            activityIndicator.isHidden = true

            NSLayoutConstraint.activate([
                self.activityIndicator.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor),
                self.activityIndicator.centerXAnchor.constraint(equalTo: self.passwordTextField.centerXAnchor),
                self.activityIndicator.widthAnchor.constraint(equalToConstant: 50),
                self.activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            ])
        }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.navigationBar.isHidden = true
           let notificationCenter = NotificationCenter.default
           notificationCenter.addObserver(
               self,
               selector: #selector(keyboardShow),
               name: UIResponder.keyboardWillShowNotification,
               object: nil
           )

           notificationCenter.addObserver(
               self,
               selector: #selector(keyboardHide),
               name: UIResponder.keyboardWillHideNotification,
               object: nil
           )

           self.addTapGestureToHideKeyboard()
       }

       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           let notificationCenter = NotificationCenter.default
           notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

       }

    @objc private func checkPasswordButtonDidTap () {
    self.passwordTextField.isSecureTextEntry = true
            let allowCharacters: [String] = String().printable.map { String($0) }
            self.password = ""
            while self.password.count < 4 {
            let indexCharacter = Int.random(in: 0..<allowCharacters.count)
            self.password += allowCharacters[indexCharacter]
            }

            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()

            let brute = BruteForсe()
            DispatchQueue.global().async { [self] in
                let startTime = Date().timeIntervalSince1970
                brute.bruteForce(passwordToUnlock: self.password)
                print(Date().timeIntervalSince1970 - startTime)

                DispatchQueue.main.async {
                    self.passwordTextField.text = self.password
                    self.passwordTextField.isSecureTextEntry = false
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }

    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginPasswordStackView)
        contentView.addSubview(logInButton)
        contentView.addSubview(labelAlert)
        loginPasswordStackView.addArrangedSubview(loginTextField)
        loginPasswordStackView.addArrangedSubview(passwordTextField)
        loginPasswordStackView.addSubview(separatingLine)
    }
    
    private func setupLabelAlert() {
        self.contentView.addSubview(self.labelAlert)
        
        NSLayoutConstraint.activate([
            labelAlert.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 20),
            labelAlert.leadingAnchor.constraint(equalTo: self.loginPasswordStackView.leadingAnchor),
            labelAlert.trailingAnchor.constraint(equalTo: self.loginPasswordStackView.trailingAnchor),
            labelAlert.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            loginPasswordStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginPasswordStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginPasswordStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginPasswordStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: loginPasswordStackView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            separatingLine.leadingAnchor.constraint(equalTo: loginPasswordStackView.leadingAnchor),
            separatingLine.trailingAnchor.constraint(equalTo: loginPasswordStackView.trailingAnchor),
            separatingLine.heightAnchor.constraint(equalToConstant: 1),
            separatingLine.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
        ])
    }

    /** @objc private func buttonClicked() {
    let loginText = self.loginTextField.text
           let passwordText = self.passwordTextField.text

           if loginText != "" && passwordText != "" {
               #if DEBUG
                   let userService = TestUserService()
               #else
                   let userService = CurrentUserService()
               #endif

               let user = userService.authorization(login: loginText!)

               if user == nil || self.loginDelegate == nil {
                   self.showErrorAlert()
                   return
               }

               if ((loginDelegate?.checkLogin(login: loginTextField.text!))! && (loginDelegate?.checkPassword(password: passwordTextField.text!))!) == false {
                   self.showErrorAlert()
                   return
               }

               self.coordinator.setUser(user: user!)
               self.coordinator.startVC()
           } else {
               self.showErrorAlert()
           }
} */

    @objc private func loginButtonPressed() {
        let loginText = self.loginTextField.text
               let passwordText = self.passwordTextField.text

        if loginText != "" && passwordText != "" {
#if DEBUG
            let userService = TestUserService()
#else
            let userService = CurrentUserService()
#endif
            
            let user = userService.authorization(login: loginText!)

            self.coordinator?.setUser(user: user!)
            self.coordinator?.startVC()

        }

            checkLogin { result in
                switch result {
                case .success(let action):
                    if let mAction = action {
                        mAction()
                    }
                case .failure(.incorrectLogin):
                    coordinator?.showAlert(error: .incorrectLogin)
                case .failure(.incorrectPass):
                    coordinator?.showAlert(error: .incorrectPass)
                case .failure(.loginIsEmpty):
                    coordinator?.showAlert(error: .loginIsEmpty)
                case .failure(.passIsEmpty):
                    coordinator?.showAlert(error: .passIsEmpty)
                }
            }
        }

    private func checkLogin(completion: (Result<(() -> Void)?, Errors>) -> Void) {

           if loginTextField.text == "" || loginTextField.text == nil {
               completion(.failure(.loginIsEmpty))
           }

           if passwordTextField.text == "" || passwordTextField.text == nil {
               completion(.failure(.passIsEmpty))
           }

           if loginTextField.text == "Raymond" && passwordTextField.text == "Raymond11" {
               completion(.success(coordinator?.startVC))
           } else if !(loginDelegate?.checkLogin(login: loginTextField.text!))! {
               completion(.failure(.incorrectLogin))
           } else if !(loginDelegate?.checkPassword(password: passwordTextField.text!))! {
               completion(.failure(.incorrectPass))
           }
       }


       @objc private func keyboardShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               scrollView.contentInset.bottom = keyboardSize.height
               scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)

               if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                   let keyboardRectangle = keyboardFrame.cgRectValue
                   let keyboardHeight = keyboardRectangle.height
                   let contentOffset: CGPoint = notification.name == UIResponder.keyboardWillHideNotification ? .zero: CGPoint(x: 0, y: keyboardHeight)

                   self.scrollView.contentOffset = contentOffset
               }
           }
       }

       @objc
       private func keyboardHide(notification: NSNotification) {
           scrollView.contentInset.bottom = .zero
           scrollView.verticalScrollIndicatorInsets = .zero
       }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.loginTextField.resignFirstResponder()
           self.passwordTextField.resignFirstResponder()
           return true
       }
   }

extension LogInViewController: UITextFieldDelegate {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
