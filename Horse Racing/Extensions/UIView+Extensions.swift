//
//  UIView+Extensions.swift
//  Horse Racing
//
//  Created on 31/07/2021.
//

import UIKit

extension UIView {
    /// UIView extension to make adding static anchors simpler
    /// This function will set translatesAutoresizingMaskIntoConstraints to false on the UIView it is invoked on
    /// - Parameters:
    ///   - top: The top anchor
    ///   - paddingTop: Padding from the top anchor
    ///   - bottom: The bottom anchor
    ///   - paddingBottom: Padding from the bottom anchor
    ///   - left: The left anchor
    ///   - paddingLeft: Padding from the left anchor
    ///   - right: The right anchor
    ///   - paddingRight: Padding from the right anchor
    ///   - width: Width constant
    ///   - height: Height constant
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0.0,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0.0,
                left: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0.0,
                right: NSLayoutXAxisAnchor? = nil,
                paddingRight: CGFloat = 0.0,
                width: CGFloat = 0.0,
                height: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
