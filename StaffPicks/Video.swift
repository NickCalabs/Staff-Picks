//
//  Video.swift
//  StaffPicks
//
//  Created by Nick on 1/12/16.
//  Copyright © 2016 com.Nickcalabro. All rights reserved.
//

import Foundation

class Video{
    
    var name: String? = ""
    var duration: Int? = 0
    var imageURLString: String? = ""
    
    init(dictionary: Dictionary<String,AnyObject>){
        self.name = dictionary["name"] as? String
        self.duration = dictionary["duration"] as? Int
        
        var pictures = dictionary["pictures"] as? Dictionary<String,AnyObject>
        if let constPictures = pictures{
            var sizes = pictures!["sizes"] as? Array<Dictionary<String,AnyObject>>
            if let constSizes = sizes{
                
                if constSizes.count > 0 {
                    var picture = constSizes[0]
                    
                    self.imageURLString = picture["link"] as? String
                }
            }
        }
    }
}