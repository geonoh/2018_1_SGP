//
//  ViewController_Festival.swift
//  Travel_여행 갈래?
//
//  Created by 오건 on 2018. 5. 27..
//  Copyright © 2018년 오건. All rights reserved.
//

import UIKit
import Speech

class ViewController_Festival: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var city_picker: UIPickerView!
    @IBOutlet weak var Festival_data: UITableView!
    
    @IBOutlet weak var transcribe_button: UIButton!
    @IBOutlet weak var stop_button: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
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
        switch (self.myTextView.text) {
            
        case "서울" : self.city_picker.selectRow(0, inComponent: 0, animated: true)
            break
        case "인천" : self.city_picker.selectRow(1, inComponent: 0, animated: true)
            break
        case "대전" : self.city_picker.selectRow(2, inComponent: 0, animated: true)
            break
        case "대구" : self.city_picker.selectRow(3, inComponent: 0, animated: true)
            break
        default:break
        }
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
