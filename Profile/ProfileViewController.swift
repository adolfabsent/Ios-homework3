import UIKit
import CoreData

/*import Foundation
import UIKit

class ProfileViewContoller: UIViewController, UITableViewDelegate {
    
    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        return profileHeader
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var tableHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = tableHeaderView
        view.addSubview(tableView)
        view.addSubview(tableHeaderView)
        setupConstraints()
        self.view.backgroundColor = .lightGray
    }

    
    override func viewWillAppear(_ animated: Bool) {
                  super.viewWillAppear(animated)
                  self.tabBarController?.tabBar.isHidden = false
                  self.navigationController?.navigationBar.isHidden = true
                  }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor),
            tableHeaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            tableHeaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            tableHeaderView.heightAnchor.constraint(equalToConstant: 220),
            tableHeaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
        
    }
}
 */

class ProfileViewController : UIViewController {

    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        return profileHeader
    }()

    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileCellID")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var copyAvatar : UIImageView = {
        let copyAvatar = UIImageView()
        copyAvatar.image = UIImage(named: "hypno")
        copyAvatar.clipsToBounds = true
        copyAvatar.layer.cornerRadius = 25
        copyAvatar.isUserInteractionEnabled = true
        copyAvatar.isHidden = true
        copyAvatar.translatesAutoresizingMaskIntoConstraints = false
        return copyAvatar
    }()

    private lazy var sizeOfAvatar : CGPoint = CGPoint(x: copyAvatar.frame.size.width, y: copyAvatar.frame.size.height)
    private lazy var spaceToAvatar : CGPoint = CGPoint(x: copyAvatar.frame.origin.x, y: copyAvatar.frame.origin.y)

    private lazy var blurView : UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.isHidden = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    private lazy var closeButton : UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.layer.cornerRadius = 20
        closeButton.isHidden = true
        closeButton.clipsToBounds = true
        closeButton.isUserInteractionEnabled = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()

    }
    private func layout() {
        #if DEBUG
        view.backgroundColor = .red
        #else
        view.backgroundColor = .white
        #endif
        view.addSubview(tableView)
        view.addSubview(blurView)
        view.addSubview(copyAvatar)
        view.addSubview(closeButton)
        setupNavBar()
        setupConstraints()
        avatarTapGesture()
        closeButtonTapGesture()

        let blurViewEffect = UIBlurEffect(style: .systemChromeMaterialLight)
        blurView.effect = blurViewEffect
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            copyAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            copyAvatar.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 16),
            copyAvatar.widthAnchor.constraint(equalToConstant: 100),
            copyAvatar.heightAnchor.constraint(equalToConstant: 100),

            closeButton.heightAnchor.constraint(equalToConstant: 60),
            closeButton.widthAnchor.constraint(equalToConstant: 60),
            closeButton.topAnchor.constraint(equalTo: blurView.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -16)
        ])
    }

    private func setupNavBar() {
        navigationController?.navigationBar.isHidden = true
    }


    private func avatarTapGesture() {
        let avatarTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAvatar))
        avatarTapGesture.numberOfTapsRequired = 1
        avatarTapGesture.numberOfTouchesRequired = 1
        copyAvatar.isUserInteractionEnabled = true
        copyAvatar.addGestureRecognizer(avatarTapGesture)
    }


    private func closeButtonTapGesture() {
        let closeButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGestureClose))
        closeButton.addGestureRecognizer(closeButtonTapGesture)
        }

    @objc private func tapGestureAvatar(_ gestureRecognizer: UITapGestureRecognizer) {


        let scaleRatio = self.blurView.frame.width / self.copyAvatar.frame.width

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {

            self.copyAvatar.isHidden = false
            self.blurView.isHidden = false


            self.copyAvatar.center = self.blurView.center
            self.copyAvatar.transform = CGAffineTransform(scaleX: scaleRatio, y: scaleRatio)
            self.copyAvatar.isUserInteractionEnabled = false

        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                self.closeButton.isHidden = false
            }
        }
    }


    @objc private func TapGestureClose(_ gestureRecognizer: UITapGestureRecognizer) {

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.closeButton.isHidden = true
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                    self.copyAvatar.frame = CGRect(x: self.spaceToAvatar.x, y: self.spaceToAvatar.y, width: self.sizeOfAvatar.x, height: self.sizeOfAvatar.y)
                    self.copyAvatar.transform = .identity
                    self.blurView.isHidden = true
                    self.copyAvatar.isHidden = true
            }
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
            // profile.setup(user: userIsLogin)
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
