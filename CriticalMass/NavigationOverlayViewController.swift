//
//  NavigationOverlayViewController.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 2/3/19.
//

import UIKit

class SeparatorView: UIView {}
class OverlayView: UIView {
    @objc
    dynamic var overlayBackgroundColor: UIColor? {
        willSet {
            backgroundColor = newValue
        }
    }
}

struct NavigationOverlayItem {
    enum Action {
        case navigation(viewController: () -> UIViewController)
        case none
    }

    enum Representation {
        case icon(_ icon: UIImage, accessibilityLabel: String)
        case view(_ view: UIView)
        case button(_ button: UIButton)
    }

    let representation: Representation
    let action: Action
    let accessibilityIdentifier: String
}

class NavigationOverlayViewController: UIViewController, IBConstructable {
    @IBOutlet private var overlayStackView: UIStackView!
    @IBOutlet private var overlayContainerView: UIView!

    private let items: [NavigationOverlayItem]

    init(navigationItems: [NavigationOverlayItem]) {
        items = navigationItems
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(items: items)
        view.accessibilityTraits.insert(.tabBar)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard overlayContainerView.shadow != nil else { return }
        overlayContainerView.shadow = .default
    }

    private func configure(items: [NavigationOverlayItem]) {
        var itemViews: [UIView] = []
        for (index, item) in items.enumerated() {
            switch item.representation {
            case let .icon(icon, accessibilityLabel: accessibilityLabel):
                let button = CustomButton(frame: .zero)
                button.setImage(icon, for: .normal)
                button.adjustsImageWhenHighlighted = false
                button.accessibilityLabel = accessibilityLabel
                button.accessibilityIdentifier = item.accessibilityIdentifier
                button.tag = index
                button.addTarget(self, action: #selector(didTapNavigationItem(button:)), for: .touchUpInside)
                itemViews.append(button)
            case let .view(view):
                view.accessibilityIdentifier = item.accessibilityIdentifier
                itemViews.append(view)
            case let .button(button):
                button.tag = index
                button.accessibilityIdentifier = item.accessibilityIdentifier
                button.addTarget(self, action: #selector(didTapNavigationItem(button:)), for: .touchUpInside)
                itemViews.append(button)
            }
        }
        itemViews.enumerated().forEach { offset, view in
            overlayStackView.insertArrangedSubview(view, at: offset)
        }
        overlayStackView.addHorizontalSeparators()
    }

    @objc func didTapNavigationItem(button: UIButton) {
        button.isHighlighted = false
        let selectedItem = items[button.tag]

        switch selectedItem.action {
        case .none:
            break
        case let .navigation(viewController: viewController):
            let navigationController = UINavigationController(rootViewController: viewController())
            let barbuttonItem = UIBarButtonItem(image: UIImage(named: "Close"), style: .done, target: self, action: #selector(didTapCloseButton(button:)))
            barbuttonItem.accessibilityLabel = String.closeButtonLabel
            navigationController.navigationBar.topItem?.setLeftBarButton(barbuttonItem, animated: false)
            present(navigationController, animated: true, completion: nil)
        }
    }

    @objc func didTapCloseButton(button _: UIBarButtonItem) {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}

private extension UIStackView {
    func addHorizontalSeparators() {
        var viewCount = arrangedSubviews.count
        while viewCount > 0 {
            if viewCount != arrangedSubviews.count {
                insertArrangedSubview(createVerticalSeparator(), at: viewCount)
            }
            viewCount -= 1
        }
    }

    private func createVerticalSeparator() -> UIView {
        let separator = SeparatorView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
}
