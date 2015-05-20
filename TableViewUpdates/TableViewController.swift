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
    let animation = UITableViewRowAnimation.Fade
    
    //NSUserDefaults should retain these data
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
        println("\(sender.tag)")
        
        if useVegetables[sender.tag] != sender.on {
            println("\(!sender.on)->\(sender.on)")
            useVegetables[sender.tag] = sender.on
        
            func operateTableView(forRow: Int) {
                let indexPaths = [NSIndexPath(forRow: forRow, inSection: 0)]
            
                if sender.on {
                    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
                } else {
                    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
                }
            }
        
            switch sender.tag {
            case 0: //carrot
                tableView.beginUpdates()
                operateTableView(1)
                if useVegetables[1] {
                    operateTableView(2)
                }
                tableView.endUpdates()
            case 1: //onion
                tableView.beginUpdates()
                operateTableView(2)
                tableView.endUpdates()
            default:
                break
            }
        }
    }

}
