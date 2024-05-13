//
//  ApplicationRouter.swift
//  WatchCinema Unlim
//
//  Created by User on 11.05.2024.
//

import UIKit

enum ApplicationStoryType {
    case main
    case actual
}

protocol ApplicationRouting: BaseRouting {
    func showIntroForm(from viewController: UIViewController?, animated: Bool, completion: RoutingCompletionBlock?)
}

class ApplicationRouter: ApplicationRouting, MainRouterDelegate {
    
    private var applicationAssembly: ApplicationAssemblyProtocol
    
    private var rootContentController: UITabBarController?
    
    private var activeStoryType: ApplicationStoryType?
    private var previousStoryType: ApplicationStoryType?
    
    private var mainRouter: MainRouter?
    private var actualRouter: ActualRouter?

    // MARK: - Memory management
    
    required init(with assembly: ApplicationAssemblyProtocol) {
        applicationAssembly = assembly
        
        setupRouters()
    }
    
    private func setupRouters() {
        mainRouter = assemblyMainRouter()
        actualRouter = assemblyActualRouter()
    }
    
    // MARK: - BaseRouting
    
    func initialViewController() -> UIViewController? {
        
        let rootItem: Array<UIViewController> = [
            intialialViewControllerForItem(with: .actual)
        ]
        
        rootContentController = navigationAssembly().assemblyTabbarController(with: rootItem)
        
        return rootContentController
    }
    
    // MARK: - ApplicationRouting
    
    func showIntroForm(from viewController: UIViewController?, animated: Bool, completion: RoutingCompletionBlock?) {
        rootContentController?.present((mainRouter?.initialViewController())!, animated: animated, completion: completion)
    }
    
    // MARK: - AuthRouterDelegate
    
    func introRouterDidFinishLoading(router: MainRouter) {
        Defaults.firstInitialization = false
        router.initialViewController().dismiss(animated: false)
        
        switchToStory(with: .actual)
    }
    
    // MARK: - Assembly
    
    func navigationAssembly() -> NavigationAssemblyProtocol {
        return applicationAssembly.sharedNavigationAssembly
    }
    
    func assemblyMainRouter() -> MainRouter {
        let router = MainRouter(with: navigationAssembly())
        router.mainDelegate = self
        
        return router
    }
    
    func assemblyActualRouter() -> ActualRouter {
        let router = ActualRouter(with: navigationAssembly())
        
        return router
    }
    
    // MARK: - Private
    
    private func switchToStory(with type: ApplicationStoryType) {
        rootContentController?.selectedViewController = intialialViewControllerForItem(with: type)
        
        if activeStoryType != type {
            previousStoryType = activeStoryType
        }
        
        activeStoryType = type
    }
    
    private func intialialViewControllerForItem(with type: ApplicationStoryType) -> UIViewController {
        
        switch type {
        case .actual:
            return (actualRouter?.initialViewController())!
        case .main:
            return (mainRouter?.initialViewController())!
        }
    }
}
