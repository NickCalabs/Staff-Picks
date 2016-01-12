//
//  VimeoClient.swift
//  StaffPicks
//
//  Created by Nick&Danielle on 1/12/16.
//  Copyright © 2016 com.Nickcalabro. All rights reserved.
//

import Foundation

typealias ServerResponseCallback = (videos: Array<Video>?, error: NSError?) -> Void

class VimeoClient{
    
    static let authToken = "64b5e294d36690756253c895b1fe8548"
    static let errorDomain = "VimeoClientErrorDomain"
    static let baseURLString = "https://api.vimeo.com"
    static let staffpicksPath = "/channels/staffpicks/videos"
    
    class func staffPicks(callback: ServerResponseCallback){
        
        let URLString = baseURLString + staffpicksPath
        let URL = NSURL(string: URLString)
        
        if URL == nil {
            let error = NSError(domain: errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to create URL"])
            callback(videos: nil, error: error)
        }
        
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil {
                    callback(videos: nil, error: error)
                    return
                }
                
                var JSON: Dictionary<String,AnyObject>? = nil
                do{
                    JSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? Dictionary<String,AnyObject>
                }
                catch let error as NSError {
                    callback(videos: nil, error: error)
                    return
                }
                
                if JSON == nil {
                    let error = NSError(domain: self.errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to Parse JSON"])
                    callback(videos: nil, error: error)
                    return
                }
                
                var videoArray = Array<Video>()
                
                if let constJSON = JSON {
                    
                    let dataArray = constJSON["data"] as? Array<Dictionary<String,AnyObject>>
                    
                    if let constArray = dataArray {
                        
                        for value in constArray {
                            
                            let video = Video(dictionary: value)
                            videoArray.append(video)
                            
                        }
                        
                    }
                    
                }
                
                callback(videos: videoArray, error: nil)
            })
        
        })
        
        task.resume()
        
    }
}