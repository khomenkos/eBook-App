//
//  UIViewController+Extensions.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 15.12.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String, actionTitle: String, completion: (()->())? = nil) {
        let alertController = UIAlertController( title: title,
                                                 message: message,
                                                 preferredStyle: .alert)
        alertController.addAction(UIAlertAction( title: actionTitle,
                                                 style: .default,
                                                 handler: { _ in
            completion?()
        }))
        self.present(alertController, animated: true)
    }
}
