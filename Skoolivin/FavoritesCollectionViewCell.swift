//
//  FavoritesCollectionViewCell.swift
//  Skoolivin
//
//  Created by Namrata A on 5/5/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import FirebaseStorage

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            self.updateUI()
        }
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    
    func updateUI(){
        if let post = post {
            addressLabel.text = post.address
            let imageDownloadURL = post.imgDownloadURL
            print("image URL got is: ", imageDownloadURL)
            let imageStorageRef = Storage.storage().reference(forURL: imageDownloadURL)
            imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { [weak self] (data, error) in
                if let error = error {
                    print("******** \(error)")
                } else {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self?.postImg.image = image
                        }
                    }
                }
                
            }
        } else {
            postImg.image = nil
            addressLabel.text = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
    
}
