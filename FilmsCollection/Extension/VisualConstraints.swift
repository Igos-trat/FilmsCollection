//
//  VisualConstraints.swift
//  Testovoe
//
//  Created by Игорь Ущин on 06.10.2022.
//

import UIKit
//MARK: -  экстеншн который позволяет верстать сепараторы черз визуальный кострейнт
extension NSLayoutConstraint {
    static func quadroAspect(on view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.init(item: view, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
    }
    
    static func constraints(withNewVisualFormat vf: String, dict: [String: Any]) -> [NSLayoutConstraint] {
        let separatedArray = vf.split(separator: ",")
        switch separatedArray.count {
        case 1: return NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[0])", options: [], metrics: nil, views: dict)
        case 2: return NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[0])", options: [], metrics: nil, views: dict) + NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[1])", options: [], metrics: nil, views: dict)
        default: return NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[0])", options: [], metrics: nil, views: dict)
        }
    }
}
