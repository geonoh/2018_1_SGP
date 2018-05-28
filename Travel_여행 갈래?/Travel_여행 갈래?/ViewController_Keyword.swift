//
//  ViewController2.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 27..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit

class ViewController_Keyword: UIViewController, XMLParserDelegate, UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate {
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var event_title = NSMutableString()
    var event_tel = NSMutableString()
    var event_url = NSMutableString()
    var event_addr = NSMutableString()
    var event_pos_x = NSMutableString()
    var event_pos_y = NSMutableString()
    
    var page_num : Int = 1
    
    @IBOutlet weak var search_box: UITextField!
    
    @IBAction func prev_search_button(_ sender: Any) {
        if page_num > 1{
            page_num -= 1
            beginParsing()
        }
    }
    @IBAction func next_search_button(_ sender: Any) {
        page_num += 1
        beginParsing()
    }
    var utf_8_parsing = ""
    //var page_num = ""
    
    let test_ = ViewController_Keyword_Detail()
    
    
    @IBAction func TestButton(_ sender: Any) {
        print("눌러쪄요2")
        beginParsing()
        
    }
    
    @IBOutlet weak var keyword_data: UITableView!
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            
            
            elements = NSMutableDictionary()
            elements = [:]
            event_title = NSMutableString()
            event_title = ""
            event_tel = NSMutableString()
            event_tel = ""
            event_addr = NSMutableString()
            event_addr = ""
            event_url = NSMutableString()
            event_url = ""
            event_pos_x = NSMutableString()
            event_pos_x = ""
            event_pos_y = NSMutableString()
            event_pos_y = ""
 
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element.isEqual(to: "title"){
            event_title.append(string)
        }
        else if element.isEqual(to: "addr1"){
            event_addr.append(string)
        }
        else if element.isEqual(to: "tel"){
            event_tel.append(string)
        }
        else if element.isEqual(to: "mapx"){
            event_pos_x.append(string)
        }
        else if element.isEqual(to: "mapy"){
            event_pos_y.append(string)
        }
        else if element.isEqual(to: "firstimage"){
            event_url.append(string)
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if (elementName as NSString).isEqual(to: "item"){
            
            if !event_title.isEqual(nil){
                elements.setObject(event_title, forKey: "title" as NSCopying)
            }
            if !event_addr.isEqual(nil){
                elements.setObject(event_addr, forKey: "addr1" as NSCopying)
            }
            
            if !event_tel.isEqual(nil){
                elements.setObject(event_tel, forKey: "tel" as NSCopying)
            }
            if !event_pos_x.isEqual(nil){
                elements.setObject(event_pos_x, forKey: "mapx" as NSCopying)
            }
            if !event_pos_y.isEqual(nil){
                elements.setObject(event_pos_y, forKey: "mapy" as NSCopying)
            }
            if !event_url.isEqual(nil){
                elements.setObject(event_url, forKey: "firstimage" as NSCopying)
            }
            
            posts.add(elements)
        }
 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        
        return cell
    }
    
    
    
    
    func beginParsing(){
        utf_8_parsing = search_box.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        posts = []
        
        parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&MobileApp=AppTest&MobileOS=ETC&pageNo=\(page_num)&startPage=1&numOfRows=10&pageSize=10&listYN=Y&arrange=A&contentTypeId=12&keyword=\(utf_8_parsing)"))!)!
        
        parser.delegate = self
        parser.parse()
        keyword_data!.reloadData()
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToDetailView"{
            if let cell = sender as? UITableViewCell{
                let indexPath = keyword_data.indexPath(for: cell)
                event_title = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "title") as! NSString as String as! NSMutableString
                event_url = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "firstimage") as! NSString as String as! NSMutableString
                event_tel = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "tel") as! NSString as String as! NSMutableString
                event_addr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "addr1") as! NSString as String as! NSMutableString
                event_pos_x = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapx") as! NSString as String as! NSMutableString
                event_pos_y = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapy") as! NSString as String as! NSMutableString
                if let viewcon_detail = segue.destination as? ViewController_Keyword_Detail{
                    viewcon_detail.detail_title = event_title
                    viewcon_detail.detail_tel = event_tel
                    viewcon_detail.detail_addr = event_addr
                    viewcon_detail.detail_url = event_url
                    viewcon_detail.detail_x_pos = event_pos_x
                    viewcon_detail.detail_y_pos = event_pos_y
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.search_box.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
}
