//
//  MainViewController.swift
//  Skoolivin
//
//  Created by Namrata A on 4/29/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var posts = [Post]()
    let ref = Database.database().reference().child("Posts")
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    var filteredData = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell

        if isSearching{
            let post = filteredData[indexPath.row]
            cell.post = post
        } else {
            let post = posts[indexPath.row]
            cell.post = post
        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true

            filteredData = posts.filter({ post -> Bool in
                switch searchBar.selectedScopeButtonIndex {
                case 0:
                    if searchText.isEmpty { return true }
                    return post.address.lowercased().contains(searchText.lowercased())
                default:
                    return false
                }
            })

            tableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            filteredData = posts
        default:
            break
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let vc = DetailViewController()
        vc.posts = post
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ref.observe(.value, with: { (snapshot) in
            self.posts.removeAll()
            
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let currPost = Post(snapshot: childSnapshot)
                self.posts.insert(currPost, at: 0)
            }
            
            self.animateTableView()
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black,NSAttributedStringKey.font: UIFont(name: "Kohinoor Devanagari", size: 18) as Any]
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        handleLogout()
    }
    
    func handleLogout(){
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    func animateTableView(){
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
}
