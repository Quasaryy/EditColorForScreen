//
//  ViewController.swift
//  EditColorForScreen
//
//  Created by Yury on 20.01.23.
//

import UIKit

class FirstViewController: UIViewController {
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        settingsVC?.definedColor = view.backgroundColor
        settingsVC?.delegate = self
    }

}

// MARK: Methods
extension FirstViewController: SettingsViewControllerDelegate {
    func colorFromSettingsVC(color: UIColor) {
        view.backgroundColor = color
    }
}

