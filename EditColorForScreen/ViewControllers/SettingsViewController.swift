//
//  SettingsViewController.swift
//  EditColorForScreen
//
//  Created by Yury on 20.01.23.
//

import UIKit

class SettingsViewController: UIViewController {
    

    // MARK: IB Outlets
    // LAbels
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var redValueLabel: UILabel!
    
    // Sliders
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var redSlider: UISlider!
    
    // Text fields
    @IBOutlet var blueTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var redTF: UITextField!
    
    @IBOutlet var viewColor: UIView!
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewColor.layer.cornerRadius = 10
        
        // Sliders settings
        blueSlider.minimumValue = 1
        blueSlider.maximumValue = 255
        blueSlider.value = 50
        blueSlider.tag = 3
        greenSlider.minimumValue = 1
        greenSlider.maximumValue = 255
        greenSlider.value = 100
        greenSlider.tag = 2
        redSlider.minimumValue = 1
        redSlider.maximumValue = 255
        redSlider.value = 155
        redSlider.tag = 1
        
        // Text fields settings
        redTF.placeholder = String(Int(redSlider.value))
        greenTF.placeholder = String(Int(greenSlider.value))
        blueTF.placeholder = String(Int(blueSlider.value))
        
        // Color labels settings
        redValueLabel.text = String(Int(redSlider.value))
        greenValueLabel.text = String(Int(greenSlider.value))
        blueValueLabel.text = String(Int(blueSlider.value))
    }
    
    // MARK: IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        let sliderValue = String(Int((sender.value)))
        switch sender.tag {
        case 1:
            redValueLabel.text = sliderValue
            redTF.placeholder = sliderValue
        case 2:
            greenValueLabel.text = sliderValue
            greenTF.placeholder = sliderValue
        case 3:
            blueValueLabel.text = sliderValue
            blueTF.placeholder = sliderValue
        default:
            return
        }
    }
    
    
}

// MARK: Pulic Methods
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        changeSliderAndLabelsValues(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changeSliderAndLabelsValues(textField: textField)
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

// MARK: Private Methods
extension SettingsViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "OK", style: .default)
        alert.addAction(buttonOK)
        present(alert, animated: true)
    }
    
    private func changeSliderAndLabelsValues(textField: UITextField) {
        // Cheking that text field is not empty
        if !textField.text!.isEmpty {
            // If not empty checking that entered number
            guard let stringToInt = Int(textField.text!) else {
                showAlert(title: "Invalid value", message: "Please enter color value in numbers format from 0 to 255")
                textField.text = ""
                return
            }
            // If entered number checking that number in valid range
            guard 0...255 ~= stringToInt else {
                showAlert(title: "Invalid value", message: "Please enter color value in numbers format from 0 to 255")
                textField.text = ""
                return
            }
        }
        switch textField {
        case redTF:
            redTF.placeholder! = textField.text!.isEmpty ? String(Int(redSlider.value)) : textField.text!
            redSlider.value = Float(textField.text!) ?? redSlider.value
            redValueLabel.text = textField.text!.isEmpty ? String(Int(redSlider.value)) : textField.text!
            redTF.text = ""
        case greenTF:
            greenTF.placeholder = textField.text!.isEmpty ? String(Int(greenSlider.value)) : textField.text!
            greenSlider.value = Float(textField.text!) ?? greenSlider.value
            greenValueLabel.text = textField.text!.isEmpty ? String(Int(greenSlider.value)) : textField.text!
            greenTF.text = ""
        case blueTF:
            blueTF.placeholder = textField.text!.isEmpty ? String(Int(blueSlider.value)) : textField.text!
            blueSlider.value = Float(textField.text!) ?? blueSlider.value
            blueValueLabel.text = textField.text!.isEmpty ? String(Int(blueSlider.value)) : textField.text!
            blueTF.text = ""
        default:
            return
        }
    }
    
}
