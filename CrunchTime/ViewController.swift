//
//  ViewController.swift
//  CrunchTime
//
//  Created by Matthew Lam on 11/14/18.
//  Copyright © 2018 Matt & Sinj. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, GMSMapViewDelegate, MapMarkerDelegate {
    func seeMore() {
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    private var infoWindow = CustomInfoWindow()
    fileprivate var locationMarker : GMSMarker? = GMSMarker()
    var map:GMSMapView!
    var selectedLibrary = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 37.872145, longitude: -122.258529, zoom: 17)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        
        //self.map.isMyLocationEnabled = true
        let dbRef = Database.database().reference().child("Libraries")
        dbRef.observe(.childAdded, with: { (snapshot) in
            if snapshot.exists() {
                guard let libraries = snapshot.value as? [String : AnyObject] else {
                    return
                }
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: libraries["Lat"] as! CLLocationDegrees, longitude: libraries["Long"] as! CLLocationDegrees)
                marker.map = mapView
                marker.userData = libraries as? NSDictionary
            }
        })
    }
    
    func mapView(_ mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        var markerData : NSDictionary?
        let data = marker.userData! as? NSDictionary
            markerData = data
        let pic = markerData!["Image"]!
        let name = markerData!["name"]!
        let capacity = markerData!["Capacity"]! as! Int

        let customInfoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?[0] as! CustomInfoWindow
        customInfoWindow.spotData = markerData
        customInfoWindow.libPic.image = UIImage(named: pic as! String)
        customInfoWindow.libName.text = name as! String
        customInfoWindow.delegate = self
        customInfoWindow.capacity.text = "Capacity: " + String(capacity)
        selectedLibrary = name as! String //didtapwindowofmarker
        //performSegue(withIdentifier: "mapSegue", sender: self), for: .touchUpInside)
        //customInfoWindow.button.addTarget(self, action: #selector(seeMore), for: .touchUpInside)
        //customInfoWindow.completedYearLbl.text = completedYear[index]
        return customInfoWindow
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination : LibraryViewController = segue.destination as! LibraryViewController
        destination.chosenLibrary = selectedLibrary
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (locationMarker != nil){
            guard let location = locationMarker?.position else {
                print("locationMarker is nil")
                return
            }
            infoWindow.center = mapView.projection.point(for: location)
            infoWindow.center.y = infoWindow.center.y - 82
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
    }
    
    func loadNiB() -> CustomInfoWindow {
        let infoWindow = CustomInfoWindow.instanceFromNib() as! CustomInfoWindow
        return infoWindow
    }
}
