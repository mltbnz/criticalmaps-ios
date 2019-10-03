//
//  FollowFriendsViewController.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 5/2/19.
//

import UIKit

class FollowFriendsViewController: UIViewController {
    private var urlString: String?
    private var name: String
    private var oldBrightness: CGFloat

    init(name: String) {
        self.name = name
        oldBrightness = UIScreen.main.brightness
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow100

        configureNavigationBar()

        do {
            let publicKeyData = try RSAKey(tag: RSAKey.keychainTag).publicKeyDataRepresentation()
            urlString = try FollowURLObject(queryObject: Friend(name: name, key: publicKeyData)).asURL()
        } catch {
            // TODO: present error
            fatalError()
        }

        configureQRCodeView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIScreen.main.brightness = 100
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        UIScreen.main.brightness = oldBrightness
    }

    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareLinkButtonTapped))
    }

    private func configureQRCodeView() {
        let backgroundView = QRCodeBackgroundView(frame: .zero)
        backgroundView.backgroundColor = .clear

        view.addSubview(backgroundView)

        let qrCodeView = QRCodeView(frame: .zero)
        qrCodeView.backgroundColor = .clear
        qrCodeView.text = urlString
        view.addSubview(qrCodeView)

        backgroundView.addLayoutsCenter(in: view, size: CGSize(width: 280, height: 280))
        qrCodeView.addLayoutsCenter(in: view, size: CGSize(width: 247, height: 247))
    }

    @objc func shareLinkButtonTapped() {
        let activityViewController = UIActivityViewController(activityItems: [urlString!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}