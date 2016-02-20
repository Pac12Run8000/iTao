//
//  tableVC.swift
//  iTao
//
//  Created by MIchelle Grover on 2/16/16.
//  Copyright © 2016 Norbert Grover. All rights reserved.
//

import UIKit
import CoreData

class tableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    let context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    func getFrc() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "List")
        let sortDescriptor = NSSortDescriptor(key: "lTitle", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    // This reloads the tableview to see the new data added
    // You can do the same thing with view did appear
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            frc = getFrc()
            frc.delegate = self
        try frc.performFetch()
        } catch {
            print(error)
            return
        }
        self.tableView.rowHeight = 60
        
        //self.tableView.backgroundView = UIImageView(image: UIImage(named: "orange-bg"))
        //self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberofsections = (frc.sections?.count)!
        return numberofsections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = frc.sections![section].numberOfObjects
        return numberOfRowsInSection
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let myList = frc.objectAtIndexPath(indexPath) as! List
        cell.textLabel?.text = myList.lTitle
        cell.detailTextLabel?.text = myList.lDesc
        
        if (indexPath.row % 2 == 0) {
                cell.backgroundColor = UIColor.clearColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        }
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.detailTextLabel?.textColor = UIColor.darkGrayColor()
        if (myList.lImage != nil) {
            
            
            
            cell.imageView?.image = UIImage(data: (myList.lImage)!)
            cell.imageView?.layer.cornerRadius = 20
            cell.imageView?.layer.borderWidth = 1
            //cell.imageView?.layer.cornerRadius = ((cell.imageView?.frame.size.height)! / 2)
            cell.imageView?.clipsToBounds = true
            
        
        }
        //cell.imageView?.image = UIImage(data: (myList.lImage)!)
        return cell
    }
    
    func roundImage(image: UIImage, toTheSize size: CGSize) -> UIImage {
        let scale = CGFloat(max(size.width/image.size.width, size.height/image.size.height))
        let width:CGFloat = image.size.width * scale
        let height:CGFloat = image.size.height * scale
        
        let rr:CGRect = CGRectMake(0, 0, width, height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.drawInRect(rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        do {
            let managedObject:NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
            context.deleteObject(managedObject)
            try context.save() } catch {
                print(error)
                return
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath)
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "edit") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController:mainVC = segue.destinationViewController as! mainVC
            let nItem:List = frc.objectAtIndexPath(indexPath!) as! List
            itemController.nItem = nItem
        }
    }
    

}
