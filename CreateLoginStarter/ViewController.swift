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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let theNextVC = segue.destination as! SignupViewController
        
    //    theNextVC.objectToSaveTo = self
        
    //    if let indexPath = self.tableView.indexPathsForSelectedRows?[0] {
    //        theNextVC.theContact = self.thePhoneBook[indexPath.row]
    //        theNextVC.indexOfContact = indexPath.row
    //    }
    }
}


