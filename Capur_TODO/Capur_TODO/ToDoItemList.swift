//
//  ToDoItem.swift
//  Capur_TODO
//
//  Created by Mingjian Lu on 2/21/16.
//  Copyright © 2016 Mapur. All rights reserved.
//

import UIKit

class ToDoItemList: NSObject, NSCoding {
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("ToDoItemList")
    
    class ToDoItem: NSObject {
        static var count = 0
        var id:Int
        var title: String
        var completed: Bool
        var startTime: NSDate
        var endTime: NSDate?
        init(title: String) {
            id = ToDoItem.count
            ToDoItem.count += 1
            self.title = title
            completed = false
            startTime = NSDate()
        }
    }
    
    var ToDoItems: [ToDoItem]
    
    override init() {
        ToDoItems = [ToDoItem]()
    }
    
    func addItem(tt: String) {
        ToDoItems.append(ToDoItem(title: tt))
    }
    
    func removeItem(rowNumber: Int) {
        ToDoItems.removeAtIndex(rowNumber)
    }
    
    func getItem(index: Int) -> ToDoItem {
        return ToDoItems[index]
    }
    
    func filterArray() {
        let constraintsTime = NSDate(timeIntervalSinceNow: -24*60*60)
        ToDoItems = ToDoItems.filter() {
            let item = $0 as? ToDoItem
            return item!.startTime.earlierDate(constraintsTime) == constraintsTime
        }
    }
    
    func getCompletedCount() -> Int {
        var count = 0
        for i in ToDoItems {
            if i.completed {
                count += 1
            }
        }
        return count
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(ToDoItems, forKey: "ToDoItemList")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        ToDoItems = aDecoder.decodeObjectForKey("ToDoItemList") as! [ToDoItem]
        if ToDoItems.count != 0 {
            ToDoItem.count = ToDoItems.last!.id
        }
    }
}
