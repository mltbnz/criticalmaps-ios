//
//  CALayer+Shadow.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 17.12.19.
//  Copyright © 2019 Pokus Labs. All rights reserved.
//

import UIKit

extension CALayer {
    var shadow: Shadow? {
        set(newValue) {
            shadowColor = newValue?.color.cgColor
            shadowRadius = newValue?.radius ?? 0.0
            shadowOpacity = newValue?.opacity ?? 0.0
            shadowOffset = newValue?.offset ?? .zero
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
        color: .black,
        opacity: 0.2,
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
