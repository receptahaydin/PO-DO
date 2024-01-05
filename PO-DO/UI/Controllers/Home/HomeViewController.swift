//
//  HomeViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 29.12.2023.
//

import UIKit
import SRCountdownTimer

class HomeViewController: UIViewController {
    
    @IBOutlet weak var timer: SRCountdownTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.lineWidth = 20.0
        timer.lineColor = UIColor.init(hexString: "55AA67")
        timer.trailLineColor = UIColor.lightGray.withAlphaComponent(0.5)
        timer.isLabelHidden = false
        timer.labelTextColor = .black
        timer.start(beginingValue: 90, interval: 1)
    }
}
