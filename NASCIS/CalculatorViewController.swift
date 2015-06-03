//
//  ViewController.swift
//  NASCIS
//
//  Created by Pieter Kubben on 23-04-15.
//  Copyright (c) 2015 DigitalNeurosurgeon.com. All rights reserved.
//

import UIKit
import Foundation

class CalculatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var statusIcon: UIBarButtonItem!
    @IBOutlet weak var timeSinceSpinalCordInjury: UISegmentedControl!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var weightInKilogramOrPounds: UISegmentedControl!
    @IBOutlet weak var suggestedDoseTextView: UITextView!
    
    let kPoundToKilogram = 0.45359237

    
    // MARK: - Basic configuration
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightTextField.delegate = self
        weightInKilogramOrPounds.selectedSegmentIndex = loadWeightPreference()
        suggestedDoseTextView.hidden = true
        
        // == FOR TESTING ONLY ==
        // weightTextField.text = "70"
        //
 
    }
    

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        calculateDose(self)
        textField.resignFirstResponder()
        return false
    }
    
    
    // MARK: - Weight preference
    
    
    func saveWeightPreference() {
        let preferences = NSUserDefaults.standardUserDefaults()
        preferences.setValue(weightInKilogramOrPounds.selectedSegmentIndex, forKey: "weightPreference")
    }
    
    
    func loadWeightPreference() -> Int {
        let preferences = NSUserDefaults.standardUserDefaults()
        if let weightPreference = preferences.integerForKey("weightPreference") as Int? {
            return weightPreference
        } else {
            return 0
        }
    }
    
    
    @IBAction func weightPreferenceChanged(sender: AnyObject) {
        saveWeightPreference()
        if weightTextField.text != nil {
            calculateDose(self)
        }
    }
    
    
    // MARK: - Calculations

    
    @IBAction func timeSinceSpinalCordInjuryChanged(sender: AnyObject) {
        if weightTextField.text != nil {
            calculateDose(self)
        }
    }
    
    
    @IBAction func calculateDose(sender: AnyObject) {
        
        let weight: Int
        let weightInKilogram: Double
        let nascisStartDose: Double
        let nascisHourlyDose: Double
        var suggestedDose: String
        
        if weightTextField.text.toInt() > 0 {
            weight = weightTextField.text.toInt()!
            
            if (weightInKilogramOrPounds.selectedSegmentIndex == 0) {
                weightInKilogram = Double(weight)
            } else {
                weightInKilogram = kPoundToKilogram * Double(weight)
            }
            
            nascisStartDose = 30.0 * weightInKilogram
            nascisHourlyDose = 5.4 * weightInKilogram
            
            suggestedDose = "Drug: intravenous methylprednisolone \n\n"
            suggestedDose += String(format: "Start dose: %.0f mg \n\nHourly dose: %.0f mg/h \n\n",
                                    nascisStartDose, nascisHourlyDose)
            
            switch (timeSinceSpinalCordInjury.selectedSegmentIndex) {
                case 0:
                    suggestedDose += "Continue hourly dose for 24h in total"
                case 1:
                    suggestedDose += "Continue for 48h in total"
                case 2:
                    suggestedDose = "Outside of study criteria"
                default:
                    suggestedDose = "Please enter time since SCI"
            }
            
        } else {
            suggestedDose = "No valid weight entered"
        }
        
        suggestedDoseTextView.text = suggestedDose
        suggestedDoseTextView.hidden = false
  
    }

}

