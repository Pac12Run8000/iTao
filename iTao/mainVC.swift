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
    // 103:11 in tutorial
    @IBAction func addImages(sender: AnyObject) {
    }
    
    @IBAction func addImagesFromCamera(sender: AnyObject) {
        
    }
    @IBAction func btnCancelTapped(sender: AnyObject) {
        dismissVC()
    }
    @IBAction func btnSaveTapped(sender: AnyObject) {
        if (nItem != nil) {
            self.editItem()
        } else {
            self.newItem()
        }
        dismissVC()
    }
    
    func dismissVC() {
        navigationController?.popViewControllerAnimated(true)
    }
    func newItem() {
        do {
        let context = self.context
        let ent = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        let sItem = List(entity:ent!, insertIntoManagedObjectContext:context)
        sItem.lTitle = txtTitleOutlet.text
        sItem.lDesc = txtDescriptionOutlet.text
        try context.save()
        } catch {
            print(error)
        }
    }
    
    func editItem() {
        do {
        nItem?.lTitle = self.txtTitleOutlet.text
        nItem?.lDesc = self.txtDescriptionOutlet.text
        try context.save()
        } catch {
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgSnapshot.layer.cornerRadius = 5
        self.imgSnapshot.layer.borderWidth = 3
        self.txtDescriptionOutlet.layer.cornerRadius = 5
        self.txtDescriptionOutlet.layer.borderWidth = 1
        
        if (nItem != nil) {
            self.txtTitleOutlet.text = nItem?.lTitle
            self.txtDescriptionOutlet.text = nItem?.lDesc
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

