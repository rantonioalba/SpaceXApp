//
//  UIView+Extensions.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import UIKit

extension UIView {
    func setConstraints(
        top: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        pTop: CGFloat = CGFloat.zero,
        pRight: CGFloat = CGFloat.zero,
        pBottom: CGFloat = CGFloat.zero,
        pLeft: CGFloat = CGFloat.zero
    )  {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: pTop).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -pRight).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -pBottom).isActive = true
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: pLeft).isActive = true
        }
    }
    
    func fillSuperView(withPadding:CGFloat = .zero) {
        guard let superview = self.superview else {return}
        setConstraints(
            top: superview.topAnchor,
            right: superview.trailingAnchor,
            bottom: superview.bottomAnchor,
            left: superview.leadingAnchor,
            pTop: withPadding,
            pRight: withPadding,
            pBottom: withPadding,
            pLeft: withPadding)
    }
    
    func centerY() {
        guard let superview = self.superview else { return  }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func centerX() {
        guard let superview = self.superview else { return  }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func centerXY() {
        centerY()
        centerX()
    }
}
