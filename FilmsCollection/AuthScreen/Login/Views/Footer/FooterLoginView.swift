//
//  FooterLoginView.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 20.10.2022.
//

import UIKit
import SnapKit

protocol FooterViewDelegate {
    func enterTapped()
    func cancelTapped()
}

class FooterLoginView: UIView {
    
    var delegate: FooterViewDelegate?
    
    lazy var enterButton: UIButton = {
      let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.text, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.layer.shadowRadius = 3
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0);
        button.layer.shadowOpacity = 1
        button.addTarget(self, action: #selector(enterButtonTap), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
      let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.setTitleColor(.text, for: .normal)
        button.tintColor = .text
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 15
        button.layer.shadowRadius = 3
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0);
        button.layer.shadowOpacity = 1
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - selectors
    @objc  func enterButtonTap() {
        delegate?.enterTapped()
    }
    
    @objc  func cancelButtonTap() {
        delegate?.cancelTapped()
    }
    
    //MARK: - setup constraints
    private func setConstraints() {
        addSubview(enterButton)
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.right.equalTo(-30)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.right.equalTo(enterButton.snp.left).offset(-7.5)
            make.left.equalTo(30)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }    
}

