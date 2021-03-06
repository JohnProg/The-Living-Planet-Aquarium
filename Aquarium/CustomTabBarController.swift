//
//  CustomTabBarController.swift
//  CustomTabBar
//
//  Created by Forrest Syrett on 4/28/17.
//  Copyright © 2017 Forrest Syrett. All rights reserved.
//

import UIKit


class CustomTabBarController: UITabBarController, CustomTabBarDataSource, CustomTabBarDelegate, UITabBarControllerDelegate {
    
    
    
    static let shared = CustomTabBarController()
    var selectedTabIndex = 0
    var buttonColor = aquaLight
    var home: Bool = true
    let homeButton = UIButton(frame: CGRect(x: 0, y: 2.0, width: 60, height: 60))
    var customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DeviceCheck.shared.checkDevice()
        
        self.tabBar.isHidden = true
        self.selectedIndex = 2
        self.selectedTabIndex = self.selectedIndex
       customTabBar = CustomTabBar(frame: self.tabBar.frame)
      // customTabBar = CustomTabBar(frame: CGRect(x: 0, y: 750.0, width: self.tabBar.frame.width, height: self.tabBar.frame.height))
        
        
        customTabBar.datasource = self
        customTabBar.delegate = self
        self.delegate = self

        self.view.addSubview(customTabBar)
        
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        
        
        // Messy solution for adjusting custom tab bar for iPhone X
        if DeviceCheck.shared.device == "iPhone X" {
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
           customTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           customTabBar.heightAnchor.constraint(equalToConstant: 90.0),
            customTabBar.bottomAnchor.constraintEqualToSystemSpacingBelow(self.view.bottomAnchor, multiplier: 1.0)
            ])
       
        }
      
        
        setupHomeButton()
        customTabBar.setup()
        print("Custom Tab Bar Height = \(customTabBar.frame.height)")
        print("TabBar stats = \(self.tabBar.frame)")
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    
    func tabBarItemsInCustomTabBar(_ tabBarView: CustomTabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    
    
    func didSelectViewController(_ tabBarView: CustomTabBar, atIndex index: Int) {
        self.selectedIndex = index
        changeHomeButtonColor()
        
    }
    
    func changeHomeButtonColor() {
        
        if self.selectedIndex == 2 {
            UIView.animate(withDuration: 0.3, animations: { 
                self.homeButton.backgroundColor = aquaDark
                self.homeButton.layer.shadowColor = UIColor.white.cgColor
                self.homeButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                self.homeButton.layer.shadowOpacity = 1.0
                self.homeButton.layer.shadowRadius = 3.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.homeButton.backgroundColor = aquaLight
                self.homeButton.layer.shadowColor = UIColor.white.cgColor
                self.homeButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                self.homeButton.layer.shadowOpacity = 0.0
                self.homeButton.layer.shadowRadius = 2.0
            })
        }
    }
    
    // MARK: - TabBarTransition Delegate
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTabBarAnimatedTransition()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
    }
    
    func setupHomeButton() {
        
        var yOrigin:CGFloat = 0.0
        var homeButtonFrame = homeButton.frame
        
        if DeviceCheck.shared.device == "iPhone X" {
            yOrigin = self.view.bounds.height - homeButtonFrame.height - 30
        } else {
            yOrigin = self.view.bounds.height - homeButtonFrame.height
        }
        
        homeButtonFrame.origin.y = yOrigin
        homeButtonFrame.origin.x = self.view.bounds.width/2 - homeButtonFrame.size.width/2
        homeButton.frame = homeButtonFrame
        homeButton.backgroundColor = buttonColor
        homeButton.layer.cornerRadius = homeButtonFrame.height/2
        homeButton.layer.borderColor = UIColor.white.cgColor
        homeButton.layer.borderWidth = 0.5
        self.view.addSubview(homeButton)
        homeButton.setImage(#imageLiteral(resourceName: "home"), for: .normal)
       changeHomeButtonColor()
        homeButton.tintColor = .white
        homeButton.isUserInteractionEnabled = false
        self.view.layoutIfNeeded()
    }
    
    func addConstraints() {
        
    }
    
    
    
}
