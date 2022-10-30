//
//  ProfileViewCell.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 20.10.2022.
//

import UIKit
import SnapKit

class SideMenuCell: UITableViewCell {
    
    static let id = "sideMenuCell"
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .text
        label.textAlignment = .left
        return label
    }()
   
    var imageCell: UIImageView = {
        let img = UIImageView()
        img.tintColor = .text
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - set text title
    func setTitle(title: String?) {
        categoryLabel.text = title
    }
    
    func setImage(image: UIImage?) {
        imageCell.image = image
    }
    
    //MARK: - set constraints and other config
    func setConstraints() {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backgroundColor = .background
        addSubview(imageCell)
        imageCell.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalTo(self)
        }
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(imageCell.snp.right).offset(10)
            make.width.equalTo(150)
        }
    }
}
