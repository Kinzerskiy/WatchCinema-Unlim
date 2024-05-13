//
//  NavigationAssembly.swift
//  WatchCinema Unlim
//
//  Created by User on 11.05.2024.
//

import Foundation
import UIKit


protocol CommonNavigationAssemblyProtocol {
    func assemblyTabbarController(with items: Array<UIViewController>) -> UITabBarController
    func assemblyNavigationController(with item: UIViewController) -> UINavigationController
}

protocol MainNavigationAssemblyProtocol {
    func assemblyIntroViewController(with router: MainRouting) -> IntroViewController
}

protocol ActualNavigationAssemblyProtocol {
    func assemblyActualViewController(with router: ActualRouting) -> ActualViewController
}



protocol NavigationAssemblyProtocol: CommonNavigationAssemblyProtocol,
                                     MainNavigationAssemblyProtocol,
                                     ActualNavigationAssemblyProtocol
{ }

class NavigationAssembly: BaseAssembly, NavigationAssemblyProtocol {
   
    private static let mainStoryboardName = "Main"
    private static let actualStoryboardName = "Actual"

    // MARK: - Storyboard
    
    func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: NavigationAssembly.mainStoryboardName, bundle: Bundle(for: NavigationAssembly.self))
    }
    
    func actualStoryboard() -> UIStoryboard {
        return UIStoryboard(name: NavigationAssembly.actualStoryboardName, bundle: Bundle(for: NavigationAssembly.self))
    }
    
    
    // MARK: Common
    
    func assemblyTabbarController(with items: Array<UIViewController>) -> UITabBarController {
        let controller = mainStoryboard().instantiateViewController(withIdentifier: String(describing: MainTabBarViewController.self)) as! MainTabBarViewController
        controller.viewControllers = items
        
        return controller
    }
    
    func assemblyNavigationController(with item: UIViewController) -> UINavigationController {
        
        return NavigationController(rootViewController: item)
    }
    
    func assemblyAlertController(with title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    // MARK: Main
    
    func assemblyIntroViewController(with router: MainRouting) -> IntroViewController {
        let vc: IntroViewController = mainStoryboard().instantiateViewController(withIdentifier: String(describing: IntroViewController.self)) as! IntroViewController
        
        return vc
    }
    
    
    // MARK: Actual
    
    func assemblyActualViewController(with router: ActualRouting) -> ActualViewController {
        let vc: ActualViewController = actualStoryboard().instantiateViewController(withIdentifier: String(describing: ActualViewController.self)) as! ActualViewController
        
        return vc
    }
}
