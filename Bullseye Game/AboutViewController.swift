//
//  AboutViewController.swift
//  Bullseye Game
//
//  Created by Christopher Villanueva on 6/10/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    lazy var informationWebView: UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = .clear
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "Background"))
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        let closeButton = createButtonWithTitleAndBackground(title: "Close", background: #imageLiteral(resourceName: "Button-Normal"), action: #selector(handleDismiss))
        view.addSubview(closeButton)
       closeButton.anchor(top: nil, paddingTop: 0, left: nil, paddingLeft: 15, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBotton: 25, right: nil, paddingRight: 15, width: 0, height: 0)
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(informationWebView)
        informationWebView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 25, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 20, bottom: closeButton.topAnchor, paddingBotton: 20, right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 20, width: 0, height: 0)
    }

    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }

}
