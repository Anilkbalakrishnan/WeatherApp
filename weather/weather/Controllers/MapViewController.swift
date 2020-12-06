//
//  MapViewController.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 06/12/2020.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var mapDataPoints: [MapPin] = [
        MapPin(title: "Nathonal Theatre", coordinate: CLLocationCoordinate2D(latitude: 59.9085663657, longitude: 10.7340720637), details:"Kings palace is nearby"),
        MapPin(title: "Stortinget", coordinate: CLLocationCoordinate2D(latitude: 59.907663036, longitude: 10.73833038), details: "Norwegiang parlament")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.mapView.delegate = self
        self.plotPointOnMap()
    }
    
    func plotPointOnMap(){
        //Removing old annotiaton pins
        let existingAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(existingAnnotations)
        
        mapDataPoints.forEach { (mapPin) in
            self.mapView.addAnnotation(mapPin)
        }
    }
    
}

//If you need more details to plot on map, Just inherie MKAnnotation and override the basic field title, subTitle and coordiantes and add more field if you need to customize the UI
class MapPin: NSObject, MKAnnotation {
    let title: String?
    var subtitle: String? {
        return details
    }
    let coordinate: CLLocationCoordinate2D
    let details: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, details:String) {
        self.title = title
        self.coordinate = coordinate
        self.details = details
        
    }
    
}







// if you need to customize the view use the delegate and customize the MKAnnotation view and return the custom viw
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationReuseIdentifier = "MKPinReuseIdentifier"
        var annotationView: MKAnnotationView?
        
        //Check if the MKAnnotation is an userLocatin if so return nil to plot default UI for the userlocaiton
        if let userLocation  = annotation as? MKUserLocation { return nil }
        
        //Get hold of the AnnotationView reference of the Annotaiton pin
        if let annotationMapPin = annotation as? MapPin {
            
            // Try to check if the pin is already rendered, if so use the reuse identifier to reuse the annotationView a
            // else create a new MKAnnotation view and assign the the reuseIdentifier.
            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseIdentifier) {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            }else {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseIdentifier)
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            
            //Customising the annotaitonView
             self.customizeMKAnnotationView(annotationView, annotationMapPin)
            
            return annotationView
        }
        
        return annotationView
    }
    
    fileprivate func customizeMKAnnotationView(_ annotationView: MKAnnotationView?, _ annotationPin: MapPin) {
        if let annotationViewToCustomize = annotationView {
            
            annotationViewToCustomize.canShowCallout = false
            annotationViewToCustomize.frame = CGRect(x: 0, y: 0, width: 60 , height: 74)
            annotationViewToCustomize.centerOffset = (CGPoint(x: 0, y: -37))
            
            //Set a custom Image View
            let imageView :UIImageView = UIImageView()
            imageView.layer.frame = CGRect(x: 0, y: 0, width: 60, height: 74)
            if annotationPin.title == "Nathonal Theatre" {
                imageView.image = UIImage(named: "nationalTheatret_image")
            }else if annotationPin.title == "Stortinget" {
                imageView.image = UIImage(named: "stortinget_image")
            }
            
            //Remove all the default subviews in Annotation view and add the Image View
            annotationViewToCustomize.subviews.forEach { (subView) in
                subView.removeFromSuperview()
            }
            annotationViewToCustomize.addSubview(imageView)
        }
    }
    
    
}
