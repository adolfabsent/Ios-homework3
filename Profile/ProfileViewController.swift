
import Foundation
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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




