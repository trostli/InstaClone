//
//  PhotoViewController.swift
//  InstaClone
//
//  Created by Daniel Trostli on 9/16/15.
//  Copyright © 2015 Codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var photos: [NSDictionary]?

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        tableView.rowHeight = 320

        getPhotos()
    }
    
    func getPhotos() {
        var clientId = "244271e86ed845b095768259f51f1833"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (
            response, data, error) -> Void in
            if let d = data {
                let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(d, options: []) as! NSDictionary
                self.photos = responseDictionary["data"] as? [NSDictionary]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                //print("response: \(self.photos)")
            } else {
                if let e = error {
                    print("Error: \(e)")
                }
            }
        }
    }
    
    func refresh(sender: AnyObject) {
        getPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
        
        let photo = photos![indexPath.row]
        
        //print("photo: \(photo)")
        let images = photo["images"] as! NSDictionary
        let thumbnailURL = images["thumbnail"]?["url"] as! String
        cell.photoView.setImageWithURL(NSURL(string: thumbnailURL)!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        vc.photo = photos![indexPath!.row]
    }


}
