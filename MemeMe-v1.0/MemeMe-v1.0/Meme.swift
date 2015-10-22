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
    
    init(topText: String, bottomText: String, originalImage: UIImage, newImage: UIImage){
        top = topText
        bottom = bottomText
        image = originalImage
        memedImage = newImage
    }
}