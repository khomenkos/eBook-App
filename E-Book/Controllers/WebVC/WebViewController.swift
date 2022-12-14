//
//  WebViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 08.12.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    private let url: URL
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var forwardBarItem = UIBarButtonItem(title: "Forward", style: .plain, target: self,
                                         action: #selector(forwardAction))
    private lazy var backBarItem = UIBarButtonItem(title: "Backward", style: .plain, target: self,
                                      action: #selector(backAction))
    
    private lazy var buttonClose:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "red")?.cgColor
        button.tintColor = UIColor(named: "red")
        button.cornerRadius = 5
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavItem()
        let myURL = url
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    func setupNavItem() {
        self.navigationItem.leftBarButtonItem = backBarItem
        self.navigationItem.rightBarButtonItem = forwardBarItem
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.tintColor = .white
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func forwardAction() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func backAction() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        view.addSubview(buttonClose)
        NSLayoutConstraint.activate([
            webView.topAnchor
                .constraint(equalTo: self.view.topAnchor, constant: 50),
            webView.leftAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            buttonClose.topAnchor
                .constraint(equalTo: view.topAnchor, constant: 15),
            buttonClose.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonClose.widthAnchor
                .constraint(equalToConstant: 25),
            buttonClose.heightAnchor
                .constraint(equalToConstant: 25)
        ])
    }
}
