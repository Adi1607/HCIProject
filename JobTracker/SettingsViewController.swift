//
//  SettingsViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/30/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation


    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
