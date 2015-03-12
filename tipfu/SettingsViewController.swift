//
//  SettingsViewController.swift
//  tipfu
//
//  Created by DeVaris Brown on 3/3/15.
//  Copyright (c) 2015 Furious One. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let tips = [18, 20, 22]
    var userDefaults : NSUserDefaults?
    let defaultTip: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        
        userDefaults = NSUserDefaults.standardUserDefaults()
        let tipVal = userDefaults?.integerForKey("defaultTip")
        for (index,tmp) in enumerate(tips) {
            if(tipVal == tmp){
                tipControl.selectedSegmentIndex = index
                let currTip = tips[tipControl.selectedSegmentIndex]
                self.tipLabel.text = "Default tip is \(currTip)%"
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "TipFu"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        let currTip = tips[tipControl.selectedSegmentIndex]
        self.tipLabel.text = "Default tip is \(currTip)%"
        userDefaults?.setInteger(currTip, forKey: "defaultTip")
        userDefaults?.synchronize()
    }
}
