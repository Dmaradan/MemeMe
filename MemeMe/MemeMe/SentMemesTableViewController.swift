//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Diego Martin on 11/16/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    let reuseIdentifier = "MemeTableViewCell"
    var isEditing: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableView!.reloadData()
    }
    
    @IBAction func unwindMemeEditor(segue: UIStoryboardSegue) {
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SentMemes.allMemes.count
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeTableViewCell

        // Configure the cell...
        
        let meme = SentMemes.allMemes[indexPath.row]

        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    // MARK: Delegate methods
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
        
            let memeDetailVC = segue.destinationViewController as? DetailViewViewController
        
            if let selectedMemeCell = sender as? MemeTableViewCell {
            
                let indexPath = tableView.indexPathForCell(selectedMemeCell)!
                let selectedMeme = SentMemes.allMemes[indexPath.row]
                memeDetailVC!.meme = selectedMeme
            }
        } else {
            
            let editorVC = segue.destinationViewController as? ViewController
            
            editorVC?.originVC = "tableView"
        }

    }
    
     // Override to support deleting from the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            SentMemes.delete(atIndex: indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
