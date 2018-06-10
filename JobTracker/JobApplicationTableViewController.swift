//
//  JobApplicationTableViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/15/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit
import os.log

class JobApplicationTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var jobApplications = [JobApplication]()
    var segueFromAddApp = false
    var segueFromEditApp = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load any saved meals, otherwise load sample data.
        if let savedApplications = loadApplications() {
            print("Found saved applications")
            jobApplications += savedApplications
        }
        else {
            // Load the sample data.
            print("Could not find saved applications")
            loadSampleJobApplications()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(segueFromAddApp == true) {
            let alert = UIAlertController(title: "Success", message: "Your application has been saved!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            //            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            segueFromAddApp = false
        }
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobApplications.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "JobApplicationTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? JobApplicationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of JobApplicationTableViewCell.")
        }
        
        let jobApplication = jobApplications[indexPath.row]
        cell.titleLabel.text = jobApplication.title
        cell.companyLabel.text = jobApplication.company
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    

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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.jobApplications.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(self.jobApplications)
            self.saveApplications()
        }
        
//        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
//            // share item at indexPath
//            print("To edit: \(self.jobApplications[indexPath.row])")
//        }
//
//        edit.backgroundColor = UIColor.lightGray
        
        return [delete]//, edit]
        
    }

    // MARK: - Navigation

     @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }
    
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let editApplicationViewController = segue.destination as? EditApplicationViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedApplicationCell = sender as? JobApplicationTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedApplicationCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedApplication = jobApplications[indexPath.row]
            editApplicationViewController.jobApplication = selectedApplication
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToApplicationList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddApplicationViewController, let jobApplication = sourceViewController.jobApplication {
            // Add a new meal.
            print("Here")
            let newIndexPath = IndexPath(row: jobApplications.count, section: 0)
            jobApplications.append(jobApplication)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            saveApplications()
            segueFromAddApp = true
        }
        if let sourceViewController = sender.source as? EditApplicationViewController, let jobApplication = sourceViewController.jobApplication {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                jobApplications[selectedIndexPath.row] = jobApplication
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            segueFromEditApp = true
            // Save the meals.
            saveApplications()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleJobApplications() {
        let jobApplication1 = JobApplication(title: "Software Engineer", company: "Microsoft", location: "San Francisco", poc: "Applied", date: "8/27/2018")
        
        let jobApplication2 = JobApplication(title: "Software Engineer", company: "Google", location: "San Francisco", poc: "Interviewed", date: "4/14/2018")
        
        jobApplications += [jobApplication1, jobApplication2]
        saveApplications()
    }
    
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
