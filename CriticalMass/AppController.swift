//
//  AppController.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 2/3/19.
//

import UIKit

class AppController {
    private var idProvider: IDProvider = IDStore()
    private var dataStore = AppDataStore()
    private var simulationModeEnabled = false

    private lazy var requestManager: RequestManager = {
        RequestManager(dataStore: dataStore, locationProvider: LocationManager(), networkLayer: networkOperator, idProvider: idProvider, errorHandler: mapOverlayErrorHandler, networkObserver: networkObserver)
    }()

    private lazy var networkOperator: NetworkOperator = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 15.0
        let session = URLSession(configuration: configuration)

        let networkDataProvider: NetworkDataProvider
        if simulationModeEnabled {
            networkDataProvider = SimulationNetworkDataProvider(realNetworkDataProvider: session)
        } else {
            networkDataProvider = session
        }
        return NetworkOperator(networkIndicatorHelper: NetworkActivityIndicatorHelper(), dataProvider: networkDataProvider)
    }()

    private let networkObserver: NetworkObserver? = {
        if #available(iOS 12.0, *) {
            return PathObserver()
        } else {
            return nil
        }
    }()

    private let themeController = ThemeController()

    private lazy var chatManager: ChatManager = {
        ChatManager(requestManager: requestManager)
    }()

    private lazy var chatNavigationButtonController: ChatNavigationButtonController = {
        ChatNavigationButtonController(chatManager: chatManager)
    }()

    private lazy var twitterManager: TwitterManager = {
        TwitterManager(networkLayer: networkOperator, request: TwitterRequest())
    }()

    private lazy var mapOverlayErrorHandler: ErrorHandler = {
        MapOverlayErrorHandler(presentInfoViewHandler: mapViewController.presentMapInfo)
    }()

    lazy var mapViewController: MapViewController = {
        MapViewController(
            themeController: self.themeController,
            friendsVerificationController: FriendsVerificationController(dataStore: dataStore),
            nextRideHandler: CMInApiHandler(networkLayer: networkOperator)
        )
    }()

    lazy var rootViewController: UIViewController = {
        let navigationOverlay = NavigationOverlayViewController(navigationItems: [
            .init(representation: .view(mapViewController.followMeButton),
                  action: .none,
                  accessibilityIdentifier: "Follow"),
            .init(representation: .button(chatNavigationButtonController.button),
                  action: .navigation(viewController: getSocialViewController),
                  accessibilityIdentifier: "Chat"),
            .init(representation: .icon(UIImage(named: "Knigge")!, accessibilityLabel: String.rulesTitle),
                  action: .navigation(viewController: getRulesViewController),
                  accessibilityIdentifier: "Rules"),
            .init(representation: .icon(UIImage(named: "Settings")!, accessibilityLabel: String.settingsTitle),
                  action: .navigation(viewController: getSettingsViewController),
                  accessibilityIdentifier: "Settings"),
        ])
        mapViewController.navigationOverlayViewController = navigationOverlay
        return mapViewController
    }()

    public func onAppLaunch() {
        loadInitialData()
        themeController.applyTheme()
        if #available(iOS 10.3, *) {
            RatingHelper().onLaunch()
        }
    }

    public func onWillEnterForeground() {
        if #available(iOS 10.3, *) {
            RatingHelper().onEnterForeground()
        }
    }

    public func enableSimulationMode() {
        simulationModeEnabled = true
    }

    private func getRulesViewController() -> RulesViewController {
        RulesViewController()
    }

    private func getChatViewController() -> ChatViewController {
        ChatViewController(chatManager: chatManager)
    }

    private func getTwitterViewController() -> TwitterViewController {
        TwitterViewController(twitterManager: twitterManager)
    }

    private func getSocialViewController() -> SocialViewController {
        SocialViewController(chatViewController: getChatViewController(), twitterViewController: getTwitterViewController())
    }

    private func getSettingsViewController() -> SettingsViewController {
        SettingsViewController(themeController: themeController, dataStore: dataStore, idProvider: idProvider)
    }

    private func loadInitialData() {
        requestManager.getData()
    }

    public func handle(url: URL) -> Bool {
        if Feature.friends.isActive {
            do {
                let followURLObject = try FollowURLObject.decode(from: url.absoluteString)

                dataStore.add(friend: followURLObject.queryObject)
                let alertController = UIAlertController(title: .settingsAddFriendTitle, message: followURLObject.queryObject.name + " " + .settingsAddFriendDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: .ok, style: .destructive, handler: nil))
                rootViewController.present(alertController, animated: true, completion: nil)
                return true
            } catch {
                // unknown or broken link
                return false
            }
        } else {
            return false
        }
    }
}
