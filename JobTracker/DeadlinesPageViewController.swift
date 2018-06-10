//
//  DeadlinesPageViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/24/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit

class DeadlinesPageViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var appliedLabel: UILabel!
    @IBOutlet weak var interviewedLabel: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let applicationList = loadApplications()
        let appliedList = applicationList?.filter({$0.poc == "Applied"})
        let pendingList = applicationList?.filter({$0.poc == "Decision Pending"})
        let interviewedList = applicationList?.filter({$0.poc == "Interviewed"})
        
        appliedLabel.text = "Applied: " + String(describing: (appliedList?.count)!)
        pendingLabel.text = "Decision Pending: " + String(describing: (pendingList?.count)!)
        interviewedLabel.text = "Interviewed: " + String(describing: (interviewedList?.count)!)
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
    
    //MARK: Private Methods
    
    private func loadApplications() -> [JobApplication]? {
        print(JobApplication.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: JobApplication.ArchiveURL.path) as? [JobApplication]
    }

}
