//
//  UIImage+.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import UIKit

extension UIImage {
    public func resized(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }

    public func resized(side: CGFloat) -> UIImage {
        return self.resized(width: side, height: side)
    }
}
