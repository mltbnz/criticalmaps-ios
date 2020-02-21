//
//  CALayer+Shadow.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 17.12.19.
//  Copyright © 2019 Pokus Labs. All rights reserved.
//

import UIKit

extension CALayer {
    func setupMapOverlayConfiguration() {
        shadowColor = UIColor.black.cgColor
        shadowRadius = 4
        shadowOpacity = 0.2
        shadowOffset = CGSize(width: 0, height: 2)
    }
}

extension CALayer {
    var shadow: Shadow? {
        set(newValue) {
            shadowColor = UIColor.systemPink.cgColor
            shadowRadius = 4
            shadowOpacity = 0.9
            shadowOffset = CGSize(width: 0, height: 8)
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
            guard let color = shadowColor else { return nil }
            return Shadow(
                color: UIColor(cgColor: color),
                opacity: shadowOpacity,
                radius: shadowRadius,
                offset: shadowOffset
            )
        }
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
