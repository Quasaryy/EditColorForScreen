//
//  ViewController.swift
//  EditColorForScreen
//
//  Created by Yury on 20.01.23.
//

import UIKit

class FirstViewController: UIViewController {
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.delegate = self
    }

}

extension FirstViewController: SettingsViewControllerDelegate {
    func colorFromSettingsVC(color: UIColor) {
        view.backgroundColor = color
    }
}

