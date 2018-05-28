//
//  ViewController_Keyword_Detail.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 28..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit

class ViewController_Keyword_Detail: UITableViewController, XMLParserDelegate {
    var detail_parser = XMLParser()
    var detail_posts = NSMutableArray()
    
    
    @IBOutlet var tableview_detail: UITableView!
    
    var detail_elements = NSMutableDictionary()
    var detail_element = NSString()
    
    var detail_title = NSMutableString()
    var detail_tel = NSMutableString()
    var detail_url = NSMutableString()
    var detail_addr = NSMutableString()
    
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        detail_element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            
            
            detail_elements = NSMutableDictionary()
            detail_elements = [:]
            detail_title = NSMutableString()
            detail_title = ""
            detail_tel = NSMutableString()
            detail_tel = ""
            detail_url = NSMutableString()
            detail_url = ""
            detail_addr = NSMutableString()
            detail_addr = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if detail_element.isEqual(to: "title"){
            detail_title.append(string)
        }
        else if detail_element.isEqual(to: "addr1"){
            detail_addr.append(string)
        }
        else if detail_element.isEqual(to: "tel"){
            detail_tel.append(string)
        }
        else if detail_element.isEqual(to: "firstimage"){
            detail_url.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if (elementName as NSString).isEqual(to: "item"){
            
            if !detail_title.isEqual(nil){
                detail_elements.setObject(detail_title, forKey: "title" as NSCopying)
            }
            if !detail_addr.isEqual(nil){
                detail_elements.setObject(detail_addr, forKey: "addr1" as NSCopying)
            }
            if !detail_url.isEqual(nil){
                detail_elements.setObject(detail_url, forKey: "firstimage" as NSCopying)
            }
            if !detail_tel.isEqual(nil){
                detail_elements.setObject(detail_tel, forKey: "tel" as NSCopying)
            }
 
            detail_posts.add(detail_elements)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return detail_posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        cell.textLabel?.text = (detail_posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        
        //cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "date") as! NSString as String
        return cell
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview_detail!.reloadData()
        print("되여")
        print("\(self.detail_title)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
