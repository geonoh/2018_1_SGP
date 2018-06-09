//
//  ViewController_Festival.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 27..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit
import Speech

class ViewController_Festival: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, XMLParserDelegate {
    
    @IBOutlet weak var city_picker: UIPickerView!
    @IBOutlet weak var Festival_data: UITableView!
    
    @IBOutlet weak var transcribe_button: UIButton!
    @IBOutlet weak var stop_button: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
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
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element.isEqual(to: "title"){
            festival_title.append(string)
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
        else if element.isEqual(to: "eventstartdate"){
            festival_start_date.append(string)
        }
        else if element.isEqual(to: "eventenddate"){
            festival_end_date.append(string)
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if (elementName as NSString).isEqual(to: "item"){
            
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
            if !festival_start_date.isEqual(nil){
                elements.setObject(festival_start_date, forKey: "firstimage" as NSCopying)
            }
            if !festival_end_date.isEqual(nil){
                elements.setObject(festival_end_date, forKey: "firstimage" as NSCopying)
            }
            posts.add(elements)
        }
        
    }
    
    
    func beginParsing(){
        posts = []
        
        parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=mGH1c982sz0WTiO2OmDl4dZQpHXUwlQiy5zeez6B0VjW%2BnSVROWPq1rgodlUVajH4QSXSuPGLG8htc2eXOqgaQ%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&listYN=Y&eventStartDate=\(start_date)"))!)!
        
        parser.delegate = self
        parser.parse()
    }
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    private var speechRecognitionRequest:
    SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    
    @IBAction func start_transcirbe(_ sender: Any) {
        transcribe_button.isEnabled = false
        stop_button.isEnabled = true
        try! startSession()
    }
    @IBAction func stop_transcribe(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribe_button.isEnabled = true
            stop_button.isEnabled = false
        }
        print("눌렷냐")
        let fularray = self.myTextView.text.components(separatedBy: " ")
        
        let abcd : Int? = Int(fularray[0])
        print("\(String(describing: abcd)) 이거 되면 너무 좋겠다")
        
        
        var real_buff = fularray[0].split(separator: "년")
        var bufff = fularray[0].suffix(4)
        
        print("\(real_buff[0]) 아 제발요 형님 시발")
        print("\(fularray[0])에 년도 드렁와랑")
        print("\(fularray[1])에 월 드렁와랑")
        // 월은 무조건 MM 형식이어야한다.
        
        print("\(fularray[2])에 일 드렁와랑")

        
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
            area_code = "5&listYN=Y"     // 강원
        }else if row == 5{
            area_code = "6&listYN=Y"     // 강원
        }else if row == 6{
            area_code = "7&listYN=Y"     // 강원
        }else if row == 7{
            area_code = "8&listYN=Y"     // 강원
        }else if row == 8{
            area_code = "9&listYN=Y"     // 강원
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.city_picker.delegate = self
        self.city_picker.dataSource = self
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "festival_background.jpeg")!)
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
