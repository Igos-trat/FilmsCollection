
import UIKit

protocol ProfileViewControllerDelegate {
    func didSelect()
    
}

class ProfileViewController: UIViewController {

    var delegate: ProfileViewControllerDelegate?
    private var verticalStack = UIStackView()
    private var horizontalStack = UIStackView()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.backgroundColor = .buttonB()
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel(text: "Igor Uschin",
                            font: .systemFont(ofSize: 23, weight: .semibold),
                            color: .title())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel(text: "Male | Born 18.06.1994",
                            font: .systemFont(ofSize: 15, weight: .semibold),
                            color: .text())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "Image"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.backgroundColor = .buttonB()
        return img
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel(text: "+7 (987) 951-28-13",
                            font: .systemFont(ofSize: 13, weight: .medium),
                            color: .text())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var mailLabel: UILabel = {
        let label = UILabel(text: "uschinigor@gmail.com",
                            font: .systemFont(ofSize: 15, weight: .medium),
                            color: .text())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "telephone")?.withRenderingMode(.alwaysTemplate)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .title()
        button.backgroundColor = .buttonB()
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "email")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .title()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.backgroundColor = .buttonB()
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background()
        
        setVerticalStack()
        setLayoutExitButton()
        setLayoutStackView()
        setHorizontalStack()
        setLayoutHorizontalSack()
        
    }
    
   
    //MARK: - setup ExitButton
   private func setLayoutExitButton() {
        view.addSubview(exitButton)
        NSLayoutConstraint(item: exitButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1,
                           constant: 10).isActive = true
        NSLayoutConstraint(item: exitButton,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailingMargin,
                           multiplier: 1,
                           constant: -80).isActive = true
        exitButton.layer.cornerRadius = 24 / 2
        exitButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
  //MARK: - Setup StackViews
    private func setHorizontalStack() {
        horizontalStack = UIStackView(arrangedSubviews: [callButton,
                                                         emailButton
                                                        ])
        view.addSubview(horizontalStack)
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 36
        horizontalStack.distribution = .equalSpacing
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        callButton.layer.cornerRadius = 70 / 2
        callButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        emailButton.layer.cornerRadius = 70 / 2
        emailButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        emailButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setVerticalStack() {
        verticalStack = UIStackView(arrangedSubviews: [nameLabel,
                                                       dateLabel,
                                                       imageView,
                                                       phoneLabel,
                                                       mailLabel,])
       
        view.addSubview(verticalStack)
        verticalStack.axis = .vertical
        verticalStack.spacing = 6
        verticalStack.distribution = .equalSpacing
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 170 / 2
        imageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    //MARK: - setup StackViews constraints
    private func setLayoutStackView() {
        NSLayoutConstraint(item: verticalStack,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leadingMargin,
                           multiplier: 1,
                           constant: 65).isActive = true
        NSLayoutConstraint(item: verticalStack,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1,
                           constant: 130).isActive = true
    }
    
    private func setLayoutHorizontalSack() {
        NSLayoutConstraint.activate([
        horizontalStack.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 40),
        horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75)
                                    ])
    }
    
    //MARK: - Selector
    @objc func exitButtonTapped() {
        delegate?.didSelect()
    }
}
