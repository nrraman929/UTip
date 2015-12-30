//
//  ViewController.swift
//  Tips
//
//  Created by Nishant Raman on 12/28/15.
//  Copyright © 2015 Nishant Raman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var tipID: UILabel!
    @IBOutlet weak var totalID: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    var burntOrange = UIColor(colorLiteralRed: 191/255, green: 87/255, blue: 0, alpha: 1)
    
    //var currencyIndex: Int!
    var tipIndex = 0
    //var form = "$%.2f"
    //var sign = "$"
    
    
    func update(){
        let tipPercentage: Double
        let billAmount = NSString(string: billField.text!).doubleValue
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        switch tipControl.selectedSegmentIndex {
        case 0:
            if let one = defaults.valueForKey("one") {
                tipPercentage = (one as! NSString).doubleValue / 100
            }else { tipPercentage = 0.18 }
        case 1:
            if let two = defaults.valueForKey("two") {
                tipPercentage = (two as! NSString).doubleValue / 100
            }else { tipPercentage = 0.20 }
        case 2:
            if let three = defaults.valueForKey("three") {
                tipPercentage = (three as! NSString).doubleValue / 100
            }else { tipPercentage = 0.22 }
        default:
            if let one = defaults.valueForKey("one") {
                tipPercentage = (one as! NSString).doubleValue / 100
            }else { tipPercentage = 0.18 }
            
        }
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale() // This is the default
        signLabel.text = formatter.currencySymbol
        
        
        tipLabel.text = formatter.stringFromNumber(tip)//String(format: form, tip)
        totalLabel.text = formatter.stringFromNumber(total)//String(format: form, total)
        
        if billField.text == "" {
            /*tipLabel.hidden = true
            totalLabel.hidden = true
            tipID.hidden = true
            totalID.hidden = true
            tipControl.hidden = true*/
            UIView.animateWithDuration(0.4, animations: {
                // This causes first view to fade in and second view to fade out
                self.tipLabel.alpha = 0
                self.totalLabel.alpha = 0
                self.tipID.alpha = 0
                self.totalID.alpha = 0
                self.tipControl.alpha = 0
                self.mainView.center.y = 190
            })
        } else {
            /*tipLabel.hidden = false
            totalLabel.hidden = false
            tipID.hidden = false
            totalID.hidden = false
            tipControl.hidden = false*/
            UIView.animateWithDuration(0.4, animations: {
                // This causes first view to fade in and second view to fade out
                self.tipLabel.alpha = 1
                self.totalLabel.alpha = 1
                self.tipID.alpha = 1
                self.totalID.alpha = 1
                self.tipControl.alpha = 1
                self.mainView.center.y = 115
            })
        }
        //signLabel.text = sign
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "UTip"
        //billField?.delegate = self
     
        
        //tipLabel.text = "$0.00"
        //totalLabel.text = "$0.00"
        /*tipLabel.hidden = true
        totalLabel.hidden = true
        tipID.hidden = true
        totalID.hidden = true
        tipControl.hidden = true*/
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
        self.tipID.alpha = 0
        self.totalID.alpha = 0
        self.tipControl.alpha = 0
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("tip")
        billField.self.becomeFirstResponder()
        
        let formatter = NSNumberFormatter()
        signLabel.text = formatter.currencySymbol
        
    
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: burntOrange]
        
        self.mainView.center.y = 190
        if let objForDate = defaults.objectForKey("date"){
            let pastDate = objForDate as! NSDate
            let date = NSDate()
            let interval = Int(date.timeIntervalSinceDate(pastDate))
            if interval < 600 {
                if (defaults.valueForKey("bill") as! NSNumber) != 0 {
                    billField.text = (defaults.valueForKey("bill") as! NSNumber).stringValue
                } else { billField.text = "" }
            }
        }
        
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        update()
    }
    @IBAction func onSegmentChange(sender: AnyObject) {
        update()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        /*currencyIndex = defaults.integerForKey("currency")
        switch currencyIndex {
        case 1:
            form = "€%.2f"
            sign = "€"
        case 2:
            form = "¥%.2f"
            sign = "¥"
        default:
            form = "$%.2f"
            sign = "$"
        }*/
        
        tipIndex = defaults.integerForKey("tip")
        tipControl.selectedSegmentIndex = defaults.integerForKey("tip")
        tipControl.selectedSegmentIndex = defaults.integerForKey("tip")
        let one: String
        let two: String
        let three: String
        if let val1 = defaults.valueForKey("one") as! NSString! {
            one = val1 as String + "%"
        } else { one = "18%" }
        if let val2 = defaults.valueForKey("two") as! NSString! {
            two = val2 as String + "%"
        } else { two = "20%" }
        if let val3 = defaults.valueForKey("three") as! NSString! {
            three = val3 as String + "%"
        } else { three = "22%" }
        tipControl.setTitle(one, forSegmentAtIndex: 0)
        tipControl.setTitle(two, forSegmentAtIndex: 1)
        tipControl.setTitle(three, forSegmentAtIndex: 2)
        update()
        
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let billAmount = NSString(string: billField.text!).doubleValue
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSDate(), forKey:"date")
        defaults.setValue(billAmount, forKey: "bill")
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
}

