//
//  DetailViewController.swift
//  Skoolivin
//
//  Created by Namrata A on 5/4/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import FirebaseStorage

class DetailViewController: UIViewController {
    
    var posts: Post? {
        didSet {
            print("information is: ", posts?.address as Any)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = posts?.address
        view.backgroundColor = UIColor.white
        
        print(posts?.address as Any, posts?.priceInt as Any, posts?.distance as Any, posts?.rooms as Any, posts?.shared as Any, posts?.imgDownloadURL as Any)
        
        let priceLabel: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Price: $\(posts?.priceInt ?? 0)"
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:6))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
//            label.font = UIFont(name: "Cochin", size: 15)
            return label
        }()
        
        let distanceLabel: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Distance: \(posts?.distance ?? "0.0 mi")"
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:9))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let comments: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Comments: " + (posts?.comments)!
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:9))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let dates: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Between Dates: " + (posts?.startDate)! + " - " + (posts?.endDate)!
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:14))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let food: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Food Pref: " + (posts?.food)!
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:10))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let partying: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Partying: " + (posts?.partying)!
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:9))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let year: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Year: " + (posts?.year)!
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:5))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let major: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Major: " + (posts?.major)!
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:6))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let rooms: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Rooms: \(posts?.rooms ?? 0)"
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:6))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let shared: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Shared Rooms: \(posts?.shared ?? 0)"
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:13))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let pets: UILabel = {
            let label = UILabel()
            var myMutableString = NSMutableAttributedString()
            let myString: String = "Pets: " + (posts?.pets)!
            myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Kohinoor Devanagari", size: 15.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:5))
            label.attributedText = myMutableString
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.contentMode = .scaleToFill
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.justified
            return label
        }()
        
        let mapButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor.black
            button.setTitle("View Map", for: .normal)
            button.tintColor = UIColor.white
            button.addTarget(self, action: #selector(mapViewTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
//            button.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            return button
        }()
        
        let postImg: UIImageView = {
            let img = UIImageView()
            img.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
            img.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFill
            let imageDownloadURL = posts?.imgDownloadURL
                    print("image URL got is: ", imageDownloadURL as Any)
                    let imageStorageRef = Storage.storage().reference(forURL: imageDownloadURL!)
                    imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { [weak self] (data, error) in
                        if let error = error {
                            print("******** \(error)")
                        } else {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    img.image = image
                                }
                            }
                        }
            
                    }
            return img
        }()
        
        view.addSubview(priceLabel)
        view.addSubview(distanceLabel)
        view.addSubview(postImg)
        view.addSubview(mapButton)
        view.addSubview(comments)
        view.addSubview(dates)
        view.addSubview(food)
        view.addSubview(partying)
        view.addSubview(year)
        view.addSubview(major)
        view.addSubview(rooms)
        view.addSubview(shared)
        view.addSubview(pets)
        
        //left
        priceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        //left
        distanceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        //right
        food.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        food.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        //right
        partying.topAnchor.constraint(equalTo: food.bottomAnchor, constant: 10).isActive = true
        partying.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        //whole
        comments.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10).isActive = true
        comments.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        //whole
        dates.topAnchor.constraint(equalTo: comments.bottomAnchor, constant: 10).isActive = true
        dates.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        //right
        year.topAnchor.constraint(equalTo: dates.bottomAnchor, constant: 10).isActive = true
        year.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        //left
        major.topAnchor.constraint(equalTo: dates.bottomAnchor, constant: 10).isActive = true
        major.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        //right
        rooms.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 10).isActive = true
        rooms.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        //left
        shared.topAnchor.constraint(equalTo: major.bottomAnchor, constant: 10).isActive = true
        shared.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        postImg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        postImg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        postImg.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        
        pets.topAnchor.constraint(equalTo: shared.bottomAnchor, constant: 10).isActive = true
        pets.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        mapButton.topAnchor.constraint(equalTo: rooms.topAnchor, constant: 30).isActive = true
        mapButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
    }
    
    @objc func mapViewTapped(){
        
        let mvc = MapViewController()
        mvc.currAddress = posts?.address
        navigationController?.pushViewController(mvc, animated: true)
        
    }
    
}
