//
//  ChooseController.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 19.10.2022.
//

import UIKit
import SnapKit

class ChooseController: UIViewController {

    override func loadView() {
        let view = LoadView()
        view.delegate = self
        self.view = view
    }
    
    private var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Preview"))
        image.layer.cornerRadius = 23
        image.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.borderWidth = 2
        image.layer.masksToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    //MARK: - configurations
    private func setViews() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .background
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(265)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
}

//MARK: - table delegate
extension ChooseController: LoadViewDelegate {
    func registrationTapp() {
        let registrVC = RegistrController()
        navigationController?.pushViewController(registrVC, animated: true)
    }
    
    func enterButtonTapp() {
        let logVC = AuthController()
        navigationController?.pushViewController(logVC, animated: true)
    }
}
