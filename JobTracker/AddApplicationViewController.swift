//
//  AddApplicationViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/15/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit
import os.log

class AddApplicationViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {


    //MARK: Properties
    
    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addWishlistButton: UIButton!
    @IBOutlet weak var dateAddButton: UIButton!
    @IBOutlet weak var pocAddButton: UIButton!
    @IBOutlet weak var locationAddButton: UIButton!
    @IBOutlet weak var addApplicationButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var jobDetailsLabel: UILabel!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
//    @IBOutlet weak var pocTextField: UITextField!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var jobApplication: JobApplication?
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        locationTextField.isHidden = true
        statusLabel.isHidden = true
        statusPicker.isHidden = true
        datePicker.isHidden = true
        dateLabel.isHidden = true
        
        pickerData = ["Applied", "Interviewed", "Decision Pending"]
        
        titleTextField.delegate = self
        companyTextField.delegate = self
        locationTextField.delegate = self
    
        self.statusPicker.delegate = self
        self.statusPicker.dataSource = self
        
        updateAddApplicationButtonState()
        
        addWishlistButton.layer.cornerRadius = 10
        addWishlistButton.clipsToBounds = true
        locationAddButton.layer.cornerRadius = 10
        locationAddButton.clipsToBounds = true
        pocAddButton.layer.cornerRadius = 10
        pocAddButton.clipsToBounds = true
        dateAddButton.layer.cornerRadius = 10
        dateAddButton.clipsToBounds = true
        addApplicationButton.layer.cornerRadius = 10
        addApplicationButton.clipsToBounds = true
        
        dateAddButton.layer.borderWidth = 2
        dateAddButton.layer.borderColor = UIColor.black.cgColor
        locationAddButton.layer.borderWidth = 2
        locationAddButton.layer.borderColor = UIColor.black.cgColor
        pocAddButton.layer.borderWidth = 2
        pocAddButton.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: PickerDelegate
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
//        addApplicationButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateAddApplicationButtonState()
//        navigationItem.title = textField.text
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === addApplicationButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let title = titleTextField.text ?? ""
        let company = companyTextField.text ?? ""
        let location = locationTextField.text ?? ""
        let poc = pickerData[statusPicker.selectedRow(inComponent: 0)]
        var date = ""
        let dateFormatter = DateFormatter()
        if(datePicker.isHidden == false) {
            dateFormatter.dateStyle = DateFormatter.Style.short
            date = dateFormatter.string(from: datePicker.date)
        }
    
        print(title, company, location, poc, date)
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        jobApplication = JobApplication(title: title, company: company, location: location, poc: poc, date: date)
//        saveApplications(jobApplication: jobApplication!)
    }
    
    //MARK: Actions
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func addDateField(_ sender: UIButton) {
        dateAddButton.isEnabled = false
        dateAddButton.backgroundColor = UIColor.lightGray
        dateLabel.isHidden = false
        datePicker.isHidden = false
    }
    
    @IBAction func addPOCField(_ sender: UIButton) {
        pocAddButton.backgroundColor = UIColor.lightGray
        pocAddButton.isEnabled = false
        statusLabel.isHidden = false
        statusPicker.isHidden = false
    }
    
    @IBAction func addLocationField(_ sender: UIButton) {
        locationAddButton.backgroundColor = UIColor.lightGray
        locationAddButton.isEnabled = false
        locationTextField.isHidden = false
    }
    
    //MARK: Private Methods
    private func updateAddApplicationButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        addApplicationButton.isEnabled = !text.isEmpty
        addWishlistButton.isEnabled = !text.isEmpty
    }
    
//    private func saveApplications(jobApplication: JobApplication) {
//        var jobApplications = loadApplications()
//        jobApplications.append(jobApplication)
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(jobApplications, toFile: JobApplication.ArchiveURL.path)
//        if isSuccessfulSave {
//            os_log("AddApplication: Applications successfully saved.", log: OSLog.default, type: .debug)
//        } else {
//            os_log("AddApplication: Failed to save applications...", log: OSLog.default, type: .error)
//        }
//    }
//
//    private func loadApplications() -> [JobApplication]? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: JobApplication.ArchiveURL.path) as? [JobApplication]
//    }

}

