
import UIKit

class FirstViewController: UIViewController {
    
    let profileVc = ProfileViewController()
    var navVC: UINavigationController?
    let movieVC = MovieBrowserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addChildsVC()
    }
    
    private func addChildsVC() {
        addChild(profileVc)
        view.addSubview(profileVc.view)
        profileVc.didMove(toParent: self)
        
        movieVC.delegate = self
        profileVc.delegate = self
        let navVC = UINavigationController(rootViewController: movieVC )
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

//MARK: - Delegates
extension FirstViewController:MovieControllerDelegate, ProfileViewControllerDelegate {
    func didTapButtonProfile() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            
            self.navVC?.view.frame.origin.x = self.movieVC.view.frame.size.width - 80
        }
    }
    func didSelect() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.navVC?.view.frame.origin.x = 0
            }
        }
    }
