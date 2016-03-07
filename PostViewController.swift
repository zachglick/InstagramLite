//
//  PostViewController.swift
//  InstagramLite
//
//  Created by Zach Glick on 3/6/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    var submitImage : UIImage?
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        captionField.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            self.submitImage = originalImage
            
            // Do something with the images (based on your use case)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            postImage.image = originalImage
            dismissViewControllerAnimated(true, completion: nil)

            
    }
    
    @IBAction func onPost(sender: AnyObject) {
        captionField.endEditing(true)
        //self.dismissViewControllerAnimated(true, completion: nil)
        Post.postUserImage(submitImage, withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
            if success == true {
                print("image posted successfully")
            }
            else{
                print(error?.localizedDescription)
            }
            
        }
        
        self.performSegueWithIdentifier("returnFeedSegue", sender: nil)
    }

    @IBAction func onSelectButton(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    
        
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
