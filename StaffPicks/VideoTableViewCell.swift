//
//  VideoTableViewCell.swift
//  StaffPicks
//
//  Created by Nick&Danielle on 1/12/16.
//  Copyright © 2016 com.Nickcalabro. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    var task: NSURLSessionDataTask?
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var durationLabel: UILabel?
    @IBOutlet weak var videoImage: UIImageView?
    
    var video: Video?{
        didSet{
            if let constVideo = video {
                self.nameLabel?.text = video?.name
                if let constDuration = video?.duration{
                    self.durationLabel!.text = constDuration
                } else {
                    self.durationLabel?.text = "?"
                }
                
                if let constImageURLString = video!.imageURLString{
                    let url = NSURL(string: constImageURLString)!
                    self.task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { [weak self] (data, response, error) -> Void in
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            if let strongSelf = self{
                                
                                if constImageURLString != strongSelf.video?.imageURLString {
                                    return
                                }
                                
                                strongSelf.task = nil
                                
                                if let data = data {
                                    let image = UIImage(data: data)
                                    strongSelf.videoImage?.image = image
                                } else {
                                    
                                }
                            }
                        })
                        
                    })
                    self.task?.resume()
                }
            }
        }
    }
    
    deinit{
        self.task?.cancel()
        self.task = nil
    }
    
    override func prepareForReuse() {
        self.nameLabel?.text = ""
        self.durationLabel?.text = ""
        self.videoImage?.image = nil
        self.task?.cancel()
        self.task = nil 
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
