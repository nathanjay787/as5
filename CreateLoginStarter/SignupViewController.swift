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
    let emptyMsg = "Do not leave the following field(s) blank: "
    
    var params = ["userName": ["display": "Username", "value": "", "status": false],
                  "email": ["display": "Email", "value": "", "status": false],
                  "passWord": ["display": "Password", "value": "", "status": false],
                  "passConfirm": ["display": "Confirm Password", "value": "", "status": false]
    ]
    
    var newUser: ViewController!
    
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
        var noEmpties = true
        
        params["userName"]!["value"] = usernameField.text!
        params["email"]!["value"] = emailField.text!
        params["passWord"]!["value"] = passwordField.text!
        params["passConfirm"]!["value"] = confirmField.text!
        
        params["userName"]!["status"] = testRegexMatch(regexFor: "username", text: params["userName"]!["value"] as! String)
        params["email"]!["status"] = testRegexMatch(regexFor: "email", text: params["email"]!["value"] as! String)
        params["passWord"]!["status"] = testRegexMatch(regexFor: "password", text: params["passWord"]!["value"] as! String)
        params["passConfirm"]!["status"] = (params["passWord"]!["value"] as! String == params["passConfirm"]!["value"] as! String ? true : false)
        
        var errorToAdd = ""
        var emptiesToAdd = ""
        
        for (_, data) in params {
            if (data["status"] as! Bool == false){
                formGood = false
                if (errorToAdd != ""){
                    errorToAdd += ", "
                }
                errorToAdd += data["display"] as! String
            }
            if (data["value"] as! String == ""){
                noEmpties = false
                formGood = false
                if (emptiesToAdd != ""){
                    emptiesToAdd += ", "
                }
                emptiesToAdd += data["display"] as! String
            }
        }
        
        let finalError = errorMsg + errorToAdd
        let finalEmpty = emptyMsg + emptiesToAdd
        
        if (formGood){
            accessAPI()
        }
        else if (!noEmpties){
            let createAlert = UIAlertController(title: "Error", message: finalEmpty, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            createAlert.addAction(okAction)
            
            present(createAlert, animated: true, completion: nil)
        }
        else if (params["passConfirm"]!["status"] as! Bool == false){
            let createAlert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            createAlert.addAction(okAction)
            
            present(createAlert, animated: true, completion: nil)
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
        let user = params["userName"]!["value"] as! String
        let pass = params["passWord"]!["value"] as! String
        let email = params["email"]!["value"] as! String
        APIInteractions.addAccount(
                                passWord: pass, userName: user, email: email,
                                theURL: APIDetails.buildUrl(callType: .addUser, params: []),
                                onCompletion: { (theResult: [String:Any]?) -> () in
                                    var resultStatus = ""
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        resultStatus = theResult!["result"] as! String
                                        
                                        if (resultStatus == "true"){
                                            self.newUser.created = true
                                            if let navController = self.navigationController {
                                                navController.popViewController(animated: true)
                                            }
                                        }
                                        else {
                                            let createAlert = UIAlertController(title: "Error", message: "Could not create user account", preferredStyle: .alert)
                                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                            createAlert.addAction(okAction)
                                            self.present(createAlert, animated: true, completion: nil)
                                        }
                                    })
        })
    }
}
