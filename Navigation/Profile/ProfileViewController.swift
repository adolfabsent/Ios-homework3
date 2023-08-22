import UIKit
import CoreData
import StorageService


class ProfileViewController : UIViewController {

    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        return profileHeader
    }()

    var liked: Bool = false

    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var avatarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .systemRed
        return view
    }()

    private lazy var alphaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cat"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.alpha = 0
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var avatarViewCenterXConstraint: NSLayoutConstraint?
    private var avatarViewCenterYConstraint: NSLayoutConstraint?
    private var avatarViewHeightConstraint: NSLayoutConstraint?
    private var avatarViewWidthConstraint: NSLayoutConstraint?
    private var isExpanded = false
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        self.setupView()
        self.setupGesture()
        self.setupConstraints()
        self.setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }

       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)

       }

    func tapLikedLabel() {
          liked.toggle()
          self.tableView.reloadData()
      }

    private func setupNavigationBar() {
           self.navigationController?.navigationBar.prefersLargeTitles = false
           self.navigationItem.title = "Profile"

       }


    private func setupView() {
        #if DEBUG
        view.backgroundColor = .red
        #else
        view.backgroundColor = .white
        #endif
        view.addSubview(tableView)
        view.addSubview(alphaView)
        view.addSubview(self.avatarView)
        avatarView.addSubview(self.myImageView)
        view.bringSubviewToFront(alphaView)
        view.addSubview(closeButton)
        view.bringSubviewToFront(avatarView)
        self.avatarView.layer.cornerRadius = 75
        self.alphaView.alpha = 0

        self.avatarViewCenterXConstraint = self.avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -1 * (screenWidth *  0.5 - 81))
        self.avatarViewCenterYConstraint = self.avatarView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -1 * (screenHeight * 0.5 - 126))
        self.avatarViewHeightConstraint = self.avatarView.heightAnchor.constraint(equalToConstant: 150)
        self.avatarViewWidthConstraint = self.avatarView.widthAnchor.constraint(equalToConstant: 150)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            self.avatarViewCenterXConstraint, self.avatarViewCenterYConstraint,
            self.avatarViewHeightConstraint, self.avatarViewWidthConstraint,

            myImageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            myImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),

            alphaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            alphaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            alphaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            alphaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ].compactMap({ $0 }))
    }

    private func setupGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.firstTapGesture(_ :)))
        self.avatarView.addGestureRecognizer(self.tapGestureRecognizer)
    }

    @objc func firstTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        self.isExpanded.toggle()
        self.avatarViewCenterXConstraint?.constant = self.isExpanded ? 0 : -1 * (screenWidth * 0.5 - 81)
        self.avatarViewCenterYConstraint?.constant = self.isExpanded ? 0 : -1 * (screenHeight * 0.5 - 126)
        self.avatarViewHeightConstraint?.constant = self.isExpanded ? screenWidth : 150
        self.avatarViewWidthConstraint?.constant = self.isExpanded ? screenWidth : 150

        UIView.animate(withDuration: 0.5) {
            self.avatarView.layer.cornerRadius = self.isExpanded ? 0 : 75
            self.alphaView.alpha = self.isExpanded ? 0.7 : 0
            self.view.layoutIfNeeded()
        } completion: { _ in
        }

        if self.isExpanded {
            self.alphaView.isHidden = false
            self.closeButton.isHidden = false
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = self.isExpanded ? 1 : 0
        } completion: { _ in
            self.closeButton.isHidden = !self.isExpanded
        }
    }

    @objc private func didTapCloseButton() {
        self.avatarViewCenterXConstraint?.constant = -1 * (screenWidth * 0.5 - 81)
        self.avatarViewCenterYConstraint?.constant = -1 * (screenHeight * 0.5 - 126)
        self.avatarViewHeightConstraint?.constant = 150
        self.avatarViewWidthConstraint?.constant = 150
        self.closeButton.alpha = 0

        UIView.animate(withDuration: 0.5) {
            self.avatarView.layer.cornerRadius = 75
            self.alphaView.alpha = 0
            self.view.layoutIfNeeded()
            self.closeButton.alpha = 0
        } completion: { _ in
            self.closeButton.isHidden = false
            self.isExpanded = false
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID", for: indexPath) as! PostTableViewCell

        let dataSource = post[indexPath.row]
        cell.setup(post: dataSource)
        return cell
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {

            let profile = ProfileHeaderView()
            return profile
        }
        return nil
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        }
        return 0
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(PostViewController(), animated: true)
        }
        else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
