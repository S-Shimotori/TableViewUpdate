//
//  TableViewController.swift
//  TableViewUpdates
//
//  Created by S-Shimotori on 5/15/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private let identifier = "Cell"
    private let uiLabelText = ["にんじん","たまねぎ","じゃがいも"]
    private var useVegetables = [true, true, true]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: identifier)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !useVegetables[0] {
            //only carrot
            return 1
        } else if !useVegetables[1] {
            //carrot and onion
            return 2
        } else {
            //carrot, onion and potato
            return 3
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier(identifier) as! TableViewCell
        cell.uiLabel.text = uiLabelText[indexPath.row]
        cell.uiSwitch.on = useVegetables[indexPath.row]
        cell.uiSwitch.tag = indexPath.row
        cell.uiSwitch.addTarget(self, action: "changeUISwitchValue:", forControlEvents: .ValueChanged)
        return cell
    }
    
    func changeUISwitchValue(sender: UISwitch) {
        println("\(sender.tag) \(!sender.on)->\(sender.on)")
        
        useVegetables[sender.tag] = sender.on
        switch sender.tag {
        case 0: //carrot
            tableView.beginUpdates()
            if sender.on {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Fade)
                if useVegetables[1] {
                    tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Fade)
                }
            } else {
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Fade)
                if useVegetables[1] {
                    tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Fade)
                }
            }
            tableView.endUpdates()
        case 1: //onion
            tableView.beginUpdates()
            if sender.on {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Fade)
            } else {
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Fade)
            }
            tableView.endUpdates()
        default:
            break
        }
    }

}
