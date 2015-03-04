//
//  TipViewController.swift
//  tipfu
//
//  Created by DeVaris Brown on 3/3/15.
//  Copyright (c) 2015 Furious One. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    var userDefaults : NSUserDefaults?
    let tips = [ 18, 20, 22]
    var defaultTip : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .Done, target: self, action: "didTapSettings:")
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        defaultTip = userDefaults?.integerForKey("defaultTip")
        
        for (index,tmp) in enumerate(tips) {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "TipFu"
        
        defaultTip = userDefaults?.integerForKey("defaultTip")
        
        for (index,tmp) in enumerate(tips) {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
        onEditingChanged(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didTapSettings(sender: AnyObject)
    {
        var settingsViewController = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let bill = (amountLabel.text as NSString).doubleValue
        let total = bill + bill * (Double(tips[tipControl.selectedSegmentIndex])/100)
        
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        tipLabel.text = formatter.stringFromNumber(bill * Double(tips[tipControl.selectedSegmentIndex])/100)
        totalLabel.text = formatter.stringFromNumber(total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
