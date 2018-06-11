//
//  ViewController_Location.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 6. 11..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapPointLocation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate : CLLocationCoordinate2D){
        self.coordinate = coordinate
        super.init()
    }
}


class ViewController_Location: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    @IBOutlet weak var Location_mapview: MKMapView!
    @IBOutlet weak var location_tableview: UITableView!
    
    @IBAction func location_prev(_ sender: Any) {
        if location_page_num > 1 {
            location_page_num -= 1
        }
        beginParsing()
    }
    @IBAction func location_next(_ sender: Any) {
        location_page_num += 1
        beginParsing()
    }
    
    var parser = XMLParser()
    let locationManager = CLLocationManager()
    
    var location_title = NSMutableString()
    var location_addr = NSMutableString()
    var location_tel = NSMutableString()
    var location_pos_x = NSMutableString()
    var location_pos_y = NSMutableString()
    var location_image = NSMutableString()
    
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    
    var location_page_num : Int = 1
    
    var real_loc_x : Double = 0.0
    var real_loc_y : Double = 0.0
    
    let regionRadious: CLLocationDistance = 1000


    func centerMapOnLocation3(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadious, regionRadious)
        Location_mapview.setRegion(coordinateRegion, animated: true)
    }
    




    @IBAction func reset_button(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        guard let locValue: CLLocationCoordinate2D = self.locationManager.location?.coordinate else { return }
        let ano_point = MapPointLocation(coordinate: CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude))
        centerMapOnLocation3(location: self.locationManager.location!)
        Location_mapview.addAnnotation(ano_point)
        beginParsing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath)
        
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueLocDetail"{
            if let cell = sender as? UITableViewCell{
                let indexPath = location_tableview.indexPath(for: cell)
                location_title = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "title") as! NSString as String as! NSMutableString
                location_image = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "firstimage") as! NSString as String as! NSMutableString
                location_tel = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "tel") as! NSString as String as! NSMutableString
                location_addr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "addr1") as! NSString as String as! NSMutableString
                location_pos_x = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapx") as! NSString as String as! NSMutableString
                location_pos_y = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapy") as! NSString as String as! NSMutableString
                if let viewcon_detail = segue.destination as? TableViewController_Location_Detail{
                    viewcon_detail.detail_title = location_title
                    viewcon_detail.detail_tel = location_tel
                    viewcon_detail.detail_addr = location_addr
                    viewcon_detail.detail_url = location_image
                    viewcon_detail.detail_x_pos = location_pos_x
                    viewcon_detail.detail_y_pos = location_pos_y
                }
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            
            
            elements = NSMutableDictionary()
            elements = [:]
            location_title = NSMutableString()
            location_title = ""
            location_tel = NSMutableString()
            location_tel = ""
            location_addr = NSMutableString()
            location_addr = ""
            location_image = NSMutableString()
            location_image = ""
            location_pos_x = NSMutableString()
            location_pos_x = ""
            location_pos_y = NSMutableString()
            location_pos_y = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element.isEqual(to: "title"){
            location_title.append(string)
        }
        else if element.isEqual(to: "addr1"){
            location_addr.append(string)
        }
        else if element.isEqual(to: "tel"){
            location_tel.append(string)
        }
        else if element.isEqual(to: "mapx"){
            location_pos_x.append(string)
        }
        else if element.isEqual(to: "mapy"){
            location_pos_y.append(string)
        }
        else if element.isEqual(to: "firstimage"){
            location_image.append(string)
        }
        
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if (elementName as NSString).isEqual(to: "item"){
            if !location_title.isEqual(nil){
                elements.setObject(location_title, forKey: "title" as NSCopying)
            }
            if !location_addr.isEqual(nil){
                elements.setObject(location_addr, forKey: "addr1" as NSCopying)
            }
            
            if !location_tel.isEqual(nil){
                elements.setObject(location_tel, forKey: "tel" as NSCopying)
            }
            if !location_pos_x.isEqual(nil){
                elements.setObject(location_pos_x, forKey: "mapx" as NSCopying)
            }
            if !location_pos_y.isEqual(nil){
                elements.setObject(location_pos_y, forKey: "mapy" as NSCopying)
            }
            if !location_image.isEqual(nil){
                elements.setObject(location_image, forKey: "firstimage" as NSCopying)
            }
            
            posts.add(elements)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    func beginParsing(){
        posts = []
        
        parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&numOfRoews=10&pageNo=\(location_page_num)&startPage=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&contenTypeId=15&mapX=\(real_loc_y)&mapY=\(real_loc_x)&radius=1000&listYN=Y"))!)!
        //http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&numOfRoews=10&pageNo=1&startPage=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&contenTypeId=15&mapX=37.3386951431927&mapY=126.734697772746&radius=20000&listYN=Y
        print("폐지 넘버 : \(location_page_num), x : \(real_loc_x), y: \(real_loc_y)")
        parser.delegate = self
        parser.parse()
        
        location_tableview!.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.location_tableview.dataSource = self
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        guard let locValue: CLLocationCoordinate2D = self.locationManager.location?.coordinate else { return }
        let ano_point = MapPointLocation(coordinate: CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude))
        centerMapOnLocation3(location: self.locationManager.location!)
        Location_mapview.addAnnotation(ano_point)
        real_loc_x = locValue.latitude
        real_loc_y = locValue.longitude
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "location_background.jpeg")!)
        beginParsing()
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
