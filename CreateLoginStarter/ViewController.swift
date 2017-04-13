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
    var loginGood: String = ""

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
        
        var jsonResult: Dictionary<String, Any> = [:]
        APIInteractions.authorizeUser(
            theURL: APIDetails.buildUrl(callType: .authenticateUser, params: [user, pass]),
            onCompletion: { (theResult: [String:Any]?) -> () in
                jsonResult = theResult!
                DispatchQueue.main.async(execute: { () -> Void in
                    
                })
                self.loginGood = jsonResult["result"] as! String
            })
        //self.loginGood = jsonResult["result"] as! String
        //if (result == "true"){
            
        //}
        //else{
            
        //}
    }
}

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignup" {
            _ = segue.destination as! SignupViewController
        }
        //else if segue.identifier == "goToMain" {
        //    _ = segue.destination as! MainScreenViewController
        //}
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "goToMain"){
            if (self.loginGood == "true"){
                return true;
            }
            else {
                let createAlert = UIAlertController(title: "Error", message: "Username/Password invalid", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                createAlert.addAction(okAction)
                
                present(createAlert, animated: true, completion: nil)
                return false
            }
        }
        return false
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "matchSegue" {
            let controller = segue.destinationViewController as! ResultViewController
            controller.match = self.match
        } else if segue.identifier == "historySegue" {
            let controller = segue.destinationViewController as! HistoryViewController
            controller.history = self.history
        }
    }
 */
}


