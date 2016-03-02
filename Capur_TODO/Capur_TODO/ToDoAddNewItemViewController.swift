//
//  ToDoAddNewItemViewController.swift
//  Capur_TODO
//
//  Created by Mingjian Lu on 3/1/16.
//  Copyright © 2016 Mapur. All rights reserved.
//

import UIKit

class ToDoAddNewItemViewController: UIViewController {

    @IBOutlet weak var txField: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var toAdd: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancel(sender: AnyObject) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            toAdd = txField.text
        }
    }
    

}
