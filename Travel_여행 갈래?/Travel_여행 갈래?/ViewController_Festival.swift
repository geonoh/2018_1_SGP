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
    
    var picker_data_source = [ "서울", "인천", "대전", "대구", "광주", "부산", "울산", "세종" ]
    
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&pageNo=1&startPage=1&numOfRows=10&pageSize=10&MobileApp=AppTest&MobileOS=ETC&arrange=A&contentTypeId=15&areaCode=1&listYN=Y"
    
    var area_code : String = "1&listYN=Y"        // 디폴트 시 코드 -> 서울
    
    
    @IBAction func search_button(_ sender: Any) {
        print("검색 버튼")
    }
    
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
            area_code = "1&listYN=Y"    // 서울
        }else if row == 1{
            area_code = "2&listYN=Y"    // 인천
        }else if row == 2{
            area_code = "3&listYN=Y"    // 대전
        }else if row == 3{
            area_code = "4&listYN=Y"     // 강원
        }else if row == 4{
            area_code = "4&listYN=Y"     // 강원
        }else if row == 5{
            area_code = "4&listYN=Y"     // 강원
        }else if row == 6{
            area_code = "4&listYN=Y"     // 강원
        }else if row == 7{
            area_code = "4&listYN=Y"     // 강원
        }else if row == 8{
            area_code = "4&listYN=Y"     // 강원
        }
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
