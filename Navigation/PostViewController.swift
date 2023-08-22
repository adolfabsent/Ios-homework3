import UIKit

class PostViewController: UIViewController {
    
    var titleString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(itemAction))
        
        self.navigationItem.rightBarButtonItem = barButtonItem
    
        view.backgroundColor = .white
        title = titleString
    }
    
    @objc private func itemAction(){
        
        let infoViewController = InfoViewController()
        
        self.navigationController?.pushViewController(infoViewController, animated: true)
        
    }
    

}
