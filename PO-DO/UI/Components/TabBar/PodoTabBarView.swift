//
//  CRXHeaderView.swift
//  CRXDCA
//
//  Created by Recep Taha Aydın on 20.09.2023.
//

import UIKit

class PodoTabBarView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var tabBar: UITabBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    private func initializeView() {
        Bundle.main.loadNibNamed("PodoTabBarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.delegate = self
    }
}

extension PodoTabBarView: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            NavCoordinator.shared.requestNavigation(to: HomeViewController(), with: .replace, setRoot: true)
        } else if item.tag == 1 {
            NavCoordinator.shared.requestNavigation(to: ProjectsViewController(), with: .replace, setRoot: true)
        } else if item.tag == 2 {
            NavCoordinator.shared.requestNavigation(to: AnalyticsViewController(), with: .replace, setRoot: true)
        } else {
            NavCoordinator.shared.requestNavigation(to: SettingsViewController(), with: .replace, setRoot: true)
        }
    }
}
