//
//  ViewController.swift
//  DemoCoreData
//
//  Created by Ratnakala21 on 1/23/16.
//  Copyright © 2016 Ratnakala21. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController
{
    @IBOutlet weak var txt_name: UITextField!
    
    @IBOutlet weak var txt_contact: UITextField!
    
    @IBOutlet weak var txt_standard: UITextField!
    
    @IBOutlet weak var btn_save: UIButton!
    
    var name = ""
    var contact = ""
    var standard = ""
    
    
    let manageObjectcontext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        if (name != "" || contact != "" || standard != "")
        {
            txt_name.text = name
            txt_contact.text = contact
            txt_standard.text = standard
            
            btn_save.setTitle("Update", forState: UIControlState.Normal)
        }
        
    }

    @IBAction func btn_add(sender: AnyObject)
    {
        
        if (name != "" || contact != "" || standard != "")
        {
            if (txt_contact.text == "" || txt_name.text == "" || txt_standard.text == "")
            {
                let alert = UIAlertView(title: "ALERT", message: "Fill Required", delegate: self, cancelButtonTitle: "Ok")
                alert.show()
            }
            else
            {
                navigationController?.popToRootViewControllerAnimated(true)
            }

        }
        else
        {
            if (txt_contact.text == "" || txt_name.text == "" || txt_standard.text == "")
            {
                let alert = UIAlertView(title: "ALERT", message: "Fill Required", delegate: self, cancelButtonTitle: "Ok")
                alert.show()
            }
            else
            {
                let entityDiscription = NSEntityDescription.entityForName("Data", inManagedObjectContext: manageObjectcontext)
                
                let data = Data(entity: entityDiscription!,
                    insertIntoManagedObjectContext: manageObjectcontext)
                
                data.name = txt_name.text
                data.contact = txt_contact.text
                data.standard = txt_standard.text
                
                do
                {
                    try manageObjectcontext.save()
                    
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                catch
                {
                    fatalError("something was wrong...!!!")
                }
            }
        }
    }
}

