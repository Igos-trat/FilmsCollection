//
//  ProfileController.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 22.10.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class ProfileController: UIViewController {

    
    private let viewProfil: ViewProfile = {
        let view = ViewProfile()
      
        return view
    }()
    let collName = "Users"
    let uuid  =  Auth.auth().currentUser?.uid ?? ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
       
        configurate()
       
    }
  

    
    //MARK: - configuration table view
    private func configurate() {
        APIManager.shared.getPost(collection: collName, docName: uuid, completion: { doc in
            self.viewProfil.fullNameData.text = "\(doc?.Firstname ?? "")" + "\(doc?.Lastname ?? "")"
            self.viewProfil.emailData.text = doc?.Email
            self.viewProfil.passwordData.text = doc?.Password
            self.viewProfil.phoneData.text = doc?.Phonenumber
    
                        })

        view.backgroundColor = .background
        title = "My Profile"
        setConstraints()
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.text]
        navigationItem.standardAppearance = appearance

        navigationItem.leftBarButtonItem = UIBarButtonItem(image:
                                                            UIImage(named: "arrowshape.backward.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goBackButtonTap))
    }

    
    //MARK: - add header in table
    private func addHeaderView() {
        let headerViews = ViewProfile()
        let height: CGFloat = 300
        let width = view.frame.size.width
        headerViews.frame.size = CGSize(width: width, height: height)
       
    }

    //MARK: - Selectors
    @objc func goBackButtonTap() {
        self.dismiss(animated: true)
    }
    
    //MARK: - constraints
    func setConstraints() {
        view.addSubview(viewProfil)
        viewProfil.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(view.frame.height - 275)
            make.width.equalTo(view.frame.width - 40)
        }
        
    }
}


