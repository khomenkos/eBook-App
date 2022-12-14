//
//  SceneDelegate.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 25.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.window?.rootViewController = TabBarViewController()
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

