//
//  SplashViewController.swift
//  CRXDCA
//
//  Created by Recep Taha Aydın on 25.07.2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            NavCoordinator.shared.requestNavigation(to: OnboardingViewController(viewModel: OnboardingViewModel()), with: .replace, setRoot: true)
        }
    }
}
