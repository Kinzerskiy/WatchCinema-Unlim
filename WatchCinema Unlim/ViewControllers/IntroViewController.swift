//
//  IntroViewController.swift
//  WatchCinema Unlim
//
//  Created by User on 11.05.2024.
//

import UIKit

protocol IntroViewControllerDelegate {
    func introControllerDidFinishLoading(viewController: IntroViewController)
}

class IntroViewController: UIViewController {

    var introDelegate: IntroViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introDelegate?.introControllerDidFinishLoading(viewController: self)
        // Do any additional setup after loading the view.
    }

}
