//
//  HeaderProfile.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 23.10.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class  ViewProfile: UIView {
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.backgroundColor = .buttonB
        img.layer.cornerRadius = 80
        return img
    }()
        
    let fullName: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Full Name"
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Login"
        return label
    }()
    
    let password: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Password"
        return label
    }()
    
    let phone: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Phone number"
        return label
    }()
    
    let separator1: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let separator2: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let separator3: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let separator4: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let fullNameData: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let emailData: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let passwordData: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let phoneData: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
   
        setViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - set views
    func setViews() {
        layer.cornerRadius = 18
        layer.shadowRadius = 3
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0);
        layer.shadowOpacity = 1
        backgroundColor = .darkGray.withAlphaComponent(0.7)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(40)
            make.width.equalTo(160)
            make.height.equalTo(160)
        }
        addSubview(fullName)
        fullName.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(130)
        }
        addSubview(separator1)
        separator1.snp.makeConstraints { make in
            make.height.equalTo(1.7)
            make.centerX.equalTo(self)
            make.top.equalTo(fullName.snp.bottom).offset(5)
            make.width.equalTo(330)
        }
        addSubview(email)
        email.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.centerX.equalTo(self)
            make.top.equalTo(fullName.snp.bottom).offset(20)
            make.width.equalTo(130)
        }
        addSubview(separator2)
        separator2.snp.makeConstraints { make in
            make.height.equalTo(1.7)
            make.centerX.equalTo(self)
            make.top.equalTo(email.snp.bottom).offset(5)
            make.width.equalTo(330)
        }
        
        addSubview(password)
        password.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(email.snp.bottom).offset(20)
            make.width.equalTo(130)
        }
        addSubview(separator3)
        separator3.snp.makeConstraints { make in
            make.height.equalTo(1.7)
            make.centerX.equalTo(self)
            make.top.equalTo(password.snp.bottom).offset(5)
            make.width.equalTo(330)
        }
        
        addSubview(phone)
        phone.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(password.snp.bottom).offset(20)
            make.width.equalTo(130)
        }
        addSubview(separator4)
        separator4.snp.makeConstraints { make in
            make.height.equalTo(1.7)
            make.centerX.equalTo(self)
            make.top.equalTo(phone.snp.bottom).offset(5)
            make.width.equalTo(330)
        }
        
        addSubview(fullNameData)
        fullNameData.snp.makeConstraints { make in
            make.right.equalTo(-30)
            make.left.equalTo(fullName.snp.right).offset(10)
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(170)
        }
        
        addSubview(emailData)
        emailData.snp.makeConstraints { make in
            make.right.equalTo(-30)
            make.left.equalTo(email.snp.right).offset(10)
            make.top.equalTo(fullNameData.snp.bottom).offset(20)
            make.width.equalTo(170)
        }
        
        addSubview(passwordData)
        passwordData.snp.makeConstraints { make in
            make.right.equalTo(-30)
            make.left.equalTo(password.snp.right).offset(10)
            make.top.equalTo(email.snp.bottom).offset(20)
            make.width.equalTo(170)
        }
        
        addSubview(phoneData)
        phoneData.snp.makeConstraints { make in
            make.right.equalTo(-30)
            make.left.equalTo(phone.snp.right).offset(10)
            make.top.equalTo(password.snp.bottom).offset(20)
            make.width.equalTo(170)
        }
    }  
}
