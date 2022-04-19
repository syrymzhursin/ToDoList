//
//  Model.swift
//  ToDoList
//
//  Created by User on 7/6/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

var toDoList: [[String: Any]]  {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return array
        }
        else {
            return []
        }
        
    }
}

func addItem(nameItem: String, dateItem: String, isCompleted: Bool = false) {
    toDoList.append(["Name": nameItem, "Date": dateItem, "isCompleted": false])
    setBadges()
    
}

func removeItem(at index: Int) {
    toDoList.remove(at: index)
    setBadges()
}

func changeState(at item: Int) -> Bool {
    toDoList[item]["isCompleted"] = !(toDoList[item]["isCompleted"] as! Bool)
    setBadges()
    return toDoList[item]["isCompleted"] as! Bool
}

func moveItem(fromIndex: Int, toIndex: Int)  {
     let from = toDoList[fromIndex]
    toDoList.remove(at: fromIndex)
           toDoList.insert(from, at: toIndex)

}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled {
            print("Agreed")
        }
        else {
            print("Disagreed")
        }
    }
    
}

func setBadges() {
    var totalBadgeNumber = 0
    for item in toDoList {
        if (item["isCompleted"] as? Bool) == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}

