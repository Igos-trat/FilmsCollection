//
//  Extension String+.swift
//  Testovoe
//
//  Created by Игорь Ущин on 05.10.2022.
//

import UIKit

extension String {

    func emojiToImage() -> UIImage? {

        let size = CGSize(width: 60, height: 70)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 60)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
