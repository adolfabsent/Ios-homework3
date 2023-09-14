//
//  FeedView.swift
//  Navigation
//
//  Created by Максим Зиновьев on 12.09.2023.
//

import UIKit

final class FeedView: UIView {

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
        let button = CustomButton(title: "Перейти на пост", titleColor: .black)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postTwoButton: CustomButton = {
        let button = CustomButton(title: "Перейти на пост", titleColor: .black)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()

    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check word", titleColor: .black)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .cyan
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

    lazy var answerLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()


     init() {
           super.init(frame: .zero)
           setupView()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       private func setupView() {
           addSubview(self.buttonsStackView)
           addSubview(answerLabel)
           buttonsStackView.addArrangedSubview(self.postButton)
           buttonsStackView.addArrangedSubview(self.postTwoButton)
           buttonsStackView.addArrangedSubview(self.guessWordView)

           guessWordView.addArrangedSubview(self.wordTextField)
           guessWordView.addArrangedSubview(self.checkGuessButton)
           guessWordView.addArrangedSubview(self.checkGuessLabel)

           setupConstraints()
       }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 110),

            answerLabel.topAnchor.constraint(equalTo: self.checkGuessButton.bottomAnchor, constant: 16),
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            answerLabel.heightAnchor.constraint(equalToConstant: 40),

        ])
    }
    

    //@objc func buttonCheckWord(sender: UIButton!) {

     //   let word = wordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      //  if word != "" {
       //     let feedModel = FeedModel()
        //    checkGuessLabel.backgroundColor = feedModel.check(word) ? .green : .red

         //   let alert = UIAlertController(
           //     title: feedModel.check(word) ? "Right" : "Wrong",
           //     message: feedModel.check(word) ? "Correct word" : "Try again.",
           //     preferredStyle: UIAlertController.Style.alert)
          //  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
          //  alert.view.tintColor = .black
           // self.present(alert, animated: true, completion: nil)
     //   } else {
       //     checkGuessLabel.text = ""
       //     checkGuessLabel.backgroundColor  = .gray

         //   let alert = UIAlertController(
         //       title: "Enter a word",
              //  message: "Enter a word and try again.",
           //     preferredStyle: UIAlertController.Style.alert)
          //  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
           // alert.view.tintColor = .black
        //    self.present(alert, animated: true, completion: nil)
       // }
   // }

    func setCheckGuessButtonTapAction(action: @escaping () -> Void) {
           checkGuessButton.tapAction = action
       }

       func setButtonTapAction(action: @escaping () -> Void) {
           checkGuessButton.tapAction = action
       }

       func getInputText() -> String {
           guard let text = wordTextField.text else {
               return ""
           }
           return text
       }

       func setLabelColor(_ color: UIColor) {
           answerLabel.backgroundColor = color
       }
   }

   private extension CGFloat {
       static let safeArea: CGFloat = 16
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
    

