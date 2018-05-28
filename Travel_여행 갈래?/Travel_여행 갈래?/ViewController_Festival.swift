//
//  ViewController_Festival.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 27..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit

class ViewController_Festival: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var city_picker: UIPickerView!
    @IBOutlet weak var Festival_data: UITableView!
    
    var picker_data_source = [ "서울시", "경기", "인천시", "강원" ]
    
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&pageNo=1&startPage=1&numOfRows=10&pageSize=10&MobileApp=AppTest&MobileOS=ETC&arrange=A&contentTypeId=15&areaCode=1&listYN=Y"
    
    var area_code : String = "1&listYN=Y"        // 디폴트 시 코드 -> 서울
    
    
    @IBAction func search_button(_ sender: Any) {
        print("검색 버튼")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.city_picker.delegate = self
        self.city_picker.dataSource = self
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
