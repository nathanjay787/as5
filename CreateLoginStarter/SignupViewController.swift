//
//  SignupViewController.swift
//  CreateLoginStarter
//
//  Created by Jasiukajc, Nathan on 2017-04-12.
//  Copyright © 2017 Chris. All rights reserved.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    
    let regexRepository = [
        "email": "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
        "username": "^[a-z0-9]{1,64}$",
        "password": "^.{8,32}$"
    ]
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    let errorMsg = "The following field(s) are not in the correct format: "
    
    var params = ["userName": ["display": "Username", "value": "", "status": false],
                  "email": ["display": "Email", "value": "", "status": false],
                  "passWord": ["display": "Password", "value": "", "status": false],
                  "passConfirm": ["display": "Confirm Password", "value": "", "status": false]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: Any) {
        var formGood = true
        params["userName"]!["value"] = usernameField.text!
        params["email"]!["value"] = emailField.text!
        params["passWord"]!["value"] = passwordField.text!
        params["passConfirm"]!["value"] = confirmField.text!
        
        params["userName"]!["status"] = testRegexMatch(regexFor: "username", text: params["userName"]!["value"] as! String)
        params["email"]!["status"] = testRegexMatch(regexFor: "email", text: params["email"]!["value"] as! String)
        params["passWord"]!["status"] = testRegexMatch(regexFor: "password", text: params["passWord"]!["value"] as! String)
        params["passConfirm"]!["status"] = (params["passWord"]!["value"] as! String == params["passConfirm"]!["value"] as! String ? true : false)
        
        var errorToAdd = ""
        
        for (field, data) in params {
            if (data["status"] as! Bool == false){
                formGood = false
                if (errorToAdd != ""){
                    errorToAdd += ", "
                }
                errorToAdd += data["display"] as! String
            }
        }
        
        let finalError = errorMsg + errorToAdd
        
        if (formGood){
            accessAPI()
        }
        else {
            let createAlert = UIAlertController(title: "Error", message: finalError, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            createAlert.addAction(okAction)

            present(createAlert, animated: true, completion: nil)
        }
    }
    
}

extension SignupViewController {
    func testRegexMatch(regexFor: String, text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regexRepository[regexFor]!, options: [])
            let nsString = NSString(string: text)
            let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: nsString.length))
            return results.count > 0
        }
        catch {
            return false
        }
    }
}

extension SignupViewController {
    func accessAPI() {
        
    }
}
