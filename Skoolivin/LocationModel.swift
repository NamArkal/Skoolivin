//
//  Location.swift
//  Skoolivin
//
//  Created by Namrata A on 5/5/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import Foundation
import MapKit
import SwiftyJSON

class Location: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let locName: String?
    
    init(coordinate: CLLocationCoordinate2D, locName: String) {
        self.coordinate = coordinate
        self.locName = locName
        super.init()
    }
    
    var subtitle: String?{
        return locName
    }
    
    class func from(json: JSON) -> Location?
    {
        var title: String
        if let unwrappedTitle = json["name"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }
        
        let lat = json["location"]["lat"].doubleValue
        let long = json["location"]["lng"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        return Location(coordinate: coordinate, locName: title)
    }
}
