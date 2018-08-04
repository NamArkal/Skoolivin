//
//  PostsModel.swift
//  Skoolivin
//
//  Created by Namrata A on 4/29/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import Foundation
import Firebase

class Post {
    var address: String = ""
    var liked = 0
    var comments: String = ""
    var distance: String = ""
    var endDate: String = ""
    var food: String = ""
    var major: String = ""
    var partying: String = ""
    var pets: String = ""
    var rooms = 0
    var shared = 0
    var startDate: String = ""
    var year: String = ""
    var priceInt = 0
    private var image: UIImage!
    var imgDownloadURL: String = ""
    var ref: DatabaseReference!
    
    init(address: String, comments: String, endDate: String, food: String, major: String, partying: String, pets: String, rooms: Int, shared: Int, startDate: String, year: String, price: String, distance: String, image: UIImage) {
        self.address = address
        self.comments = comments
        self.endDate = endDate
        self.food = food
        self.major = major
        self.partying = partying
        self.pets = pets
        self.rooms = rooms
        self.shared = shared
        self.startDate = startDate
        self.year = year
        self.priceInt = Int(price)!
        self.distance = distance
        self.image = image
        ref = Database.database().reference().child("Posts").childByAutoId()
    }
    
    init(snapshot: DataSnapshot)
    {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            address = value["Address"] as! String
            comments = value["Comments"] as! String
            endDate = value["EndDate"] as! String
            food = value["Food"] as! String
            major = value["Major"] as! String
            partying = value["Partying"] as! String
            pets = value["Pets"] as! String
            rooms = value["Rooms"] as! Int
            shared = value["Shared"] as! Int
            startDate = value["StartDate"] as! String
            year = value["Year"] as! String
            distance = value["Distance"] as! String
            priceInt = value["Price"] as! Int
            imgDownloadURL = value["ImageDownloadURL"] as! String
        }
    }
    
    func save(){
        let newPostKey = ref.key
        
        if let imageData = UIImageJPEGRepresentation(image, 0.5) {
            
        let imgStorageRef = Storage.storage().reference().child("images")
        let newImgRef = imgStorageRef.child(newPostKey)
            
            newImgRef.putData(imageData).observe(.success) { (snapshot) in
                self.imgDownloadURL = (snapshot.metadata?.downloadURL()?.absoluteString)!
                self.ref.setValue(self.toDictionary())
            }
            
        }
        
    }
    
    func toDictionary() -> [String : Any] {
        print("in todictionary: ", imgDownloadURL)
        return [
            "Address" : address, //done
            "Comments" : comments, //done
            "Distance" : distance, //done
            "EndDate" : endDate, //done
            "Food" : food, //done
            "Likes" : liked, //done
            "Major" : major, //done
            "Partying" : partying, //done
            "Pets" : pets,
            "Rooms" : rooms, //done
            "Shared" : shared, //done
            "StartDate" : startDate, //done
            "Year" : year, //done
            "Price" : priceInt, //done
            "ImageDownloadURL" : imgDownloadURL //done
        ]
    }
}

extension Post {
    func like() {
        if(liked == 0) {
            liked = 1
        } else {
            liked = 0
        }
        ref.child("Likes").setValue(liked)
    }
}
