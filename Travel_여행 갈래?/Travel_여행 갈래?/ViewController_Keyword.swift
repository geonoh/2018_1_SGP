//
//  ViewController2.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 27..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit

class ViewController_Keyword: UIViewController, XMLParserDelegate, UITableViewDataSource {
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var event_title = NSMutableString()
    var event_addr = NSMutableString()
    var event_tel = NSMutableString()
    
    var event_pos_x = NSMutableString()
    var event_pos_y = NSMutableString()
    
    var test_title1 = NSMutableString()
    var test_date = NSMutableString()
    
    
    
    @IBAction func TestButton(_ sender: Any) {
        print("눌러쪄요2")
    }
    
    @IBOutlet weak var keyword_data: UITableView!
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            
            /*
            elements = NSMutableDictionary()
            elements = [:]
            event_title = NSMutableString()
            event_title = ""
            event_tel = NSMutableString()
            event_tel = ""
            event_addr = NSMutableString()
            event_addr = ""
            event_pos_x = NSMutableString()
            event_pos_x = ""
            event_pos_y = NSMutableString()
            event_pos_y = ""
            */
            
            
            elements = NSMutableDictionary()
            elements = [:]
            test_title1 = NSMutableString()
            test_title1 = ""
            test_date = NSMutableString()
            test_date = ""
            
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        /*
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
        */
        
        if element.isEqual(to: "title"){
            test_title1.append(string)
        }
        else if element.isEqual(to: "pubDate"){
            test_date.append(string)
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        /*
        if (elementName as NSString).isEqual(to: "item"){
            
            if !event_title.isEqual(nil){
                elements.setObject(event_title, forKey: "title" as NSCopying)
            }
            if !event_addr.isEqual(nil){
                elements.setObject(event_addr, forKey: "addr1" as NSCopying)
            }
            /*
            if !event_tel.isEqual(nil){
                elements.setObject(event_tel, forKey: "tel" as NSCopying)
            }
            if !event_pos_x.isEqual(nil){
                elements.setObject(event_pos_x, forKey: "mapx" as NSCopying)
            }
            if !event_pos_y.isEqual(nil){
                elements.setObject(event_pos_y, forKey: "mapy" as NSCopying)
            }
             */
            posts.add(elements)
        }
        */
        
        
        if (elementName as NSString).isEqual(to: "item"){
            if !test_title1.isEqual(nil){
                elements.setObject(test_title1, forKey: "title" as NSCopying)
            }
            if !test_date.isEqual(nil){
                elements.setObject(test_date, forKey: "date" as NSCopying)
            }
            posts.add(elements)
        }
 
        
 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        
        //cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
 
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "date") as! NSString as String
        return cell
    }
    
    
    func beginParsing(){
        posts = []
        
        //parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&MobileApp=AppTest&MobileOS=ETC&pageNo=1&startPage=1&numOfRows=10&pageSize=10&listYN=Y&arrange=A&contentTypeId=12&keyword=%EA%B0%95%EC%9B%90"))!)!
        
        
        parser = XMLParser(contentsOf: (URL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss"))!)!
        parser.delegate = self
        parser.parse()
        keyword_data!.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("최초 실행할게요")
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
