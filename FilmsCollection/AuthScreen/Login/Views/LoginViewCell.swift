//
//  LoginViewCell.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 20.10.2022.
//

import UIKit
import SnapKit

class LoginViewCell: UITableViewCell {
    
    static let id = "cell"
    
    lazy var textField: UITextField = {
         let tf = UITextField()
         tf.backgroundColor = .white
         tf.borderStyle = .none
         tf.textColor = .text
         tf.textAlignment = .left
         tf.font = .systemFont(ofSize: 20, weight: .medium)
         tf.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
         return tf
     }()
     
     let authLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font =  .systemFont(ofSize: 20, weight: .semibold)
         label.textColor = .text
         label.textAlignment = .right
         return label
     }()
    
    var textChanged: ItemClosure<String>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - change textFields
    @objc func textFieldChange() {
        let text  = textField.text ?? ""
        textChanged?(text)
    }
    //MARK: - secure password
    func setSecure(secure: Bool) {
        textField.isSecureTextEntry = secure
    }
    //MARK: - set text title
    func setTitle(title: String?) {
        authLabel.text = title
        
    }
    //MARK: - set placeholder
    func set(placeholder: String?) {
        textField.placeholder = placeholder
    }
    
    //MARK: - set constraints
    private func setConstraints() {
        addSubview(authLabel)
        authLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(70)
            make.width.equalTo(140)
        }
        
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(authLabel.snp.right).offset(15)
            make.width.equalTo(140)
        }
    }
}
