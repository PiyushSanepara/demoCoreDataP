//
//  DisplayViewController.swift
//  DemoCoreData
//
//  Created by Ratnakala21 on 1/23/16.
//  Copyright © 2016 Ratnakala21. All rights reserved.
//

import UIKit
import CoreData

class DisplayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    let manageObjectcontext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var j_arr = NSMutableArray()
    var q_arr:[NSManagedObject]! = []

    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidAppear(animated: Bool)
    {
        
        tblView.tableFooterView = UIView()
        
        let entityDescription = NSEntityDescription.entityForName("Data", inManagedObjectContext: manageObjectcontext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
               
        do
        {
            let object = try manageObjectcontext.executeFetchRequest(request)
            
            if object.count != 0
            {
                q_arr = object as! [NSManagedObject]
                j_arr.removeAllObjects()
                
                for i in 0..<object.count
                {
                    let match = object[i] as! NSManagedObject
                    print("name:",(match.valueForKey("name")! as! String) + " contact:" + (match.valueForKey("contact")! as! String) + " standard:" + (match.valueForKey("standard")! as! String))
                    
                    let d = NSMutableDictionary()
                    
                    d.setObject(match.valueForKey("name")!, forKey: "name")
                    d.setObject(match.valueForKey("contact")!, forKey: "contact")
                    d.setObject(match.valueForKey("standard")!, forKey: "standard")
                    
                    j_arr.addObject(d)
                }
                
                tblView.reloadData()
            }
            else
            {
                print("Not Any Data")
            }
        }
        catch
        {
            fatalError("Failed to fetch person: \(error)")
        }
    }
    
    @IBAction func btn_add(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("add") as! ViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return q_arr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: DetailTableViewCell = tblView.dequeueReusableCellWithIdentifier("detailCell") as! DetailTableViewCell
        
        let metch = q_arr[indexPath.row]
        
        cell.lbl_name.text = metch.valueForKey("name")! as? String
        cell.lbl_standard.text = metch.valueForKey("standard")! as? String
        cell.lbl_contact.text = metch.valueForKey("contact")! as? String
        
        return cell
    }
    
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
//    {
//        if (editingStyle == UITableViewCellEditingStyle.Delete)
//        {
//            print("Patel Bhai")
//        }
//    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "DELETE"){(UITableViewRowAction,NSIndexPath) -> Void in
            
            print("deleted",indexPath.row)

            self.manageObjectcontext.deleteObject(self.q_arr[indexPath.row] as NSManagedObject)
            self.q_arr.removeAtIndex(indexPath.row)
            
            do
            {
                try self.manageObjectcontext.save()
                
            }
            catch
            {
                fatalError("something was wrong...!!!")
            }
            
//            self.tblView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tblView.reloadData()
        }
        let edit = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "EDIT"){(UITableViewRowAction,NSIndexPath) -> Void in
            
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("add") as! ViewController
            
            next.name = self.j_arr[indexPath.row]["name"]! as! String
            next.contact = self.j_arr[indexPath.row]["contact"]! as! String
            next.standard = self.j_arr[indexPath.row]["standard"]! as! String
            
            self.navigationController?.pushViewController(next, animated: true)
        }
        
        edit.backgroundColor = UIColor.blackColor()
        
        return [delete,edit]
    }
}
