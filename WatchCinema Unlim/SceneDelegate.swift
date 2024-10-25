//
//  SceneDelegate.swift
//  WatchCinema Unlim
//
//  Created by User on 11.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var applicationAssembly: ApplicationAssemblyProtocol?
    private var applicationRouter: ApplicationRouting?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        UIWindow.appearance().overrideUserInterfaceStyle = .light
        
        setupRouting()
        setupWindow()
    }
    
    // MARK: - private
    
    private func setupRouting() {
        let assembly: ApplicationAssembly = ApplicationAssembly.defaultAssembly()
        applicationAssembly = assembly
        let router: ApplicationRouting = assembly.assemblyApplicationRouter()
        applicationRouter = router
    }
    
    private func setupWindow() {
        window?.rootViewController = applicationRouter?.initialViewController()
        window?.makeKeyAndVisible()
        
        if Defaults.firstInitialization {
            applicationRouter?.showIntroForm(from: window?.rootViewController, animated: false, completion: nil)
        }
    }
}
