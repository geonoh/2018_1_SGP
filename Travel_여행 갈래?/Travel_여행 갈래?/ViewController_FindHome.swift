//
//  ViewController_FindHome.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 6. 7..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit

@IBDesignable

class ViewController_FindHome: UIViewController, XMLParserDelegate ,UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    var parser = XMLParser()
    var hanok_ok : Int = 0
    var benikia_ok : Int = 0
    var goodstay_ok : Int = 0
    
    @IBOutlet weak var search_button: UIButton!
    
    @IBAction func prev_button(_ sender: Any) {
        if home_page_number > 1 {
            home_page_number -= 1
            beginParsing()
        }
    }
    @IBAction func next_button(_ sender: Any) {
        home_page_number += 1
        beginParsing()
    }
    
    @IBAction func home_search(_ sender: Any) {
        let explore = ExplodeView(frame: CGRect(x: (search_button.imageView?.center.x)!, y:(search_button.imageView?.center.y)!,width: 10, height: 10))
        search_button.imageView?.superview?.addSubview(explore)
        search_button.imageView?.superview?.sendSubview(toBack: explore)
        beginParsing()
    }
    @IBOutlet weak var home_tableview: UITableView!
    
    
    var posts = NSMutableArray()
    
    
    var home_title = NSMutableString()
    var home_addr = NSMutableString()
    var home_tel = NSMutableString()
    var home_image = NSMutableString()
    var home_pos_x = NSMutableString()
    var home_pos_y = NSMutableString()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
        
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        
        return cell
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            
            
            elements = NSMutableDictionary()
            elements = [:]
            home_title = NSMutableString()
            home_title = ""
            home_tel = NSMutableString()
            home_tel = ""
            home_addr = NSMutableString()
            home_addr = ""
            home_image = NSMutableString()
            home_image = ""
            home_pos_x = NSMutableString()
            home_pos_x = ""
            home_pos_y = NSMutableString()
            home_pos_y = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element.isEqual(to: "title"){
            home_title.append(string)
        }
        else if element.isEqual(to: "addr1"){
            home_addr.append(string)
        }
        else if element.isEqual(to: "tel"){
            home_tel.append(string)
        }
        else if element.isEqual(to: "mapx"){
            home_pos_x.append(string)
        }
        else if element.isEqual(to: "mapy"){
            home_pos_y.append(string)
        }
        else if element.isEqual(to: "firstimage"){
            home_image.append(string)
        }
        
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if (elementName as NSString).isEqual(to: "item"){
            if !home_title.isEqual(nil){
                elements.setObject(home_title, forKey: "title" as NSCopying)
                //print("\(home_title) 이름만 알자")
            }
            if !home_addr.isEqual(nil){
                elements.setObject(home_addr, forKey: "addr1" as NSCopying)
            }
            
            if !home_tel.isEqual(nil){
                elements.setObject(home_tel, forKey: "tel" as NSCopying)
            }
            if !home_pos_x.isEqual(nil){
                elements.setObject(home_pos_x, forKey: "mapx" as NSCopying)
            }
            if !home_pos_y.isEqual(nil){
                elements.setObject(home_pos_y, forKey: "mapy" as NSCopying)
            }
            if !home_image.isEqual(nil){
                elements.setObject(home_image, forKey: "firstimage" as NSCopying)
            }
            
            posts.add(elements)
        }
        
    }
    
    func beginParsing(){
        posts = []
        
        parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&numOfRows=10&pageSize=10&pageNo=\(home_page_number)&startPage=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&listYN=Y&areaCode=\(home_area_code)&hanOk=\(hanok_ok)&benikia=\(benikia_ok)&goodStay=\(goodstay_ok)"))!)!
        
        print("폐지 넘버 : \(home_page_number), 지역 코드 : \(home_area_code), 한옥 : \(hanok_ok)")
        parser.delegate = self
        parser.parse()
        
        home_tableview!.reloadData()
    }
    
    @IBAction func hanok_switch(_ sender: Any) {
        if hanok_ok == 0 {
            hanok_ok = 1
        }else{
            hanok_ok = 0
        }
    }
    @IBAction func benikia_switch(_ sender: Any) {
        if benikia_ok == 0 {
            benikia_ok = 1
        }else{
            benikia_ok = 0
        }
    }
    @IBAction func goodstay_swtich(_ sender: Any) {
        if goodstay_ok == 0 {
            goodstay_ok = 1
        }else{
            goodstay_ok = 0
        }
    }
    
    @IBOutlet weak var home_picker: UIPickerView!
    
    
    var picker_data_source = [ "서울", "인천", "대전", "대구", "광주", "부산", "울산", "세종" ]
    var home_area_code : String = "1"
    var home_page_number : Int = 1
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker_data_source.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker_data_source[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            home_area_code = "1"    // 서울
            home_page_number = 1
        }else if row == 1{
            home_area_code = "2"    // 인천
            home_page_number = 1
        }else if row == 2{
            home_area_code = "3"    // 대전
            home_page_number = 1
        }else if row == 3{
            home_area_code = "4"     // 강원
            home_page_number = 1
        }else if row == 4{
            home_area_code = "5"     // 강원
            home_page_number = 1
        }else if row == 5{
            home_area_code = "6"     // 강원
            home_page_number = 1
        }else if row == 6{
            home_area_code = "7"     // 강원
            home_page_number = 1
        }else if row == 7{
            home_area_code = "8"     // 강원
            home_page_number = 1
        }else if row == 8{
            home_area_code = "9"     // 강원
            home_page_number = 1
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homestay_background.jpeg")!)
        self.home_picker.delegate = self
        self.home_picker.dataSource = self
        
        self.home_tableview.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueHomeDetail"{
            if let cell = sender as? UITableViewCell{
                let indexPath = home_tableview.indexPath(for: cell)
                home_title = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "title") as! NSString as String as! NSMutableString
                home_image = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "firstimage") as! NSString as String as! NSMutableString
                home_tel = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "tel") as! NSString as String as! NSMutableString
                home_addr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "addr1") as! NSString as String as! NSMutableString
                home_pos_x = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapx") as! NSString as String as! NSMutableString
                home_pos_y = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapy") as! NSString as String as! NSMutableString
                if let viewcon_detail = segue.destination as? TableViewController_FindHome_Detail{
                    viewcon_detail.detail_title = home_title
                    viewcon_detail.detail_tel = home_tel
                    viewcon_detail.detail_addr = home_addr
                    viewcon_detail.detail_url = home_image
                    viewcon_detail.detail_x_pos = home_pos_x
                    viewcon_detail.detail_y_pos = home_pos_y
                }
            }
        }
        
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
