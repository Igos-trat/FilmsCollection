//
//  HeaderProfile.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 20.10.2022.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol HeaderDelegate {
    func exitButtonTap()
}

class HeaderSideMenu: UIView {
    
    var delegate: HeaderDelegate?
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.backgroundColor = .buttonB
        button.addTarget(self, action: #selector(exitTap), for: .touchUpInside)
        return button
    }()
    
    var imageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "Image"))
        img.layer.masksToBounds = true
        img.backgroundColor = .buttonB
        img.layer.cornerRadius = 80
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.text.cgColor
        return img
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel(text: "",
                            font: .systemFont(ofSize: 21, weight: .bold),
                            color: .title)
        return label
    }()
    
   let uuid  =  Auth.auth().currentUser?.uid ?? ""
   let collName = "Users"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
     
   
        setViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - selectors
    @objc func exitTap() {
        delegate?.exitButtonTap()
    }

    //MARK: - set views
    func setViews() {
        APIManager.shared.getPost(collection: collName, docName: uuid, completion: { doc in
            guard doc != nil else { return }
            
            self.nameLabel.text = "\(doc?.Firstname ?? "") "+"\(doc?.Lastname ?? "")"

                        })
        backgroundColor = .background
        addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(-12.6)
            make.right.equalTo(-105)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalTo(90)
            make.centerY.equalTo(self)
            make.width.equalTo(160)
            make.height.equalTo(160)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalTo(imageView.snp.centerX)
            make.width.equalTo(250)
        }
    }
    
}
