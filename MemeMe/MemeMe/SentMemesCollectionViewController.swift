//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Diego Martin on 11/6/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit


class SentMemesCollectionViewController: UICollectionViewController {
    
    let reuseIdentifier = "MemeCollectionViewCell"
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()

        let space : CGFloat = 3.0
        
        // Ensure layout works for multiple screen sizes
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)

    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    
    @IBAction func unwindMemeEditorToCollection(segue: UIStoryboardSegue) {
        
    }

    // MARK: UICollectionViewDataSource

    

     override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return SentMemes.allMemes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
       
        let meme = SentMemes.allMemes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
        
            let memeDetailVC = segue.destinationViewController as? DetailViewViewController
    
            if let selectedMemeCell = sender as? MemeCollectionViewCell {
            
                let indexPath = collectionView!.indexPathForCell(selectedMemeCell)!
                let selectedMeme = SentMemes.allMemes[indexPath.row]
                memeDetailVC!.meme = selectedMeme
            }
        } else {
            
            let editorVC = segue.destinationViewController as? ViewController
            
            editorVC?.originVC = "collectionView"
        }
    }
}
