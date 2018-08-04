//
//  PostTableViewCell.swift
//  Skoolivin
//
//  Created by Namrata A on 4/30/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import FirebaseStorage

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    
    var link: MainViewController?
    
    fileprivate let likeColor = UIColor(red: 243.0/255.0, green: 62.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    
    var post: Post! {
        didSet {
            addressLabel.text = post.address
            priceLabel.text = "$\(post.priceInt)"
            likeButton.setImage(#imageLiteral(resourceName: "icons8-heart-outline-25"), for: .normal)
            
            let imageDownloadURL = post.imgDownloadURL //{
            print("image URL got is: ", imageDownloadURL)
                let imageStorageRef = Storage.storage().reference(forURL: imageDownloadURL)
                imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { [weak self] (data, error) in
                    if let error = error {
                        print("******** \(error)")
                    } else {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            DispatchQueue.main.async {
                                self?.postImageView.image = image
                            }
                        }
                    }
                    
                }
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likePressed(_ sender: UIButton) {
        post.like()
        if(post.liked == 1)
        {
            likeButton.setImage(#imageLiteral(resourceName: "icons8-heart-outline-filled-25"), for: .normal)
        }else{
            likeButton.setImage(#imageLiteral(resourceName: "icons8-heart-outline-25"), for: .normal)
        }
        link?.tableView.reloadData()
    }
    
}
