//
//  SettingsViewController.swift
//  Tippie
//
//  Created by Nishant Raman on 12/29/15.
//  Copyright © 2015 Nishant Raman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var burntOrange = UIColor(colorLiteralRed: 191/255, green: 87/255, blue: 0, alpha: 1)
    
    @IBOutlet weak var oneField: UITextField!
    @IBOutlet weak var twoField: UITextField!
    @IBOutlet weak var threeField: UITextField!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: burntOrange]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "tip")
        defaults.setValue(oneField.text, forKey: "one")
        defaults.setValue(twoField.text, forKey: "two")
        defaults.setValue(threeField.text, forKey: "three")
        /*defaults.setValue(tipControl.titleForSegmentAtIndex(0), forKey: "one")
        defaults.setValue(tipControl.titleForSegmentAtIndex(1), forKey: "two")
        defaults.setValue(tipControl.titleForSegmentAtIndex(2), forKey: "three")*/
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("tip")
        let one: String
        let two: String
        let three: String
        if let val1 = defaults.valueForKey("one") as! NSString! {
            one = val1 as String
        } else {
            one = "18"
        }
        if let val2 = defaults.valueForKey("two") as! NSString! {
            two = val2 as String
        } else
        {
            two = "20"
        }
        if let val3 = defaults.valueForKey("three") as! NSString! {
            three = val3 as String
        } else {
            three = "22"
        }
        tipControl.setTitle(one + "%", forSegmentAtIndex: 0)
        tipControl.setTitle(two + "%", forSegmentAtIndex: 1)
        tipControl.setTitle(three + "%", forSegmentAtIndex: 2)
        oneField.text = one
        twoField.text = two
        threeField.text = three
        /*tipControl.setTitle(defaults.valueForKey("one") as! NSString as String, forSegmentAtIndex: 0)
        tipControl.setTitle(defaults.valueForKey("two") as! NSString as String, forSegmentAtIndex: 1)
        tipControl.setTitle(defaults.valueForKey("three") as! NSString as String, forSegmentAtIndex: 2)*/
        self.view.backgroundColor = UIColor.lightGrayColor()
    }
    
    @IBAction func onOneEditChanged(sender: AnyObject) {
        let oneTitle = oneField.text! + "%"
        tipControl.setTitle(oneTitle, forSegmentAtIndex: 0)
    }
    
    @IBAction func onTwoEditChanged(sender: AnyObject) {
        let twoTitle = twoField.text! + "%"
        tipControl.setTitle(twoTitle, forSegmentAtIndex: 1)
    }
    
    @IBAction func onThreeEditChanged(sender: AnyObject) {
        let threeTitle = threeField.text! + "%"
        tipControl.setTitle(threeTitle, forSegmentAtIndex: 2)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
