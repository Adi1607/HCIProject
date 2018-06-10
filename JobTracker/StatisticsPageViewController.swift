//
//  StatisticsPageViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/22/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit

class StatisticsPageViewController: UIViewController {
    
    //Mark: Properties

    @IBOutlet weak var summaryButton: UIButton!
    @IBOutlet weak var locationsButton: UIButton!
    @IBOutlet weak var deadlinesButton: UIButton!
    @IBOutlet weak var graphImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        summaryButton.layer.cornerRadius = 10
        summaryButton.clipsToBounds = true
        locationsButton.layer.cornerRadius = 10
        locationsButton.clipsToBounds = true
        deadlinesButton.layer.cornerRadius = 10
        deadlinesButton.clipsToBounds = true
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
    
    @IBAction func showDeadlinesGraph(_ sender: Any) {
        graphImageView.image = UIImage(named: "deadlinesGraph")
    }
    
    @IBAction func showLocationsGraph(_ sender: Any) {
        graphImageView.image = UIImage(named: "locationsGraph")
    }
    
    @IBAction func showSummaryGraph(_ sender: Any) {
        graphImageView.image = UIImage(named: "summaryGraph")
    }
}
