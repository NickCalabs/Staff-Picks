//
//  StaffPicksViewController.swift
//  StaffPicks
//
//  Created by Nick&Danielle on 1/12/16.
//  Copyright © 2016 com.Nickcalabro. All rights reserved.
//

import UIKit

class StaffPicksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    let cellID = "CellIdentifier"
    
    var items: Array<Video> = []

    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Staff Picks"
        
        self.setupTableView()
        
        self.refreshItems()
        
    }
    
    //MARK: setup
    
    func setupTableView(){
        let nib = UINib(nibName: "VideoTableViewCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(VideoTableViewCell.self))
        //self.tableView?.registerClass(VideoTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(VideoTableViewCell.self))
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(VideoTableViewCell.self)) as! VideoTableViewCell
        
        //cell.textLabel?.text = self.items[indexPath.row]
        let video = self.items[indexPath.row]
        cell.video = video
        /*cell.nameLabel?.text = video.name
        
        if let constDuration = video.duration{
            cell.durationLabel?.text = "\(constDuration)"
        } else {
            cell.durationLabel?.text = "?"
        }*/
        
        return cell
    }
    
    func refreshItems(){
        VimeoClient.staffPicks { (videos, error) -> Void in
            
            if let constVideos = videos{
                self.items = constVideos
                self.tableView?.reloadData()
            } else {
                //TODO: alert user
            }
            
            print("error: \(error)\nobject: \(videos)")
        }
    }

}