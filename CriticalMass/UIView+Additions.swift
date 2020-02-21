//
//  UIView+Autolayout.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 30.09.19.
//  Copyright © 2019 Pokus Labs. All rights reserved.
//

import UIKit

extension UIView {
    func addLayoutsCenter(in view: UIView, size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false

        view.addConstraints([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        addConstraints([
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width),
        ])
    }

    func addLayoutsSameSizeAndOrigin(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        view.addConstraints([
            heightAnchor.constraint(equalTo: view.heightAnchor),
            widthAnchor.constraint(equalTo: view.widthAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}

struct Shadow {
    let color: UIColor
    let opacity: Float
    let radius: CGFloat
    let offset: CGSize
}

extension Shadow {
    static let `default` = Shadow(
        color: .systemPink,
        opacity: 0.9,
        radius: 4.0,
        offset: CGSize(width: 0, height: 2)
    )
    static let innerShadow = Shadow(
        color: .twitterProfileInnerBorder,
        opacity: 1.0,
        radius: 0.0,
        offset: .zero
    )
}

extension UIView {
    var shadow: Shadow? {
        set(newValue) {
            layer.shadowColor = UIColor.systemPink.cgColor
            layer.shadowRadius = 4
            layer.shadowOpacity = 0.9
            layer.shadowOffset = CGSize(width: 0, height: 8)
//            let mask = CAShapeLayer()
//            mask.path = UIBezierPath(
//                roundedRect: bounds,
//                cornerRadius: layer.cornerRadius
//            ).cgPath
//            layer.mask = mask
//
//            let shadowLayer = CAShapeLayer()
//            shadowLayer.frame = frame
//            shadowLayer.path = UIBezierPath(
//                roundedRect: bounds,
//                cornerRadius: layer.cornerRadius
//            ).cgPath
//            shadowLayer.shadowColor = newValue?.color.cgColor
//            shadowLayer.shadowOpacity = 1
//            shadowLayer.shadowRadius = 5
//            shadowLayer.masksToBounds = false
//            shadowLayer.shadowOffset = .zero
//
//            layer.addSublayer(shadowLayer)
        }
        get {
            guard let color = layer.shadowColor else { return nil }
            return Shadow(
                color: UIColor(cgColor: color),
                opacity: layer.shadowOpacity,
                radius: layer.shadowRadius,
                offset: layer.shadowOffset
            )
        }
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
