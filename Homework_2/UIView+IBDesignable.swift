//
//  UIView+IBDesignable.swift
//  Homework_2
//
//  Created by Aliona Starunska on 16.12.2020.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
