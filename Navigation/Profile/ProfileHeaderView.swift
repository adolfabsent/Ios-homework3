
import UIKit
import SnapKit

final class ProfileHeaderView: UITableViewHeaderFooterView {

      var fullNameLabel = UILabel()
      var avatarImageView = UIImageView()
      var statusLabel = UILabel()
      var statusTextField = UITextField()
      var setStatusButton = UIButton()
      var returnAvatarButton = UIButton()
      var avatarBackground = UIView()

      private var statusText = "Status"
      private var avatarOriginPoint = CGPoint()


      override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)

          setupNameLabel()
          setupStatusLabel()
          setupStatusTextField()
          setupStatusButton()
          setupAvatarImage()
          layout()

          statusTextField.delegate = self
      }

      required init?(coder: NSCoder) {
          fatalError("lol")
      }

      private func setupNameLabel() {
          fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
          fullNameLabel.text = "Profile"
          fullNameLabel.font = .boldSystemFont(ofSize: 18)
          fullNameLabel.textColor = .black
          addSubview(fullNameLabel)
      }

      private func setupStatusLabel() {
          statusLabel.translatesAutoresizingMaskIntoConstraints = false
          statusLabel.text = statusText
          statusLabel.font = .systemFont(ofSize: 17)
          statusLabel.textColor = .black
          addSubview(statusLabel)
      }

      private func setupStatusTextField() {
          statusTextField.translatesAutoresizingMaskIntoConstraints = false
          statusTextField.textColor = .darkGray
          statusTextField.backgroundColor = .white

          let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
          statusTextField.leftView = paddingView
          statusTextField.leftViewMode = .always
          statusTextField.layer.cornerRadius = 8
          statusTextField.layer.borderWidth = 1
          statusTextField.layer.borderColor = UIColor.gray.cgColor
          statusTextField.attributedPlaceholder = NSAttributedString.init(string: "Listening to music...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
          statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
          addSubview(statusTextField)
      }

      private func setupStatusButton() {
          setStatusButton.translatesAutoresizingMaskIntoConstraints = false
          setStatusButton.backgroundColor = .systemBlue
          setStatusButton.layer.cornerRadius = LayoutConstants.cornerRadius
          setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
          setStatusButton.layer.shadowColor = UIColor.black.cgColor
          setStatusButton.layer.shadowRadius = 4
          setStatusButton.layer.shadowOpacity = 0.7
          setStatusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
          setStatusButton.setTitle("Show status", for: .normal)
          setStatusButton.setTitleColor(.white, for: .normal)
          setStatusButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
          addSubview(setStatusButton)
      }

      private func setupAvatarImage() {
          avatarImageView.translatesAutoresizingMaskIntoConstraints = false
          avatarImageView.image = UIImage(named: "cat")
          avatarImageView.layer.cornerRadius = 64
          avatarImageView.layer.borderWidth = 3
          avatarImageView.layer.borderColor = UIColor.white.cgColor
          avatarImageView.clipsToBounds = true

          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnAvatar))
          tapGesture.numberOfTapsRequired = 1
          tapGesture.numberOfTouchesRequired = 1
          avatarImageView.isUserInteractionEnabled = true
          avatarImageView.addGestureRecognizer(tapGesture)

          returnAvatarButton.translatesAutoresizingMaskIntoConstraints = false
          returnAvatarButton.alpha = 0
          returnAvatarButton.backgroundColor = .clear
          returnAvatarButton.contentMode = .scaleToFill
          returnAvatarButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.black, renderingMode: .automatic), for: .normal)
          returnAvatarButton.tintColor = .black
          returnAvatarButton.addTarget(self, action: #selector(returnAvatarToOrigin), for: .touchUpInside)

          avatarBackground = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
          avatarBackground.backgroundColor = .darkGray
          avatarBackground.isHidden = true
          avatarBackground.alpha = 0

          addSubviews(avatarBackground, avatarImageView, returnAvatarButton)

      }

    private func layout() {
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(156)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(16)
            make.height.equalTo(16)
    }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(16)
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.trailing.equalTo(fullNameLabel.snp.trailing)
            make.height.equalTo(fullNameLabel.snp.height)
        }

        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.trailing.equalTo(fullNameLabel.snp.trailing).offset(-24)
            make.height.equalTo(32)
        }

        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(48)
        }

        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.width.equalTo(128)
            make.height.equalTo(avatarImageView.snp.width)
        }

        returnAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
    
      @objc private func statusTextChanged(_ textField: UITextField) {
          statusText = textField.text ?? ""
      }

      @objc private func statusButtonPressed() {
          statusLabel.text = statusText
      }

      @objc private func didTapOnAvatar() {
          avatarImageView.isUserInteractionEnabled = false

          ProfileViewController.postTableView.isScrollEnabled = false
          ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false

          avatarOriginPoint = avatarImageView.center
          let scale = UIScreen.main.bounds.width / avatarImageView.bounds.width

          UIView.animate(withDuration: 0.5) {
              self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                    y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
              self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
              self.avatarImageView.layer.cornerRadius = 0
              self.avatarBackground.isHidden = false
              self.avatarBackground.alpha = 0.7
          } completion: { _ in
              UIView.animate(withDuration: 0.3) {
                  self.returnAvatarButton.alpha = 1
              }
          }
      }

      @objc private func returnAvatarToOrigin() {
          UIImageView.animate(withDuration: 0.5) {
              UIImageView.animate(withDuration: 0.5) {
                  self.returnAvatarButton.alpha = 0
                  self.avatarImageView.center = self.avatarOriginPoint
                  self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                  self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                  self.avatarBackground.alpha = 0
              }
          } completion: { _ in
              ProfileViewController.postTableView.isScrollEnabled = true
              ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
              self.avatarImageView.isUserInteractionEnabled = true
          }
      }
  }


  extension ProfileHeaderView: UITextFieldDelegate {

      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
  }
