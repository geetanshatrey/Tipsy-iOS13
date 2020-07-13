//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var tipValue: Double = 0.0
    var finalTotal: Double = 0.0
    var splitTotal: Double = 0.0
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        if sender.currentTitle == "0%" {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }
        else if sender.currentTitle == "10%" {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
        }
        else if sender.currentTitle == "20%" {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if zeroPctButton.isSelected == true {
            let tip = zeroPctButton.currentTitle!
            tipValue = Double(tip.dropLast()) ?? 0.0
        }
        else if tenPctButton.isSelected == true {
            let tip = tenPctButton.currentTitle!
            tipValue = Double(tip.dropLast()) ?? 0.0
        }
        else {
            let tip = twentyPctButton.currentTitle!
            tipValue = Double(tip.dropLast()) ?? 0.0
        }
        tipValue = tipValue / 100
        
        if let totalCost = Double(billTextField.text!) {
            finalTotal = totalCost + tipValue * totalCost
            let splitNumber = Double(splitNumberLabel.text!)
            splitTotal = finalTotal / splitNumber!
            self.performSegue(withIdentifier: "segueFromCalculatorToResults", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromCalculatorToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalValue = String(format: "%.2f", splitTotal)
            destinationVC.totalTipStatement = "Split between \(splitNumberLabel.text!) people, with \(tipValue*100) tip."
        }
    }
    
}

