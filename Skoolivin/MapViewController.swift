//
//  MapViewController.swift
//  Skoolivin
//
//  Created by Namrata A on 5/5/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class MapViewController: UIViewController {
    
    var currAddress: String!
    var mapView: MKMapView!
    var locs = [Location]()
    var currentPlcMark: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        mapView = MKMapView()
        
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 300
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        mapView.center = view.center
        
        view.addSubview(mapView)
        
        let initLoc = CLLocation(latitude: 43.0393726, longitude: -76.13024290000001)
        mapZoom(loc: initLoc)
        //let initMarker = Location(coordinate: CLLocationCoordinate2D(latitude: 43.0393726, longitude: -76.13024290000001), locName: "College Place, SU")
        //mapView.addAnnotation(initMarker)
        
        fetchData()
        addDestAnnotation()
        
        self.mapView.delegate = self
    }
    
    private let regionRadius: CLLocationDistance = 1000
    
    func addDestAnnotation(){
        print("in add dest annotation with location count: ", locs.count)
        for loc in locs {
            print("comparing: ", loc.locName as Any, currAddress)
            if loc.locName == currAddress {
                
                let sourceLocation = CLLocationCoordinate2D(latitude: 43.0393726 , longitude: -76.13024290000001)
                let destinationLocation = loc.coordinate
                
                let initMarker = Location(coordinate: sourceLocation, locName: "College Place")
                mapView.addAnnotation(initMarker)
                let destMarker = Location(coordinate: destinationLocation, locName: loc.locName!)
                mapView.addAnnotation(destMarker)
                
                let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
                let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
                
                let directionRequest = MKDirectionsRequest()
                directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
                directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
                directionRequest.transportType = .automobile
                
                let directions = MKDirections(request: directionRequest)
                directions.calculate { (response, error) in
                    guard let directionResonse = response else {
                        if let error = error {
                            print("we have error getting directions==\(error.localizedDescription)")
                        }
                        return
                    }
                    
                    let route = directionResonse.routes[0]
                    self.mapView.add(route.polyline, level: .aboveRoads)
                    
                    let rect = route.polyline.boundingMapRect
                    self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                }
                
            }
        }
    }
    
    func mapZoom(loc: CLLocation){
        let coordinateReg = MKCoordinateRegionMakeWithDistance(loc.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateReg, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fetchData()
    {
        let fileName = Bundle.main.path(forResource: "Venues", ofType: "json")
        let filePath = URL(fileURLWithPath: fileName!)
        var data: Data?
        do {
            data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
        } catch let error {
            data = nil
            print("Report error \(error.localizedDescription)")
        }
        
        if let jsonData = data {
            let json = JSON(jsonData)
            if json == JSON.null { print("whoops!")}
            if let locJsons = json["response"]["venues"].array {
                print("made it to the right path!")
                for locJSON in locJsons {
                    if let loc = Location.from(json: locJSON) {
                        print("yaayy!! ", loc.locName as Any)
                        self.locs.append(loc)
                    }
                }
            }
        }
    }
    
}

extension MapViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
}

