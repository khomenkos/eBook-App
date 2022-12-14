//
//  PdfViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 06.12.2022.
//

import UIKit
import PDFKit

class PdfViewController: UIViewController {
    
    private let pdfUrl: URL
    private let document: PDFDocument!
    private let outline: PDFOutline?
    private var pdfView = PDFView()
    private var thumbnailView = PDFThumbnailView()
    private var outlineButton = UIButton()
    private var dismissButton = UIButton()
    
    init(pdfUrl: URL) {
        self.pdfUrl = pdfUrl
        self.document = PDFDocument(url: pdfUrl)
        self.outline = document.outlineRoot
        pdfView.document = document
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupPDFView()
        setupDismissButton()
        setupThumbnailView()
        setupOutlineButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.safeAreaLayoutGuide.layoutFrame
        let thumbanilHeight: CGFloat = 120
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: thumbnailView)
        view.addConstraintsWithFormat(format: "V:[v0(\(thumbanilHeight))]|", views: thumbnailView)
    }
    
    private func setupPDFView() {
        view.addSubview(pdfView)
        pdfView.displayDirection = .horizontal
        pdfView.usePageViewController(true)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfView.autoScales = true
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(toggleTools))
        pdfView.addGestureRecognizer(touch)
    }
    
    @objc func toggleTools() {
        if outlineButton.alpha != 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.outlineButton.alpha = 0
                self.thumbnailView.alpha = 0
                self.dismissButton.alpha = 0
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.outlineButton.alpha = 1
                self.thumbnailView.alpha = 1
                self.dismissButton.alpha = 1
            }, completion: nil)
        }
    }
    
    private func setupDismissButton() {
        dismissButton = UIButton(frame: CGRect(x: 30, y: 25, width: 40, height: 40))
        dismissButton.sizeSymbol(name: "chevron.down.circle", size: 30, weight: .light, scale: .medium)
        dismissButton.tintColor = .black
        view.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc private func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupThumbnailView() {
        thumbnailView.pdfView = pdfView
        thumbnailView.backgroundColor = UIColor(displayP3Red: 179/255, green: 179/255, blue: 179/255, alpha: 0.5)
        thumbnailView.layoutMode = .horizontal
        thumbnailView.thumbnailSize = CGSize(width: 80, height: 100)
        thumbnailView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.addSubview(thumbnailView)
    }
    
    private func setupOutlineButton() {
        outlineButton = UIButton(frame: CGRect(x: view.frame.maxX - 75, y: 25, width: 40, height: 40))
        outlineButton.sizeSymbol(name: "text.line.last.and.arrowtriangle.forward", size: 30, weight: .light, scale: .medium)
        outlineButton.tintColor = .black
        view.addSubview(outlineButton)
        outlineButton.addTarget(self, action: #selector(toggleOutline(sender:)), for: .touchUpInside)
    }
    
    @objc private func toggleOutline(sender: UIButton) {
        
        guard let outline = self.outline else {
            print("PDF has no outline")
            return
        }
        
        let outlineViewController = OutlineTableViewController(outline: outline, delegate: self)
        outlineViewController.preferredContentSize = CGSize(width: 300, height: 400)
        outlineViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverPresentationController = outlineViewController.popoverPresentationController
        popoverPresentationController?.sourceView = outlineButton
        popoverPresentationController?.sourceRect = CGRect(x: sender.frame.width/2, y: sender.frame.height, width: 0, height: 0)
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverPresentationController?.delegate = self
        
        self.present(outlineViewController, animated: true, completion: nil)
    }
}

extension PdfViewController: OutlineDelegate {
    func goTo(page: PDFPage) {
        pdfView.go(to: page)
    }
}

extension PdfViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

