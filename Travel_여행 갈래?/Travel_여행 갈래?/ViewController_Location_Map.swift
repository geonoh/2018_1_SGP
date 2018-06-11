//
//  ViewController_Location_Map.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 6. 12..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit
import MapKit

class MapPointLocationDetail: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init (coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
        super.init()
    }
}



class ViewController_Location_Map: UIViewController {

    @IBOutlet weak var location_map_view: MKMapView!
    
    var x_pos : String = ""
    var y_pos : String = ""
    
    let regionRadious: CLLocationDistance = 1000
    
    func centerMapOnLocation3(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadious, regionRadious)
        location_map_view.setRegion(coordinateRegion, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let initialLocation = CLLocation(latitude: Double(y_pos)!, longitude: Double(x_pos)!)
        //let initialLocation = CLLocation(latitude: 127.0066015446, longitude: 37.5753148419)
        // Do any additional setup after loading the view.
        let ano_point = MapPointHome(coordinate: CLLocationCoordinate2D(latitude: Double(y_pos)!, longitude: Double(x_pos)!))
        //let ano_point = MapPoint(coordinate: CLLocationCoordinate2D(latitude: 127.0066015446, longitude: 37.5753148419))
        centerMapOnLocation3(location: initialLocation)
        // Do any additional setup after loading the view.
        location_map_view.addAnnotation(ano_point)
        // Do any additional setup after loading the view.
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
