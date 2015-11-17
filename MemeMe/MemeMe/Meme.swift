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
    
//    static var allMemes: [Meme] {
//        
//        var memeArray = [Meme]()
//        
//        for m in SentMemes.getMemeArray().memes {
//            memeArray.append(m)
//        }
//        
//        return memeArray
//    }

    
    init(topText: String, bottomText: String, originalImage: UIImage, newImage: UIImage){
        top = topText
        bottom = bottomText
        image = originalImage
        memedImage = newImage
    }
}

//extension Meme {
//    
//    //This extension adds static variable allMemes. An array of Meme objects
//
//    static var allMemes: [Meme] {
//            
//        var memeArray = [Meme]()
//            
//        for m in SentMemes.getMemeArray().memes {
//            memeArray.append(m)
//        }
//            
//        return memeArray
//    }
//}

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