//
//  RegistrController.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 20.10.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RegistrController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(RegistrationViewCell.self, forCellReuseIdentifier: RegistrationViewCell.id)
        table.separatorColor = .darkGray
        return table
    }()
    
    //MARK: - models
    private let model:[CellRegistrModel] = [.login, .password, .username, .lastname, .phone]
    private var registrModel: RegistrModel = RegistrModel()
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }
    
    //MARK: - configuration 
    private func configuration() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame =  view.bounds
        addHeaderView()
        tableView.bounces = false
    }

    //MARK: - add header
    private func addHeaderView() {
        let headerViews = HeaderReView()
        let height: CGFloat = 200
        let width = view.frame.size.width
        headerViews.frame.size = CGSize(width: width, height: height)
        tableView.tableHeaderView = headerViews
    }

    //MARK: -  create user in firebase
    func registrUser(with log: String, password: String, username: String, lastname: String, phoneNumber: String) {
        
        Auth.auth().createUser(withEmail: log, password: password) { (result, error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription, style: .alert)
                return
            }
            guard let uid = result?.user.uid else { return }
            let value = ["Email": log, "Password": password, "First name": username, "Last name": lastname, "Phone number": phoneNumber]
            let collName = "Users"
            //create user in collection Firestore
            Firestore.firestore().collection(collName).document(uid).setData(value) { error in
                if let error = error {
                    self.alert(title: "Error", message: error.localizedDescription, style: .alert)
                }
            }
            self.alertEnable(title: "Success", message: "Account has been successfully created", style: .alert)
        }
    }

    //MARK: -  change textFields
    func textChanged(with model: CellRegistrModel, and text: String) {
        switch model {
        case .login: registrModel.login = text
        case  .password: registrModel.password = text
            
        case .username: registrModel.username = text
        case .phone: registrModel.phone = text
        case .lastname: registrModel.lastname = text
        }
    }
}

//MARK: -  enum for table view
extension RegistrController{
    enum CellRegistrModel {
        case login
        case password
        case username
        case lastname
        case phone
        
        var placeholder: String? {
            switch self {
            case .login: return "Your email"
            case .password: return "Your password"
            case .username: return "Your First Name"
            case .lastname: return "Your Last Name"
            case .phone:  return  "Your phone +7"
           
            }
        }
        
        var title: String? {
            switch self {
            case .login: return "Login:"
            case .password: return "Password:"
            case .username: return "First Name:"
            case .lastname: return "Last Name:"
            case .phone: return "Phone:"
            
            }
        }
    }
}

//MARK: -  Table DataSource, Delegate
extension RegistrController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationViewCell.id, for: indexPath) as! RegistrationViewCell
       
        let models =  model[indexPath.row]
        cell.setTitle(title: models.title)
        cell.set(placeholder: models.placeholder)
        let insets = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
        
        switch models {
        case .login: cell.addSeparator(on: .top, insets: insets)
        case .password: break
        case .username: break
        case .phone: break
        case .lastname: break
        }
        
        cell.textChanged = {  text in
            self.textChanged(with: models, and: text)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerReView = FooterReView()
        footerReView.frame.size.width = view.frame.width
        footerReView.delegate = self
        return footerReView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 65
    }
}
//MARK: - delegate footer
extension RegistrController: FooterReViewDelegate {
    func cancelTap() {
        navigationController?.popViewController(animated: true)
    }
    
    func registTap() {
        let log = registrModel.login ?? ""
        let pass = registrModel.password ?? ""
        let name = registrModel.username ?? ""
        let lastname = registrModel.lastname ?? ""
        let phone = registrModel.phone ?? ""
        
        guard !log.isEmpty && !pass.isEmpty && !name.isEmpty && !phone.isEmpty else {
            alert(title: "Error", message: "Not all fields are filled", style: .alert)
            return
        }
        registrUser(with: log, password: pass, username: name, lastname: lastname, phoneNumber: phone)
    }
}
//MARK: - create alerts
extension RegistrController {
    //destructive alert
    func alert(title: String, message: String, style: UIAlertController.Style){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    }
    //success alert
    func alertEnable(title: String, message: String, style: UIAlertController.Style){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    }
}
