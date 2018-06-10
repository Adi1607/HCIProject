//
//  EditApplicationSearchViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/29/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit
import os.log

class EditApplicationSearchViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var jobApplication: JobApplication?
    var pickerData: [String] = [String]()
    //MARK: Properties
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerData = ["Applied", "Interviewed", "Decision Pending"]

        locationTextField.delegate = self
        self.statusPicker.delegate = self
        self.statusPicker.dataSource = self
        
        print(jobApplication?.title, jobApplication?.company, jobApplication?.poc, jobApplication?.location, jobApplication?.date)
        titleLabel.text = jobApplication?.title ?? ""
        companyLabel.text = jobApplication?.company ?? ""
        if(jobApplication?.poc != "") {
            let indexOfA = pickerData.index(of: (jobApplication?.poc)!)
            statusPicker.selectRow(indexOfA!, inComponent:0, animated:true)
        }
        if(jobApplication?.location != "") {
            locationTextField.text = jobApplication?.location
        }
        //        let dateFormatter = DateFormatter()
        //        if(jobApplication?.date != nil) {
        //            let date = dateFormatter.date(from: (jobApplication?.date)!)
        //            datePicker.date = date!
        //        }
        
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        // Do any additional setup after loading the view.
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

    
    // MARK: - Navigation

    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let title = jobApplication?.title ?? ""
        let company = jobApplication?.company ?? ""
        let location = locationTextField.text ?? ""
        let status = pickerData[statusPicker.selectedRow(inComponent: 0)]
        let date = jobApplication?.date ?? ""
        //        var date = ""
        //        let dateFormatter = DateFormatter()
        //        if(datePicker.isHidden == false) {
        //            dateFormatter.dateStyle = DateFormatter.Style.short
        //            date = dateFormatter.string(from: datePicker.date)
        //        }
        
        print(title, company, location, status, date)
        
        jobApplication = JobApplication(title: title, company: company, location: location, poc: status, date: date)
    }

}
