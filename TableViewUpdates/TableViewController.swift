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
    private var uiLabelText = ["にんじん","たまねぎ","じゃがいも"]
    private var potatoHidden = false

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
        return uiLabelText.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier(identifier) as! TableViewCell
        cell.uiLabel.text = uiLabelText[indexPath.row]
        cell.uiSwitch.tag = indexPath.row
        cell.uiSwitch.addTarget(self, action: "changeUISwitchValue:", forControlEvents: .ValueChanged)
        return cell
    }
    
    func changeUISwitchValue(sender: UISwitch) {
        println("\(sender.tag) \(!sender.on)->\(sender.on)")
        
        if sender.tag == 1 && !potatoHidden {
            //uncomment when insert/delete plural cells
            //tableView.beginUpdates()
            
            uiLabelText.removeAtIndex(2)
            let deleteIndexPaths = [NSIndexPath(forRow: 2, inSection: 0)]
            tableView.deleteRowsAtIndexPaths(deleteIndexPaths, withRowAnimation: .Fade)

            //tableView.endUpdates()
            potatoHidden = true
        }
    }

}
