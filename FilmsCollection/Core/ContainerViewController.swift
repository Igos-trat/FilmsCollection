
import UIKit

class ContainerViewController: UIViewController {
    
    let profileVc = SideMenuController()
    var navVC: UINavigationController?
    let movieVC = MovieBrowserController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        addChildsVC()
    }
    
    private func addChildsVC() {
        addChild(profileVc)
        profileVc.delegate = self
        view.addSubview(profileVc.view)
        profileVc.didMove(toParent: self)
        
        let navVC = UINavigationController(rootViewController: movieVC )
        movieVC.delegate = self
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

//MARK: - Delegates
extension ContainerViewController:MovieControllerDelegate, SideMenuDelegate {
    
    func profile() {
       let profile = UINavigationController(rootViewController: ProfileController())
        profile.modalPresentationStyle = .fullScreen
        present(profile, animated: true)
    }
    
    func myCollection() {
        let vc =  UINavigationController(rootViewController: MyFilmsCollection())
         vc.modalPresentationStyle = .fullScreen
         present( vc, animated: true)
    }

    func exit() {
        self.alert(title: "", message: "Are you sure you want to sign out?", style: .actionSheet)
    }
    
    func didTapButtonProfile() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            
            self.navVC?.view.frame.origin.x = self.movieVC.view.frame.size.width - 80
            
        }
    }
    
    func didSelect() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
                UIView.animate(withDuration: 0.8) {
                    self.movieVC.visualEffectView.alpha = 0
            }
            
        }
    }
}

//MARK: - create Alert
extension ContainerViewController {
    
    func alert(title: String, message: String, style: UIAlertController.Style){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            let vc = UINavigationController(rootViewController: ChooseController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
    }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
  
    present(alert, animated: true, completion: nil)
    }
}
