//
//  ViewController_Festival_Map.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 6. 11..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit
import MapKit

class MapPoint: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        super.init()
    }
}


class ViewController_Festival_Map: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map_view: MKMapView!
    
    var x_pos : String = ""
    var y_pos : String = ""
    
    let regionRadious: CLLocationDistance = 5000
    
    func centerMapOnLocation2(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadious, regionRadious)
        map_view.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("야야야야야야 \(x_pos) \(y_pos)")
        //127.0066015446 37.5753148419
        //let initialLocation = CLLocation(latitude: 37.5753148419, longitude: 127.0066015446)
        let initialLocation = CLLocation(latitude: Double(y_pos)!, longitude: Double(x_pos)!)
        //let initialLocation = CLLocation(latitude: 127.0066015446, longitude: 37.5753148419)
        // Do any additional setup after loading the view.
        let ano_point = MapPointin(coordinate: CLLocationCoordinate2D(latitude: Double(y_pos)!, longitude: Double(x_pos)!))
        //let ano_point = MapPoint(coordinate: CLLocationCoordinate2D(latitude: 127.0066015446, longitude: 37.5753148419))
        centerMapOnLocation2(location: initialLocation)
        // Do any additional setup after loading the view.
        map_view.addAnnotation(ano_point)
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
