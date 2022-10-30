
import UIKit
import SnapKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


protocol SideMenuDelegate {
    func didSelect()
    func profile()
    func myCollection()
    func exit()
}

class SideMenuController: UIViewController {
    
  
    var delegate: SideMenuDelegate?
 
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SideMenuCell.self, forCellReuseIdentifier: SideMenuCell.id)
        table.separatorColor = .darkGray
        return table
    }()
    
    //MARK: - models
    private let model:[SideMenuCellModel] = [.profile, .myCollection, .exit]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configurate()
    
    }
  
    
    //MARK: - configution table view
    private func configurate() {
        view.backgroundColor = .background
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.backgroundColor = .background
    }
        
    //MARK: - Selector
    @objc func exitButtonTapped() {
        delegate?.didSelect()
        
    }
}

//MARK: - enum for table view
extension SideMenuController {
   enum SideMenuCellModel {
       case profile
       case myCollection
       case exit
       
       var image: UIImage? {
           switch self {
           case .profile: return UIImage(systemName: "person.crop.circle")
           case .myCollection: return UIImage(systemName: "bookmark.fill")
           case .exit: return UIImage(systemName: "figure.walk.arrival")
           }
       }
       
       var title: String? {
           switch self {
           case .profile: return "Profile"
           case .myCollection: return "My Collection"
           case .exit: return "Exit"
           }
       }
   }
}

//MARK: - Table Delegate,DataSource
extension SideMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.id, for: indexPath) as! SideMenuCell
       
        let models = model[indexPath.row]
        cell.setTitle(title: models.title)
        cell.setImage(image: models.image)
        
        let insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        switch models {
        case .profile: cell.addSeparator(on: .top, insets: insets)
        case .exit: break
        case .myCollection: break
        }
       return  cell
    }

   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerViews = HeaderSideMenu()
       headerViews.frame.size.width = view.frame.width
       headerViews.delegate = self
       return headerViews
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return  250
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let models = model[indexPath.row]
        
        switch models {
        case .profile:
            delegate?.profile()
        case .myCollection:
            delegate?.myCollection()
        case .exit:
            delegate?.exit()
            delegate?.didSelect()
        }
    }
}

extension SideMenuController: HeaderDelegate  {
    func exitButtonTap() {
        delegate?.didSelect()
    }
}
