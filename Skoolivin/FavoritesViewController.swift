//
//  FavoritesViewController.swift
//  Skoolivin
//
//  Created by Namrata A on 5/5/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesCollView: UICollectionView!
    
    var posts = [Post]()
    let ref = Database.database().reference().child("Posts")
    let cellScaling: CGFloat = 0.6
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Quick View"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black,NSAttributedStringKey.font: UIFont(name: "Kohinoor Devanagari", size: 16) as Any]
        
        print("after fetching from DB: ", posts.count)
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = favoritesCollView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        favoritesCollView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        favoritesCollView?.dataSource = self
        favoritesCollView?.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ref.observe(.value, with: { (snapshot) in
            self.posts.removeAll()
            
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let currPost = Post(snapshot: childSnapshot)
                print("liked? ", currPost.liked)
                self.posts.insert(currPost, at: 0)
            }
            
            self.favoritesCollView.reloadData()
            
        })
    }

}

extension FavoritesViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoritesCollectionViewCell
        
            cell.post = posts[indexPath.item]
        
        return cell
    }
}

extension FavoritesViewController : UIScrollViewDelegate, UICollectionViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.favoritesCollView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
