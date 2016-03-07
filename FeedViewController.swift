//
//  FeedViewController.swift
//  InstagramLite
//
//  Created by Zach Glick on 3/6/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var posts : [PFObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 120

        loadPosts()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("logoutSegue", sender: nil)
    }

    @IBAction func onPost(sender: AnyObject) {
        performSegueWithIdentifier("postSegue", sender: nil)
    }
    func loadPosts(){
        let query = PFQuery(className: "Post")
        query.limit = 20
        query.orderByDescending("_created_at")

        print("Loading Posts")
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                print("Found \(posts.count) posts")
                // do something with the array of object returned by the call
                self.posts = posts
                self.tableView.reloadData()

                
            } else {
                print("Error finding posts")
                print(error?.localizedDescription)
            }
           

        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUM ROWS IN SECTION")
        if posts != nil {
            
            return posts!.count
        }
       // print("no posts in numberOfRowsInSection")
        return 0;
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("CELL FOR ROW AT PATH")
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = posts![indexPath.row]
        cell.caption = post["caption"] as? String
        cell.picture = post["media"] as? UIImage
        
        if let picFile = post["media"] as? PFFile {
            picFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    cell.picture = UIImage(data:imageData!)
                    cell.awakeFromNib()

                }
            }
        }
        cell.awakeFromNib()
       // print("caption is \(post["caption"] as? String ?? "nonexistent")")
        
        return cell;
    }
    


}
