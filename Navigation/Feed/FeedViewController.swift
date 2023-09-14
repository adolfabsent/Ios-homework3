import UIKit

class FeedViewController: UIViewController {

    var post = Post.init(title: "Мой пост")

    struct Post {
        var title: String
    }

    weak var parentNavigationController: UINavigationController?
    let model: FeedModel = FeedModel()
    let mainView: FeedView = FeedView()

    var backgroundColor: UIColor = .white

    init(_ color: UIColor, _ title: String, parent parentNavigationController: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        backgroundColor = color
        self.title = title
        self.parentNavigationController = parentNavigationController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func loadView() {
        super.loadView()
        view.backgroundColor = .gray
        self.view = mainView
        mainView.setButtonTapAction(action: onButtonTap)
        mainView.setCheckGuessButtonTapAction(action: onCheckGuessButtonTap)
        view.backgroundColor = backgroundColor
    }


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = ""
    }

    //@objc private func pressPost() {
     //   let postVC = PostViewController()
     //  postVC.navigationItem.title = post.title
     //   self.navigationController?.present(postVC, animated: true)
    //    print("Post")
   // }


    @objc
        func onButtonTap() {
            parentNavigationController?.pushViewController(PostViewController(nibName: nil, bundle: nil), animated: true)
        }

        @objc
        func onCheckGuessButtonTap() {
            let result = model.check(word: mainView.getInputText())

            if result {
                mainView.setLabelColor(.green)
            } else {
                mainView.setLabelColor(.red)
            }
        }

        private func getPost() -> Post {
            return Post(title: "New post!")
        }
    }


