//
//  UIView.swift
//  Testovoe
//
//  Created by Игорь Ущин on 06.10.2022.
//

import UIKit

//MARK: - add custom constraints
extension UIView {
    enum SeparatorPostion: Int {
        case top = 5
        case bottom = 10
        
    }
    //MARK: - create separators
    func addSeparator(on position: SeparatorPostion, insets: UIEdgeInsets = .zero) {
        let tag = 111 * position.rawValue
        guard self.viewWithTag(tag) == nil else {
            return
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .darkGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        let height = 0.3
        let verticalFormat =  position == .top ? "|[separatorView(\(height))]" : "[separatorView(\(height))]|"
        addSubview(separatorView)
        let constraints = NSLayoutConstraint.constraints(withNewVisualFormat: "H:|-(\(insets.left))-[separatorView]-(\(insets.right))-|,V:\(verticalFormat)", dict: ["separatorView": separatorView])
        addConstraints(constraints)
    }
}
