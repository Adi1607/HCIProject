//
//  SearchResultsTableViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/27/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit
import os.log

class SearchResultsTableViewController: UITableViewController {
    
//    var programVar = String()
    var jobApplications = [JobApplication]()
    var segueFromEditApp = false
    
    
    @IBOutlet weak var ka: UIButton!
    @IBOutlet weak var k: UIButton!
    func createFloatingButton() {
        self.ka = UIButton(type: .custom)
        self.ka.setTitleColor(UIColor.orange, for: .normal)
        
        self.navigationController?.view.addSubview(ka)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Loaded")
        print("Here")
        jobApplications.forEach({print($0.title, $0.company)})
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(segueFromEditApp == true) {
            let alert = UIAlertController(title: "Success", message: "Your application has been edited!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            //            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            segueFromEditApp = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobApplications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchResultTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchResultTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SearchResultTableViewCell.")
        }

        let jobApplication = jobApplications[indexPath.row]
        cell.companyLabel.text = jobApplication.company
        cell.titleLabel.text = jobApplication.title

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let editApplicationSearchViewController = segue.destination as? EditApplicationSearchViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedApplicationCell = sender as? SearchResultTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedApplicationCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedApplication = jobApplications[indexPath.row]
            editApplicationSearchViewController.jobApplication = selectedApplication
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
 
    
    //MARK: Actions
    @IBAction func unwindToApplicationList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EditApplicationSearchViewController, let jobApplication = sourceViewController.jobApplication {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                jobApplications[selectedIndexPath.row] = jobApplication
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            // Save the meals.
            saveApplications()
            segueFromEditApp = true
        }
    }

    @IBAction func filter(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Refine your Search", message: "Enter the search term to filter by", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "eg: Software Engineer Intern"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Filter", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print("Text field: \(textField?.text)")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
//    @IBAction func back(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
    //MARK: Private Methods
    
    private func saveApplications() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(jobApplications, toFile: JobApplication.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Table: Applications successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Table: Failed to save applications...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadApplications() -> [JobApplication]? {
        print(JobApplication.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: JobApplication.ArchiveURL.path) as? [JobApplication]
    }



}
