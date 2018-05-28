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
    
    let postname : [String] = ["행사이름", "주소", "전화번호", "행사 포스터", "지도 보기"]
    @IBOutlet var tableview_detail: UITableView!
    
    var detail_elements = NSMutableDictionary()
    var detail_element = NSString()
    
    var detail_title = NSMutableString()
    var detail_tel = NSMutableString()
    var detail_url = NSMutableString()
    var detail_addr = NSMutableString()
    
    var detail_x_pos = NSMutableString()
    var detail_y_pos = NSMutableString()

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapViewSegue"{
            
            if let viewcon_map = segue.destination as? ViewController_MapView{
                viewcon_map.x_pos = detail_x_pos as String
                viewcon_map.y_pos = detail_y_pos as String
                print("맵뷰로 넘겨버리기")
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return detail_posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = postname[indexPath.row]
        cell.detailTextLabel?.text = detail_posts[indexPath.row] as? String
        let string_buf : NSURL = NSURL(string: detail_posts[3] as! String)!
        if let data = try? Data(contentsOf: string_buf as URL){
            if(indexPath.row == 3){
                cell.imageView?.image = UIImage(data: data)
            }
        }
        /*
        // Configure the cell...
        if let url = URL(string: (detail_posts.object(at: indexPath.row) as AnyObject).value(forKey: "url") as! NSString as String){
            if let data = try? Data(contentsOf: url){
                cell.imageView?.image = UIImage(data: data)
            }
        }
        */
        return cell
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Segue_Keyword_Detail"){
            print("Hello World")
            /*
            if let navCon = segue.destination as? UINavigationController{
                if let detail_table_view = navCon.topViewController as? ViewController_Keyword_Detail{
                    detail_table_view.detail_title = "야임마테스트"
                    print("\(detail_table_view.detail_title)")
                    detail_table_view.detail_addr = event_addr
                    detail_table_view.detail_tel = event_tel
                    detail_table_view.detail_url = event_url
                }
            }
            */
        }
    }
    */
    func SetPosts(){
        detail_posts[0] = self.detail_title
        detail_posts[1] = self.detail_addr
        detail_posts[2] = self.detail_tel
        detail_posts[3] = self.detail_url
        detail_posts[4] = self.postname[4]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(self.detail_title)")
        SetPosts()
        tableview_detail!.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
