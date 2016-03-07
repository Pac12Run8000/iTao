//
//  mainVC.swift
//  iTao
//
//  Created by MIchelle Grover on 2/16/16.
//  Copyright © 2016 Norbert Grover. All rights reserved.
//

import UIKit
import CoreData



class mainVC: UIViewController, NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var nItem : List? = nil
    

    @IBOutlet weak var txtDescriptionOutlet: UITextView!
    @IBOutlet weak var imgSnapshot: UIImageView!
    @IBOutlet weak var txtTitleOutlet: UITextField!
    // 103:11 in tutorial
    @IBAction func addImages(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pickerController.allowsEditing = true
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.imgSnapshot.image = image
    }
    
    @IBAction func addImagesFromCamera(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        pickerController.allowsEditing = true
        self.presentViewController(pickerController, animated: true, completion: nil)
        
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
        
        let context = self.context
        let ent = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        let sItem = List(entity:ent!, insertIntoManagedObjectContext:context)
        sItem.lTitle = txtTitleOutlet.text
        sItem.lDesc = txtDescriptionOutlet.text
        if (self.imgSnapshot.image != nil) {
        sItem.lImage = UIImagePNGRepresentation(self.imgSnapshot.image!)
        }
        do {
        try context.save()
        } catch {
            print(error)
            return
        }
    }
    
    func editItem() {
        
        nItem?.lTitle = self.txtTitleOutlet.text
        nItem?.lDesc = self.txtDescriptionOutlet.text
        if (self.imgSnapshot.image != nil) {
            nItem?.lImage = UIImagePNGRepresentation(self.imgSnapshot.image!)
        }
        do {
        try context.save()
        } catch {
            print(error)
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgSnapshot.layer.cornerRadius = 9
        self.imgSnapshot.clipsToBounds = true
        self.imgSnapshot.layer.borderWidth = 3
        self.txtDescriptionOutlet.layer.cornerRadius = 5
        self.txtDescriptionOutlet.layer.borderWidth = 1
       
        
        if (nItem != nil) {
            self.txtTitleOutlet.text = nItem?.lTitle
            self.txtDescriptionOutlet.text = nItem?.lDesc
            if (nItem?.lImage != nil) {
                self.imgSnapshot.image = UIImage(data: (nItem?.lImage)!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

