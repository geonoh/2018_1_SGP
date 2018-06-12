//
//  ViewController_Festival.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 27..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit
import Speech

class ViewController_Festival: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, XMLParserDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var city_picker: UIPickerView!
    
    @IBOutlet weak var search_button_inter: UIButton!
    @IBOutlet weak var Festival_data: UITableView!
    
    @IBOutlet weak var transcribe_button: UIButton!
    @IBOutlet weak var stop_button: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    var page_num : Int = 1
    
    @IBAction func prev_button(_ sender: Any) {
        if page_num > 1 {
            page_num -= 1
            beginParsing()
        }
    }
    
    @IBAction func next_button(_ sender: Any) {
        page_num += 1
        beginParsing()
    }
    
    @IBAction func search_button(_ sender: Any) {
        //print("검색 버튼")
        let explore = ExplodeView(frame: CGRect(x: (search_button_inter.imageView?.center.x)!, y:(search_button_inter.imageView?.center.y)!,width: 10, height: 10))
        search_button_inter.imageView?.superview?.addSubview(explore)
        search_button_inter.imageView?.superview?.sendSubview(toBack: explore)
        beginParsing()
    }
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var festival_title = NSMutableString()
    var festival_addr = NSMutableString()
    var festival_tel = NSMutableString()
    var festival_image = NSMutableString()
    var festival_pos_x = NSMutableString()
    var festival_pos_y = NSMutableString()
    var festival_start_date = NSMutableString()
    var festival_end_date = NSMutableString()
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var start_date = NSMutableString()
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            
            
            elements = NSMutableDictionary()
            elements = [:]
            festival_title = NSMutableString()
            festival_title = ""
            festival_tel = NSMutableString()
            festival_tel = ""
            festival_addr = NSMutableString()
            festival_addr = ""
            festival_image = NSMutableString()
            festival_image = ""
            festival_pos_x = NSMutableString()
            festival_pos_x = ""
            festival_pos_y = NSMutableString()
            festival_pos_y = ""
            festival_start_date = NSMutableString()
            festival_start_date = ""
            festival_end_date = NSMutableString()
            festival_end_date = ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)

        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        
        return cell
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element.isEqual(to: "title"){
            festival_title.append(string)
        }
        else if element.isEqual(to: "eventstartdate"){
            festival_start_date.append(string)
        }
        else if element.isEqual(to: "eventenddate"){
            festival_end_date.append(string)
        }
        else if element.isEqual(to: "addr1"){
            festival_addr.append(string)
        }
        else if element.isEqual(to: "tel"){
            festival_tel.append(string)
        }
        else if element.isEqual(to: "mapx"){
            festival_pos_x.append(string)
        }
        else if element.isEqual(to: "mapy"){
            festival_pos_y.append(string)
        }
        else if element.isEqual(to: "firstimage"){
            festival_image.append(string)
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if (elementName as NSString).isEqual(to: "item"){
            if !festival_start_date.isEqual(nil){
                elements.setObject(festival_start_date, forKey: "eventstartdate" as NSCopying)
                
            }
            if !festival_end_date.isEqual(nil){
                elements.setObject(festival_end_date, forKey: "eventenddate" as NSCopying)
            }
            if !festival_title.isEqual(nil){
                elements.setObject(festival_title, forKey: "title" as NSCopying)
            }
            if !festival_addr.isEqual(nil){
                elements.setObject(festival_addr, forKey: "addr1" as NSCopying)
            }
            
            if !festival_tel.isEqual(nil){
                elements.setObject(festival_tel, forKey: "tel" as NSCopying)
            }
            if !festival_pos_x.isEqual(nil){
                elements.setObject(festival_pos_x, forKey: "mapx" as NSCopying)
            }
            if !festival_pos_y.isEqual(nil){
                elements.setObject(festival_pos_y, forKey: "mapy" as NSCopying)
            }
            if !festival_image.isEqual(nil){
                elements.setObject(festival_image, forKey: "firstimage" as NSCopying)
            }
            
            posts.add(elements)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToFestDetailView"{
            if let cell = sender as? UITableViewCell{
                let indexPath = Festival_data.indexPath(for: cell)
                festival_title = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "title") as! NSString as String as! NSMutableString
                festival_image = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "firstimage") as! NSString as String as! NSMutableString
                festival_tel = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "tel") as! NSString as String as! NSMutableString
                festival_addr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "addr1") as! NSString as String as! NSMutableString
                festival_pos_x = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapx") as! NSString as String as! NSMutableString
                festival_pos_y = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "mapy") as! NSString as String as! NSMutableString
                                
                let buf_start = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "eventstartdate") as! NSString as String
                let buf_end = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "eventenddate") as! NSString as String
                
                
                
                if let festival_detail = segue.destination as? TableViewController_Festival_Detail{
                    festival_detail.detail_title = festival_title
                    festival_detail.detail_tel = festival_tel
                    festival_detail.detail_addr = festival_addr
                    festival_detail.detail_url = festival_image
                    festival_detail.detail_x_pos = festival_pos_x
                    festival_detail.detail_y_pos = festival_pos_y
                    festival_detail.detail_start_date = buf_start
                    festival_detail.detail_end_date = buf_end
                    
                }
            }
        }
        
    }
    
    
    
    func beginParsing(){
        posts = []
        
        parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&numOfRows=10&pageSize=10&pageNo=\(page_num)&startPage=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&listYN=Y&areaCode=\(area_code)&eventStartDate=\(start_date)"))!)!
        
        //print("폐지 넘버 : \(page_num), 지역 코드 : \(area_code), 시작일 : \(start_date)")
        parser.delegate = self
        parser.parse()
        
        Festival_data!.reloadData()
    }
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    private var speechRecognitionRequest:
    SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var button_selector : Bool  = false
    @IBAction func start_transcirbe(_ sender: Any) {
        if(button_selector == false){
            //transcribe_button.isEnabled = false
            stop_button.isEnabled = true
            try! startSession()
            button_selector = true
        }
        else{
            if audioEngine.isRunning {
                audioEngine.stop()
                speechRecognitionRequest?.endAudio()
                //transcribe_button.isEnabled = true
                stop_button.isEnabled = false
            }
            //print("눌렷냐")
            let fularray = self.myTextView.text.components(separatedBy: " ")
            
            var year_buf = fularray[0].split(separator: "년")
            var month_buf = fularray[1].split(separator: "월")
            var day_buf = fularray[2].split(separator: "일")
            
            start_date = ""
            start_date.append(String(year_buf[0]))
            
            // month_buff_under ten
            var month_buf_ut = NSMutableString()
            if(Int(month_buf[0])! < 10){
                month_buf_ut = "0"
                month_buf_ut.append(String(month_buf[0]))
                start_date.append(String(month_buf_ut))
            }else{
                start_date.append(String(month_buf[0]))
            }
            
            // day_buff_under_ten
            var day_buf_ut = NSMutableString()
            if(Int(month_buf[0])! < 10){
                day_buf_ut = "0"
                day_buf_ut.append(String(day_buf[0]))
                start_date.append(String(day_buf_ut))
            }else{
                start_date.append(String(day_buf[0]))
            }
            
            button_selector = false
        }
        
        
    }
    @IBAction func stop_transcribe(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribe_button.isEnabled = true
            stop_button.isEnabled = false
        }
        //print("눌렷냐")
        let fularray = self.myTextView.text.components(separatedBy: " ")
        
        var year_buf = fularray[0].split(separator: "년")
        var month_buf = fularray[1].split(separator: "월")
        var day_buf = fularray[2].split(separator: "일")
        
        start_date = ""
        start_date.append(String(year_buf[0]))
        
        // month_buff_under ten
        var month_buf_ut = NSMutableString()
        if(Int(month_buf[0])! < 10){
            month_buf_ut = "0"
            month_buf_ut.append(String(month_buf[0]))
            start_date.append(String(month_buf_ut))
        }else{
            start_date.append(String(month_buf[0]))
        }
        
        // day_buff_under_ten
        var day_buf_ut = NSMutableString()
        if(Int(month_buf[0])! < 10){
            day_buf_ut = "0"
            day_buf_ut.append(String(day_buf[0]))
            start_date.append(String(day_buf_ut))
        }else{
            start_date.append(String(day_buf[0]))
        }
        
        
        //print("\(start_date)")
    }
    
    func startSession() throws {
        
        if let recognitionTask = speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else { fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed") }
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            
            var finished = false
            
            if let result = result {
                
                self.myTextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribe_button.isEnabled = true
            }
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    var picker_data_source = [ "서울", "인천", "대전", "대구", "광주", "부산", "울산", "세종" ]
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.transcribe_button.isEnabled = true
                    
                case .denied:
                    self.transcribe_button.isEnabled = false
                    
                    
                case .restricted:
                    self.transcribe_button.isEnabled = false
                    
                    
                case .notDetermined:
                    self.transcribe_button.isEnabled = false
                    
                }
            }
        }
    }
    
    
    var area_code : String = "1"        // 디폴트 시 코드 -> 서울
    
    
    
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
            area_code = "1"    // 서울
            page_num = 1
        }else if row == 1{
            area_code = "2"    // 인천
            page_num = 1
        }else if row == 2{
            area_code = "3"    // 대전
            page_num = 1
        }else if row == 3{
            area_code = "4"     // 강원
            page_num = 1
        }else if row == 4{
            area_code = "5"     // 강원
            page_num = 1
        }else if row == 5{
            area_code = "6"     // 강원
            page_num = 1
        }else if row == 6{
            area_code = "7"     // 강원
            page_num = 1
        }else if row == 7{
            area_code = "8"     // 강원
            page_num = 1
        }else if row == 8{
            area_code = "9"     // 강원
            page_num = 1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.city_picker.delegate = self
        self.city_picker.dataSource = self
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "festival_background.jpeg")!)
        Festival_data.dataSource = self
        authorizeSR()
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
