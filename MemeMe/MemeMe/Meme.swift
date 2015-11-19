//
//  Meme.swift
//  MemeMe-v1.0
//
//  Created by Diego Martin on 10/19/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var top: String
    var bottom: String
    var image: UIImage
    var memedImage: UIImage
}

struct SentMemes {
    
        /* Get all memes from our app delegate */
    static var allMemes: [Meme] {
        return getMemeArray().memes
    }
    
    static func getMemeArray() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    static func add(meme: Meme) {
        getMemeArray().memes.append(meme)
    }
}