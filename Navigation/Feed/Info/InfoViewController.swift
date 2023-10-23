import UIKit

class InfoViewController: UIViewController {

    private lazy var cellTextArray: [String] = []

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Открыть алерт", for: .normal)
        button.addTarget(self, action: #selector(self.didAlertButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var infoModelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var planetRotationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.dataSource = self
            tableView.delegate = self
            return tableView
        }()


    override func viewDidLoad() {
        super.viewDidLoad()

        getRandomTitle { infoModel in
            DispatchQueue.main.async {
                if let infoModel {
                    self.infoModelLabel.text = infoModel.title
                } else {
                    self.infoModelLabel.text = "Something went wrong..."
                }
            }
        }
        getRotationPeriod { planetModel in
            DispatchQueue.main.async {
                if let planetModel {
                    self.planetRotationLabel.text = planetModel.rotationPeriod
                } else {
                    self.planetRotationLabel.text = "Данные не найдены"
                }
            }

        }
        setupInfoView()
    }

    func setupInfoView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.button)
        self.view.addSubview(self.infoModelLabel)
        self.view.addSubview(self.planetRotationLabel)
        self.view.addSubview(tableView)

        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            self.button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            self.button.heightAnchor.constraint(equalToConstant: 50),

            self.infoModelLabel.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 16),
            self.infoModelLabel.leadingAnchor.constraint(equalTo: self.button.leadingAnchor, constant: 16),
            self.infoModelLabel.trailingAnchor.constraint(equalTo: self.button.trailingAnchor, constant: -16),

            self.planetRotationLabel.topAnchor.constraint(equalTo: self.infoModelLabel.bottomAnchor, constant: 16),
            self.planetRotationLabel.leadingAnchor.constraint(equalTo: self.button.leadingAnchor, constant: 16),
            self.planetRotationLabel.trailingAnchor.constraint(equalTo: self.button.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: self.planetRotationLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }


    @objc private func didAlertButton() {
        let alert = UIAlertController(title: "Заголовок алерта", message: "сообщение алерта", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
            print("положительный ответ")
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { action in
            print("отрицательный ответ")
        }))

        self.present(alert, animated: true, completion: nil)
    }

}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellTextArray.isEmpty {
            return 1
        } else {
            return cellTextArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if cellTextArray.isEmpty {
            cell.textLabel?.text = "Loading..."
        } else {
            cell.textLabel?.text = cellTextArray[indexPath.row]
        }

        return cell
    }



}
