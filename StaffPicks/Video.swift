//
//  Video.swift
//  StaffPicks
//
//  Created by Nick on 1/12/16.
//  Copyright © 2016 com.Nickcalabro. All rights reserved.
//

import Foundation
import UIKit

class Video{
    
    var name: String? = ""
    var duration: String?
    var imageURLString: String? = ""
    
    init(dictionary: Dictionary<String,AnyObject>){
        self.name = dictionary["name"] as? String
        
        let duration = dictionary["duration"] as? Int ?? 0
        self.duration = self.formattedDuration(duration)
        
        var pictures = dictionary["pictures"] as? Dictionary<String,AnyObject>
        if let constPictures = pictures{
            var sizes = pictures!["sizes"] as? Array<Dictionary<String,AnyObject>>
            if let constSizes = sizes{
                
                if constSizes.count > 0 {
                    //var picture = constSizes[0]
                    
                    //determines screen size and finds appropriate image
                    let screenWidth = UIScreen.mainScreen().bounds.size.width * UIScreen.mainScreen().scale
                    let viableSizes = constSizes.filter({$0["width"] as? CGFloat >= screenWidth})
                    if viableSizes.count > 0 {
                        let selectedSize = viableSizes[0]
                        self.imageURLString = selectedSize["link"] as? String
                    } else {
                        let selectedSize = constSizes.last! //all else fails there will be a value here
                        self.imageURLString = selectedSize["link"] as? String
                    }
                }
            }
        }
    }
    
    func formattedDuration(duration: Int) -> String{
        let minutes = duration / 60
        let seconds = duration % 60
        let minuteString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        return minuteString + ":" + secondString
    }
}