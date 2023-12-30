//
//  AppDelegate.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 23.12.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        NavCoordinator.shared.start(with: window, root: (SplashViewController()))
        
        configureKeyboardManager()
        
        return true
    }
    
    private func configureKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        IQKeyboardManager.shared.placeholderFont = .regular(size: 14)
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.disabledTouchResignedClasses = []
        IQKeyboardManager.shared.disabledToolbarClasses =  []
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = []
    }
}

