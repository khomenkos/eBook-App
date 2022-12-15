//
//  TabBarViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 27.11.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        setupTabBar()
    }
    
    func setupTabBar() {
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: MyBooksViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "book")

        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "My Books"
        setViewControllers([vc1, vc2, vc3], animated: true)
    }

}

extension TabBarViewController: UITabBarControllerDelegate  {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarAnimatedTransitioning()
    }
}

final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

        destination.alpha = 0.0
        transitionContext.containerView.addSubview(destination)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
        }, completion: { transitionContext.completeTransition($0) })
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
