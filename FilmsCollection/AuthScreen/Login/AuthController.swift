//
//  AuthController.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 20.10.2022.
//
import FirebaseAuth
import Firebase
import UIKit

class AuthController: UIViewController {

    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LoginViewCell.self, forCellReuseIdentifier: LoginViewCell.id)
        table.separatorColor = .darkGray
        return table
    }()

    //MARK: - models
    private let model:[CellModel] = [.login, .password]
    private var loginModel: LoginModel = LoginModel()
    
    //MARK: - init
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
        addHeaderView()
    }

    //MARK: - add header in table
    private func addHeaderView() {
        let headerViews = HeaderLoginView()
        let height: CGFloat = 300
        let width = view.frame.size.width
        headerViews.frame.size = CGSize(width: width, height: height)
        tableView.tableHeaderView = headerViews
    }
    
    //MARK: - change textFields
    func textChanged(with model: CellModel, and text: String) {
        switch model {
        case .login: loginModel.login = text
        case .password: loginModel.password = text
            
        }
    }
    
    //MARK: - Auth user
    func logUser(with log: String, password: String) {
        
        Auth.auth().signIn(withEmail: log, password: password) { (result, error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription , style: .alert)
                return
            }
          self.navigationController?.pushViewController(ContainerViewController(), animated: true)
        }
    }
    

}

//MARK: - enum for table view
extension AuthController {
   enum CellModel {
       case login
       case password
       
       var placeholder: String? {
           switch self {
           case .login: return "Your login"
           case .password: return "Your password"
           }
       }
       
       var title: String? {
           switch self {
           case .login: return "Login:"
           case .password: return "Password:"
           }
       }
   }
}

//MARK: - Table Delegate,DataSource
extension AuthController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LoginViewCell.id, for: indexPath) as! LoginViewCell
        
        let models = model[indexPath.row]
        cell.set(placeholder: models.placeholder)
        cell.setTitle(title: models.title)
        
        let insets = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
        
        switch models {
        case .login: cell.addSeparator(on: .top, insets: insets)
        case .password:
            cell.addSeparator(on: .bottom, insets: insets)
            cell.setSecure(secure: true)
        }
        
        //MARK: - callback
        cell.textChanged = {  text in
            self.textChanged(with: models, and: text)
        }
        
       return  cell
    }

   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       let footerViews = FooterLoginView()
       footerViews.frame.size.width = view.frame.width
       footerViews.delegate = self
       return footerViews
   }
   
   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return  65
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }

}

//MARK: - create Alert
extension AuthController {
    
    func alert(title: String, message: String, style: UIAlertController.Style){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .default) { (action) in
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    }
}

//MARK: - delegate from Footer
extension AuthController: FooterViewDelegate {
    func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func enterTapped() {
        let log = loginModel.login ?? ""
        let pass = loginModel.password ?? ""
        
        guard !log.isEmpty && !pass.isEmpty else {
            alert(title: "Error", message: "Not all fields are filled", style: .alert)
            return
        }
        logUser(with: log, password: pass)
    }
}
