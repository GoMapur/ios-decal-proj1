//
//  ToDoListTableViewController.swift
//  Capur_TODO
//
//  Created by Mingjian Lu on 2/29/16.
//  Copyright © 2016 Mapur. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var tdList: ToDoItemList?

    @IBOutlet weak var goToStatsButton: UIBarButtonItem!
    @IBOutlet weak var goToAddButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let tdListSave = loadList() {
            tdList = tdListSave
        } else {
            // Load the sample data.
            tdList = ToDoItemList()
            tdList?.addItem("Swipe to left to delete")
            tdList?.addItem("Tap to mark as completed")
            tdList?.addItem("Get up on 7:30am")
            tdList?.addItem("CS198 project")
            tdList?.addItem("CS188 project")
            tdList?.addItem("Review Math midterm")
            tdList?.addItem("Stats hw")
            tdList?.addItem("Essay")
            tdList?.addItem("Sleep before 12:30pm")
        }
        tdList?.filterArray()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tdList?.filterArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (tdList?.ToDoItems.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItemTableViewCell", forIndexPath: indexPath) as! ToDoItemTableViewCell
        // Configure the cell...
        cell.TextField!.text! = tdList!.getItem(indexPath.row).title
        if tdList?.getItem(indexPath.row).completed == true {
            cell.backgroundColor = UIColor.orangeColor()
        } else {
            cell.backgroundColor = UIColor(hue: 0.5028, saturation: 0.67, brightness: 0.77, alpha: 0.5)
        }
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tdList?.removeItem(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: (NSIndexPath!)) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if tdList?.getItem(indexPath.row).completed == true {
            tdList?.getItem(indexPath.row).completed = false
            cell?.backgroundColor = UIColor(hue: 0.5028, saturation: 0.67, brightness: 0.77, alpha: 0.5)
        } else {
            tdList?.getItem(indexPath.row).completed = true
            cell?.backgroundColor = UIColor.orangeColor()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Stats" {
            let destVC = segue.destinationViewController as! ToDoStatsViewController
            destVC.num = tdList!.getCompletedCount()
        }
    }
    
    @IBAction func unwindToToDoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ToDoAddNewItemViewController, newItem = sourceViewController.toAdd {
            let newIndexPath = NSIndexPath(forRow: (tdList?.ToDoItems.count)!, inSection: 0)
            tdList?.addItem(newItem)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
    // MARK: NSCoding
    
    func saveList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tdList!, toFile: ToDoItemList.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadList() -> ToDoItemList? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(ToDoItemList.ArchiveURL.path!) as? ToDoItemList
    }
}
