//
//  LoadView.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 19.10.2022.
//

import UIKit
import SnapKit

protocol LoadViewDelegate {
    func enterButtonTapp()
    func registrationTapp()
}

class LoadView: UIView {
        
    lazy var nextButton: UIButton = {
         let button = UIButton()
         button.setTitle("Login in", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
         button.setTitleColor(.text, for: .normal)
        button.backgroundColor = .systemGreen
         button.layer.cornerRadius = 15
         button.layer.shadowRadius = 5
         button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         button.layer.shadowOffset = CGSize(width: 0, height: 0);
         button.layer.shadowOpacity = 1
         button.addTarget(self, action: #selector(toEnterVC), for: .touchUpInside)
         return button
     }()
    
    lazy var registrButton: UIButton = {
         let button = UIButton()
         button.setTitle("Create account", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
         button.setTitleColor(.text, for: .normal)
         button.backgroundColor = .white
         button.layer.cornerRadius = 15
         button.layer.shadowRadius = 5
         button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         button.layer.shadowOffset = CGSize(width: 0, height: 0);
         button.layer.shadowOpacity = 1
         button.addTarget(self, action: #selector(toRegistrVC), for: .touchUpInside)
         return button
     }()

    var delegate: LoadViewDelegate?
    
    private let animator = Animation()
    private let emoji = ["🎬", "😎", "🎥", "😜", "🤩", "⭐️", "⭐️", "⭐️"]
    
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAnimation()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set animation
    private func setupAnimation() {
        let emitter = animator.createEmitterLayer(with: emoji)
        layer.addSublayer(emitter)
        
    }
    //MARK: - selectors
    @objc func toEnterVC() {
        delegate?.enterButtonTapp()
    }
    
    @objc func toRegistrVC() {
        delegate?.registrationTapp()
    }
    
    //MARK: - set constraints
    func setConstraints() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
            make.width.equalTo(170)
        }
        
        addSubview(registrButton)
        registrButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
    
    }
    
    
}
