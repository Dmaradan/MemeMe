//
//  DetailViewViewController.swift
//  MemeMe
//
//  Created by Diego Martin on 11/16/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var detailView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        
        detailView.image = meme.memedImage
    }
}
