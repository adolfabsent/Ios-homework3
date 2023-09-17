
import UIKit

final class ProfileViewController: UIViewController {

    let user: User?
    let profileViewModel: ProfileViewModel
    let photoCoordinator: PhotoCoordinator

       static let headerIdent = "header"
       static let photoIdent = "photo"
       static let postIdent = "post"
       static let defaultCell = "DefaultCellID"

       static var postTableView: UITableView = {
           let table = UITableView(frame: .zero, style: .grouped)
                    table.translatesAutoresizingMaskIntoConstraints = false
                    table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: headerIdent)
                    table.register(PhotosTableViewCell.self, forCellReuseIdentifier: photoIdent)
                    table.register(PostTableViewCell.self, forCellReuseIdentifier: postIdent)
                    return table
                }()

    init(user: User, photoCoordinator: PhotoCoordinator, profileViewModel: ProfileViewModel) {
           self.user = user
           self.profileViewModel = profileViewModel
           self.photoCoordinator = photoCoordinator
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setupNavigation()
        }
        

       override func viewDidLoad() {
           super.viewDidLoad()

           view.backgroundColor = .systemBackground

           view.addSubview(Self.postTableView)
           setupConstraints()
           Self.postTableView.dataSource = self
           Self.postTableView.delegate = self
           Self.postTableView.refreshControl = UIRefreshControl()
           Self.postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
       }

    private func setupNavigation() {
          self.navigationController?.setNavigationBarHidden(true, animated: false)
      }

       private func setupConstraints() {
           NSLayoutConstraint.activate([
               Self.postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               Self.postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
               Self.postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
               Self.postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])
       }

       @objc func reloadTableView() {
           Self.postTableView.reloadData()
           Self.postTableView.refreshControl?.endRefreshing()
       }
   }

   extension ProfileViewController: UITableViewDataSource {

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           switch section {
           case 0: return 1
           case 1: return postExamples.count
           default:
               assertionFailure("no registered section")
               return 1
           }
       }

       func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
   }

   extension ProfileViewController: UITableViewDelegate {

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           switch indexPath.section {
           case 0:
               let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.photoIdent, for: indexPath) as! PhotosTableViewCell
               return cell
           case 1:
               let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.postIdent, for: indexPath) as! PostTableViewCell
               cell.configPostArray(post: postExamples[indexPath.row])
               return cell
           default:
               assertionFailure("no registered section")
               return UITableViewCell()
           }
       }

       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

           guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerIdent) as? ProfileHeaderView else {return UITableViewCell()}
           headerView.setupUser(user: user!)
           return headerView
       }

       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                    return section == 0 ? 220 : 0
                }


       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           switch indexPath.section {
           case 0:
               tableView.deselectRow(at: indexPath, animated: false)
               navigationController?.pushViewController(PhotosViewController(), animated: true)
           case 1:
               guard let cell = tableView.cellForRow(at: indexPath) else { return }
               if let post = cell as? PostTableViewCell {
                   post.incrementPostViewsCounter()
               }
           default:
               assertionFailure("no registered section")
           }
       }
   }
