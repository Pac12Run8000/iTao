//
//  mainVC.swift
//  iTao
//
//  Created by MIchelle Grover on 2/16/16.
//  Copyright © 2016 Norbert Grover. All rights reserved.
//

import UIKit
import CoreData


class mainVC: UIViewController {
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var nItem : List? = nil
    

    @IBOutlet weak var txtDescriptionOutlet: UITextView!
    @IBOutlet weak var imgSnapshot: UIImageView!
    @IBOutlet weak var txtTitleOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgSnapshot.layer.cornerRadius = 5
        self.txtDescriptionOutlet.layer.cornerRadius = 5
        if (nItem != nil) {
            self.txtTitleOutlet.text = nItem?.lTitle
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

