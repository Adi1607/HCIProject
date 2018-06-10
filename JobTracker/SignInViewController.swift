//
//  SignInViewController.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/25/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var my_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        my_button.layer.borderWidth = 2.8;
        my_button.layer.borderColor = UIColor.white.cgColor;
        my_button.layer.cornerRadius = 8;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
     
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if(usernameField.text == "" || passwordTextField.text == ""){
            errorLabel.text = "*Please enter valid login credentials"
            return false
        }
        errorLabel.text = ""
        return true
    }

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
