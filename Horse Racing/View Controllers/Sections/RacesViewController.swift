//
//  ViewController.swift
//  Horse Racing
//
//  Created on 30/07/2021.
//

import UIKit

class RacesViewController: UIViewController, BottomSheetAttachable, RacesViewDelegate {
    
    lazy var racesView = RacesView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = racesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        racesView.delegate = self
    }
    
    // MARK: - RacesViewDelegate
    
    func tempButtonTapped() {
        displayBottomSheet()
    }
    
    // MARK: - BottomSheetAttachable
    
    var viewControllerToPresent: UIViewController {
        get {
            return RacesViewController()
        }
    }
}
