//
//  SearchOptionsViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/24/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit
import os.log

class SearchOptionsViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var searchErrorLabel: UILabel!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var deadlineField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var jobTitleField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchButton.layer.cornerRadius = 10
        searchButton.clipsToBounds = true
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
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        let status = statusField.text ?? ""
        let company = companyNameField.text ?? ""
        let location = locationField.text ?? ""
        let deadline = deadlineField.text ?? ""
        let title = jobTitleField.text ?? ""
        
        let applicationList = loadApplications()
        //        let newList = applicationList?.filter({$0.company == company})
        
        var newList = [JobApplication]()
        
        if !(status.isEmpty) {
            print("Status is filled")
            if(!(company.isEmpty) || !(location.isEmpty) || !(deadline.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
                searchErrorLabel.text = "*Only one search parameter allowed"
                return false
            }
            else {
                newList = (applicationList?.filter({($0.poc)?.lowercased() == status.lowercased()}))!
            }
            if (newList.count == 0) {
                print("No search results returned")
                searchErrorLabel.text = "No results found"
                return false
            }
        }
        
        if !(company.isEmpty) {
            print("Company is filled")
            if(!(status.isEmpty) || !(location.isEmpty) || !(deadline.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
                searchErrorLabel.text = "*Only one search parameter allowed"
                return false
            }
            else {
                newList = (applicationList?.filter({($0.company).lowercased() == company.lowercased()}))!
            }
            if (newList.count == 0) {
                print("No search results returned")
                searchErrorLabel.text = "No results found"
                return false
            }
        }
        
        if !(location.isEmpty) {
            print("Location is filled")
            if(!(company.isEmpty) || !(status.isEmpty) || !(deadline.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
                searchErrorLabel.text = "*Only one search parameter allowed"
                return false
            }
            else {
                newList = (applicationList?.filter({($0.location)?.lowercased() == location.lowercased()}))!
            }
            if (newList.count == 0) {
                print("No search results returned")
                searchErrorLabel.text = "No results found"
                return false
            }
        }
        
        if !(deadline.isEmpty) {
            print("Deadline is filled")
            if(!(company.isEmpty) || !(location.isEmpty) || !(status.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
                searchErrorLabel.text = "*Only one search parameter allowed"
                return false
            }
            else {
                newList = (applicationList?.filter({($0.date)?.lowercased() == deadline.lowercased()}))!
            }
            if (newList.count == 0) {
                print("No search results returned")
                searchErrorLabel.text = "No results found"
                return false
            }
        }
        
        if !(title.isEmpty) {
            print("Title is filled")
            if(!(company.isEmpty) || !(location.isEmpty) || !(deadline.isEmpty) || !(status.isEmpty)) {
                print("Only one search parameter allowed")
                searchErrorLabel.text = "*Only one search parameter allowed"
                return false
            }
            else {
                newList = (applicationList?.filter({($0.title).lowercased() == title.lowercased()}))!
            }
            if (newList.count == 0) {
                print("No search results returned")
                searchErrorLabel.text = "No results found"
                return false
            }
        }
        
        if(title.isEmpty && deadline.isEmpty && location.isEmpty && company.isEmpty && status.isEmpty) {
            print("Error")
            searchErrorLabel.text = "*Search Parameters cannot be empty"
            return false
        }
        searchErrorLabel.text = ""
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === searchButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let status = statusField.text ?? ""
        let company = companyNameField.text ?? ""
        let location = locationField.text ?? ""
        let deadline = deadlineField.text ?? ""
        let title = jobTitleField.text ?? ""
        
        let applicationList = loadApplications()
//        let newList = applicationList?.filter({$0.company == company})

        var newList = [JobApplication]()
        
        if !(status.isEmpty) {
            print("Status is filled")
            if(!(company.isEmpty) || !(location.isEmpty) || !(deadline.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
            }
            else {
               newList = (applicationList?.filter({($0.poc)?.lowercased() == status.lowercased()}))!
            }
        }
        
        if !(company.isEmpty) {
            print("Company is filled")
            if(!(status.isEmpty) || !(location.isEmpty) || !(deadline.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
            }
            else {
                newList = (applicationList?.filter({($0.company).lowercased() == company.lowercased()}))!
            }
        }
        
        if !(location.isEmpty) {
            print("Location is filled")
            if(!(company.isEmpty) || !(status.isEmpty) || !(deadline.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
            }
            else {
                newList = (applicationList?.filter({($0.location)?.lowercased() == location.lowercased()}))!
            }

        }
        
        if !(deadline.isEmpty) {
            print("Deadline is filled")
            if(!(company.isEmpty) || !(location.isEmpty) || !(status.isEmpty) || !(title.isEmpty)) {
                print("Only one search parameter allowed")
            }
            else {
                newList = (applicationList?.filter({($0.date)?.lowercased() == deadline.lowercased()}))!
            }

        }
        
        if !(title.isEmpty) {
            print("Title is filled")
            if(!(company.isEmpty) || !(location.isEmpty) || !(deadline.isEmpty) || !(status.isEmpty)) {
                print("Only one search parameter allowed")
            }
            else {
                 newList = (applicationList?.filter({($0.title).lowercased() == title.lowercased()}))!
            }

        }
        
        if(title.isEmpty && deadline.isEmpty && location.isEmpty && company.isEmpty && status.isEmpty) {
            print("Error")
        }
        
        print("Whole list")
        applicationList?.forEach({print($0.title, $0.company)})
        print("filtered list:")
        newList.forEach({print($0.title, $0.company)})
        
        
        
        // Create a variable that you want to send
        let destinationViewController = segue.destination as! SearchResultsTableViewController
        destinationViewController.jobApplications = newList
        
//        print(status, company, location, deadline, title)
    }
    
    //MARK: Private Methods
    
    private func loadApplications() -> [JobApplication]? {
        print(JobApplication.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: JobApplication.ArchiveURL.path) as? [JobApplication]
    }
}
