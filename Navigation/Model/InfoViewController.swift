import UIKit

class InfoViewController: UIViewController {

    var button = UIButton(frame: CGRectMake(150, 240, 95, 95))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView(){
        title = "Info"
        let button = CustomButton(title: "PushPost", titleColor: .white)
        button.frame = CGRectMake(150, 240, 95, 95)
        view.backgroundColor = .white
        view.addSubview(button)
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        
        let alert = UIAlertController(title: "Успех!", message: "Новый пост успешно опубликован!", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        let printAction = UIAlertAction(title: "Отчёт в консоль", style: .default) { _ in
            print("NETOLOGY!!!")
        }
        
        alert.addAction(cancelAction)
        alert.addAction(printAction)
        
        present(alert, animated: true)
        
    }

}
