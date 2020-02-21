//
//  RoundedCornerImageView.swift
//  CriticalMaps
//
//  Created by Malte Bünz on 12.03.19.
//  Copyright © 2019 Pokus Labs. All rights reserved.
//

import UIKit

@IBDesignable
class RoundableImageView: UIImageView {
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            applyCornerRadius()
        }
    }

    @IBInspectable var borderWidth: Double = 0.0 {
        didSet {
            applyCornerRadius()
        }
    }

    @IBInspectable var circular: Bool = false {
        didSet {
            applyCornerRadius()
        }
    }

    @IBInspectable var hasInnerShadow: Bool = true {
        didSet {
            addInnerShadow()
        }
    }

    private func applyCornerRadius() {
        if circular {
            layer.cornerRadius = bounds.size.height / 2
        } else {
            layer.cornerRadius = cornerRadius
        }
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = CGFloat(borderWidth)
    }

    private func addInnerShadow() {
        guard hasInnerShadow else {
            return
        }
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        let path = UIBezierPath(ovalIn: bounds.insetBy(dx: -1, dy: -1))
        let cutout = UIBezierPath(ovalIn: bounds).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadow = .innerShadow
        // Add
        layer.addSublayer(innerShadow)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        applyCornerRadius()
        addInnerShadow()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyCornerRadius()
        addInnerShadow()
    }
}
