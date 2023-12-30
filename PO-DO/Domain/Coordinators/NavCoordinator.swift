//
//  NavCoordinator.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 23.12.2023.
//

import UIKit

class NavCoordinator {
    
    static let shared = NavCoordinator()
    
    private var started = false
    
    private init() {}
        
    func start(with window: UIWindow, root: UIViewController) {
        guard !self.started else {
            fatalError("NavCoordinator already started")
        }
        window.rootViewController = root
        window.makeKeyAndVisible()
        self.started = true
    }
    
    func requestNavigation(to viewController: UIViewController, with navigationType: NavType, setRoot: Bool = false) {
        guard self.started else {
            fatalError("NavCoordinator not started")
        }
        switch navigationType {
        case .push(let animated):
            let topViewController = self.getCurrentNavController()
            self.navigate(from: topViewController, to: viewController, animated: animated)
        case .present(let presenter, let animated):
            presenter.asUIViewController().present(viewController, animated: animated)
        case .replace:
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
                return
            }
            
            if setRoot == true {
                let navController = UINavigationController(rootViewController: viewController)
                navController.navigationBar.isHidden = true
                window.rootViewController = navController
                window.makeKeyAndVisible()
            } else {
                window.rootViewController = viewController
                window.makeKeyAndVisible()
            }
        }
    }
    
    private func navigate(from context: UIViewController?, to targetVC: UIViewController, animated: Bool) {
        guard context?.isBeingPresented == false else {
            print("Attempting to navigate from a presented controller!")
            return
        }
        if let tabBarController = context?.tabBarController {
            if self.navigateFromTabController(tabBarController, to: targetVC) { return }
        }
        if let navController = context?.navigationController {
            if self.navigateFromNavigationController(navController, to: targetVC, animated: animated) { return }
        }
        if let controller = context {
            controller.present(targetVC, animated: animated)
        }
    }

    private func getCurrentNavController() -> UIViewController? {
        guard let root = UIApplication.shared.getActiveWindow()?.rootViewController else {return nil}
        return getTopViewController(root)
    }

    private func getTopViewController(_ root: UIViewController) -> UIViewController {
        if root is UITabBarController {
            let tabBarController = (root as? UITabBarController)!
            return self.getTopViewController(tabBarController.selectedViewController!)
        } else if root is UINavigationController {
            let navigationController = (root as? UINavigationController)!
            // special case
            if navigationController.visibleViewController is UIAlertController {
                return self.getTopViewController(navigationController.viewControllers.last!)
            }
            if let vc = navigationController.visibleViewController {
                return self.getTopViewController(vc)
            } else {
                return root
            }
        } else if let presentedViewController = root.presentedViewController {
            // special case
            if presentedViewController is UIAlertController {
                return root
            }

            return self.getTopViewController(root.presentedViewController!)
        } else {
            // special case
            if root is UIAlertController {
                if let presentingViewController = root.presentingViewController {
                    return self.getTopViewController(presentingViewController)
                }
            }
            return root
        }
    }
    
    private func navigateFromTabController(_ tabController: UITabBarController, to targetVC: UIViewController) -> Bool {
        for childViewController in tabController.viewControllers! {
            if childViewController.isMember(of: type(of: targetVC)) {
                let index = tabController.viewControllers?.firstIndex(of: childViewController)
                if index != tabController.selectedIndex {
                    tabController.selectedIndex = index!
                    return true
                }
            }
        }
        return false
    }

    private func navigateFromNavigationController(_ navController: UINavigationController, to targetVC: UIViewController, animated: Bool) -> Bool {
        navController.pushViewController(targetVC, animated: animated)
        return true
    }

    private func navigateFromPresentedController(_ controller: UIViewController, to targetVC: UIViewController, animated: Bool) {
        controller.present(targetVC, animated: animated)
    }

    func closeViewController(_ animated: Bool) {

        let topViewController = self.getCurrentNavController()
        if let navigationController = topViewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else if topViewController?.presentingViewController != nil {
            topViewController?.dismiss(animated: animated)

        }
    }

    enum NavType {
        case push(animated: Bool)
        case present(presenter: AnyBaseViewController, animated: Bool)
        case replace
    }
}

protocol AnyBaseViewController {
    func asUIViewController() -> UIViewController
}
