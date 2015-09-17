//
//  PhotoDetailsViewController.swift
//  InstaClone
//
//  Created by Daniel Trostli on 9/16/15.
//  Copyright © 2015 Codepath. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var photo: NSDictionary!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! PhotoDetailCell
        
        print("photo: \(photo)")
        let images = photo["images"] as! NSDictionary
        let thumbnailURL = images["standard_resolution"]?["url"] as! String
        cell.photoView.setImageWithURL(NSURL(string: thumbnailURL)!)
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
