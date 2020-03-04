//
// Created for CriticalMaps in 2020

import UIKit

@propertyWrapper
public struct UseAutoLayoutView<T: UIView> {
    public var wrappedValue: T {
        didSet { setAutoLayout() }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        setAutoLayout()
    }

    private func setAutoLayout() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}

@propertyWrapper
public struct UseAutoLayoutViewController<T: UIViewController> {
    public var wrappedValue: T {
        didSet { setAutoLayout() }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        setAutoLayout()
    }

    private func setAutoLayout() {
        wrappedValue.view.translatesAutoresizingMaskIntoConstraints = false
    }
}
