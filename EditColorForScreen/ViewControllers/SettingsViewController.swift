//
//  SettingsViewController.swift
//  EditColorForScreen
//
//  Created by Yury on 20.01.23.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func colorFromSettingsVC(color: UIColor)
}

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
    
    // MARK: Properties
    var definedColor: UIColor!
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sliders settings
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 255
        blueSlider.tag = 3
        blueSlider.minimumTrackTintColor = .systemBlue
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 255
        greenSlider.tag = 2
        greenSlider.minimumTrackTintColor = .systemGreen
        redSlider.minimumValue = 0
        redSlider.maximumValue = 255
        redSlider.tag = 1
        redSlider.minimumTrackTintColor = .systemRed
        colorForSliderValue()
        
        // Text fields settings
        redTF.placeholder = string(from: redSlider)
        greenTF.placeholder = string(from: greenSlider)
        blueTF.placeholder = string(from: blueSlider)
        
        // Color labels settings
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        // Color screen settings
        viewColor.layer.cornerRadius = 10
        setViewColorBackgroundColor()
    }
    
    
    
    // MARK: IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        let sliderValue = string(from: sender)
        switch sender.tag {
        case 1:
            redValueLabel.text = sliderValue
            redTF.placeholder = sliderValue
            setViewColorBackgroundColor()
        case 2:
            greenValueLabel.text = sliderValue
            greenTF.placeholder = sliderValue
            setViewColorBackgroundColor()
        case 3:
            blueValueLabel.text = sliderValue
            blueTF.placeholder = sliderValue
            setViewColorBackgroundColor()
        default:
            return
        }
    }
    
    
    @IBAction func doneButtonTapped() {
        delegate?.colorFromSettingsVC(color: definedColor)
        dismiss(animated: true)
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
    
    // Alert Controller
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "OK", style: .default)
        alert.addAction(buttonOK)
        present(alert, animated: true)
    }
    
    private func changeSliderAndLabelsValues(textField: UITextField) {
        // Unwrapping optional type
        guard let text = textField.text else { return }
        // Cheking that text field is not empty
        guard !text.isEmpty else { return }
        // If not empty checking that entered number
        guard let stringToFloat = Float(text) else {
                showAlert(title: "Invalid value", message: "Please enter color value in numbers format from 0 to 255")
                textField.text = ""
                return
            }
        // If entered number checking that number in valid range
        guard 0...255 ~= stringToFloat else {
                showAlert(title: "Invalid value", message: "Please enter color value in numbers format from 0 to 255")
                textField.text = ""
                return
            }
        switch textField {
        case redTF:
            redTF.placeholder = text
            redSlider.value = stringToFloat
            redValueLabel.text = text
            redTF.text = ""
            setViewColorBackgroundColor()
        case greenTF:
            greenTF.placeholder = text
            greenSlider.value = stringToFloat
            greenValueLabel.text = text
            greenTF.text = ""
            setViewColorBackgroundColor()
        case blueTF:
            blueTF.placeholder = text
            blueSlider.value = stringToFloat
            blueValueLabel.text = text
            blueTF.text = ""
            setViewColorBackgroundColor()
        default:
            return
        }
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.0f", slider.value)
    }
    
    // Getting colors from FirstVC view.backgroundColor to setup slider.value
    private func colorForSliderValue() {
        let ciColor = CIColor(color: definedColor)
        redSlider.value = Float(ciColor.red) * 255
        greenSlider.value = Float(ciColor.green) * 255
        blueSlider.value = Float(ciColor.blue) * 255
    }
    
    private func setViewColorBackgroundColor() {
        viewColor.backgroundColor = UIColor(red: CGFloat(redSlider.value / 255), green: CGFloat(greenSlider.value / 255), blue: CGFloat(blueSlider.value / 255), alpha: 1)
        definedColor = viewColor.backgroundColor
    }
}
