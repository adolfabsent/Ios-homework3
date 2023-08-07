import Foundation
import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    
    private lazy var myImageView: UIImageView = {
        let myImage = UIImageView()
        myImage.image = UIImage(named: "cat.png")
        myImage.layer.borderWidth = 3.0
        myImage.layer.borderColor = UIColor.white.cgColor
        myImage.layer.cornerRadius = 50
        myImage.clipsToBounds = true
        myImage.translatesAutoresizingMaskIntoConstraints = false
        return myImage
    }()
    
    private lazy var newButton: UIButton = {
        let myButton = UIButton()
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.backgroundColor = .blue
        myButton.setTitle ("Show Status", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.layer.cornerRadius = 4.0
        myButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        myButton.layer.shadowOffset = CGSizeMake(4.0, 4.0)
        myButton.layer.shadowRadius = 4.0
        myButton.layer.shadowOpacity = 0.7
        myButton.layer.shadowColor = UIColor.black.cgColor
        return myButton
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var labelStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Waiting for something..."
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Listening to music"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.textColor = .black
        return textField
    }()
    
    private var statusText = "Listening to music..."
    private var buttonTopConstraint: NSLayoutConstraint?
    weak var delegate: ProfileHeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(myImageView)
        addSubview(statusTextField)
        addSubview(newButton)
        addSubview(labelName)
        addSubview(labelStatus)
        setupConstraint()
        statusTextField.delegate = self
    }
    
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            myImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            myImageView.widthAnchor.constraint(equalToConstant: 150),
            myImageView.heightAnchor.constraint(equalToConstant: 150),
            labelName.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 182),
            labelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            newButton.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 16),
            newButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            newButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            newButton.heightAnchor.constraint(equalToConstant: 50),
            statusTextField.bottomAnchor.constraint(equalTo: newButton.topAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: labelStatus.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: labelStatus.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 34),
            labelStatus.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16),
            labelStatus.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelStatus.trailingAnchor.constraint(equalTo: labelName.trailingAnchor)
        ])
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func buttonPressed() {
        if let status = self.labelStatus.text {
            print("\(status)")
        }
    }
}
