//
//  PostTableViewCell.swift
//  InstagramLite
//
//  Created by Zach Glick on 3/6/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var picture : UIImage?
    
    var caption : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //print("Cell loaded : \(caption ?? "No text")")
        postImageView.image = picture
        postCaptionLabel.text = caption
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
