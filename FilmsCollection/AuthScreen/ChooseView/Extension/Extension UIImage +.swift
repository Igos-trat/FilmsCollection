//
//  Extension UIImage +.swift
//  Testovoe
//
//  Created by Игорь Ущин on 05.10.2022.
//

import UIKit

extension UIImage {

    func rotate(radians: Float) -> UIImage? {

        let newSize = CGRect(origin: CGPoint.zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral
            .size

        return UIGraphicsImageRenderer(size: newSize).image { context in

            context.cgContext.translateBy(x: newSize.width / 2, y: newSize.height / 2)
            context.cgContext.rotate(by: CGFloat(radians))

            draw(in: CGRect(x: -size.width / 2,
                            y: -size.height / 2,
                            width: size.width,
                            height: size.height))
        }
    }
}
