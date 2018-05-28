//
//  ViewController_MapView.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 29..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit
import MapKit

class MapPointin: NSObject,MKAnnotation{
    let coordinate: CLLocationCoordinate2D
    
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
        
        super.init()
    }
}

class ViewController_MapView: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var x_pos : String = ""
    var y_pos : String = ""
    
    let regionRadious: CLLocationDistance = 5000
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadious, regionRadious)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    /*
    func mapView(_ mapView: MKMapView, annotaionView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! Hospital
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Hospital else{
            return nil
        }
        
        let identifier = "marker"
        var view : MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
        
    }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(x_pos) \(y_pos)")
        //127.0066015446 37.5753148419
        //let initialLocation = CLLocation(latitude: 37.5753148419, longitude: 127.0066015446)
        let initialLocation = CLLocation(latitude: Double(y_pos)!, longitude: Double(x_pos)!)
        // Do any additional setup after loading the view.
        let ano_point = MapPointin(coordinate: CLLocationCoordinate2D(latitude: Double(y_pos)!, longitude: Double(x_pos)!))
        centerMapOnLocation(location: initialLocation)
        // Do any additional setup after loading the view.
        mapView.addAnnotation(ano_point)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
