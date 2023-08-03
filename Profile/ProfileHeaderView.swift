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
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var labelStatus: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Listening to music"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.textColor = .black
        //textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    private var statusText = "Listening to music..."
    
    private var buttonTopConstraint: NSLayoutConstraint?
    
    weak var delegate: ProfileHeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView()  {
        self.addSubview(self.myImageView)
        self.addSubview(self.statusTextField)
        self.addSubview(self.newButton)
        self.addSubview(labelsStackView)
        self.labelsStackView.addArrangedSubview(self.labelName)
        self.labelsStackView.addArrangedSubview(self.labelStatus)
        self.addSubview(self.infoStackView)
        setupConstraint()
        statusTextField.delegate = self
    }
    
    private func setupConstraint() {
        
        let labelStackLeadingConstraint = self.labelsStackView.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 16)
        let labelStackTrailingConstraint = self.labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        let topLabelConstraint = self.labelsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let avatarTopConstraint = self.myImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        let avatarLeadingConstraint = self.myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let avatarHeightConstraint = self.myImageView.heightAnchor.constraint(equalToConstant: 138)
        let avatarWidthConstraint = self.myImageView.widthAnchor.constraint(equalToConstant: 138)
        let topStatusTextConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.labelsStackView.bottomAnchor, constant: 5)
        let leadingStatusTextConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.labelsStackView.leadingAnchor)
        let trailingStatusTextConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.labelsStackView.trailingAnchor)
        let heightStatusTextConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        let buttonTopConstraint = self.newButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.newButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.newButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let bottomButtonConstraint = self.newButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.newButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([labelStackLeadingConstraint, labelStackTrailingConstraint, topLabelConstraint, avatarTopConstraint, avatarLeadingConstraint, avatarWidthConstraint, avatarHeightConstraint, topStatusTextConstraint, leadingStatusTextConstraint, trailingStatusTextConstraint, heightStatusTextConstraint, buttonTopConstraint, leadingButtonConstraint, trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint])
        statusTextField.delegate = self
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func buttonPressed() {
        if let status = self.labelStatus.text {
            print("\(status)")
        }
        
        let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: -10)
        let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.labelsStackView.leadingAnchor)
        let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let heightTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        self.buttonTopConstraint = self.newButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        
        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            self.buttonTopConstraint?.isActive = false
            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonTopConstraint
            ].compactMap({ $0 }))
        } else {
            self.statusTextField.removeFromSuperview()
            NSLayoutConstraint.deactivate([topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint].compactMap({ $0 }))
        }
        
        self.delegate?.buttonPressed(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }
}

