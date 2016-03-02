//
//  ToDoStatsViewController.swift
//  Capur_TODO
//
//  Created by Mingjian Lu on 3/1/16.
//  Copyright © 2016 Mapur. All rights reserved.
//

import UIKit

class ToDoStatsViewController: UIViewController {

    
    
    @IBOutlet weak var displayText: UITextView!
    var num = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayText.text = "You finished \(num) todos within recent 24 hours!"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
