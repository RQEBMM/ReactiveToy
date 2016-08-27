//
//  ViewController.swift
//  ReactiveToy
//
//  Created by Benjamin McCloskey on 8/20/16.
//  Copyright © 2016 AB. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    lazy var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

