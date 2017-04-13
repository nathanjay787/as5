//
//  ViewController.swift
//  CreateLoginStarter
//
//  Created by Chris on 2017-03-29.
//  Copyright © 2017 Chris. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    var created: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func tryLogin(_ sender: Any) {
        let user = userNameField.text!
        let pass = passwordField.text!
        let baseErr = "Do not leave the following field(s) blank: "
        var addErr = ""
        
        if (user == "" || pass == ""){
            if (user == ""){
                addErr = "Username"
            }
            if (pass == ""){
                if (addErr == ""){
                    addErr = "Password"
                }
                else {
                    addErr += ", Password"
                }
            }
            let createAlert = UIAlertController(title: "Error", message: baseErr + addErr, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            createAlert.addAction(okAction)
            self.present(createAlert, animated: true, completion: nil)
        }
        else {
            APIInteractions.authorizeUser(
                theURL: APIDetails.buildUrl(callType: .authenticateUser, params: [user, pass]),
                onCompletion: { (theResult: [String:Any]?) -> () in
                    var resultStatus = ""
                    DispatchQueue.main.async(execute: { () -> Void in
                        resultStatus = theResult!["result"] as! String

                        if (resultStatus == "true"){
                            self.performSegue(withIdentifier: "goToMain", sender: self)
                        }
                        else {
                            let createAlert = UIAlertController(title: "Error", message: "Username/Password invalid", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            createAlert.addAction(okAction)
                            self.present(createAlert, animated: true, completion: nil)
                        }
                    })
            })
        }
    }
    @IBAction func makeAccount(_ sender: Any) {
        performSegue(withIdentifier: "goToSignup", sender: self)
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToSignup"){
            let nextVC = segue.destination as! SignupViewController
            nextVC.newUser = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.created == true){
            self.created = false
            let createAlert = UIAlertController(title: "Success", message: "Account Created", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            createAlert.addAction(okAction)
            self.present(createAlert, animated: true, completion: nil)
        }
    }
}

