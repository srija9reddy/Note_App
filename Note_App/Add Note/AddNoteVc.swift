//
//  AddNoteVc.swift
//  Note_App
//
//

import UIKit
import AVFoundation
import CoreLocation
import IQKeyboardManagerSwift

class AddNoteVc: UIViewController {
    //MARK:- IBOUTLETS
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var recordAudioBtn: UIButton!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    

    //MARK:- VARIABLES
    var imgPicker = UIImagePickerController()
    var imgArray = [UIImage]()
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var categoryArray = ["Category 1", "Category 2", "Category 3", "Category 4", "Category 5"]
    var locationManager: CLLocationManager!
    var audioPath = ""
   
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        Delegates()
        self.categoryDropDown.optionArray = categoryArray
        self.determineMyCurrentLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.locationManager.stopUpdatingLocation()
    }
    //MARK:- IBACTIONS
    @IBAction func saveBtnAction(_ sender: UIButton) {
        if self.titleTF.text?.replacingOccurrences(of: " ", with: "") == ""{
            self.showAlert(title: "Please Check", message: "Title Can't be blank") { s in
                
            }
        }
        else if self.categoryDropDown.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.showAlert(title: "Please Check", message: "Please Choose Category") { s in
                
            }
        }
        else if self.descriptionTF.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.showAlert(title: "Please Check", message: "Please Enter Description") { s in
                
            }
        }
        else{
            self.saveNote()
        }
    }
    
    @IBAction func addImgAction(_ sender: UIButton) {
       showPopup()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- USER DEFINED FUNCTIONS
    func showPopup(){
        let alert1 = UIAlertController(title: nil, message: "Add Image to Note", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Capture Image", style: .default) { re in
            self.imgPicker.sourceType = .camera
            self.navigationController?.present(self.imgPicker, animated: true, completion: nil)
        }
       
        let action2 = UIAlertAction(title: "Choose From Gallery", style: .default) { r in
            self.imgPicker.sourceType = .photoLibrary
            self.navigationController?.present(self.imgPicker, animated: true, completion: nil)
        }
        let action3 = UIAlertAction(title: "Cancel", style: .default) { r in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert1.addAction(action1)
        alert1.addAction(action2)
        alert1.addAction(action3)
        self.present(alert1, animated: true, completion: nil)
    }
    
    func loadRecordingUI() {
        recordAudioBtn.setTitle("Tap to Record", for: .normal)
        recordAudioBtn.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func saveNote(){
        Indicator.shared.showProgressView(self.view)
        //        let noteName = input["name"]
        //        let noteImages : [UIImage] = input["images"] as! [UIImage]
        //        let noteDescription = input["description"]
        //        let category = input["category"]
        //        let audioPath = input["audioPath"]
        let data = ["name":self.titleTF.text!, "images":self.imgArray, "description": self.descriptionTF.text!, "category": self.categoryDropDown.text!, "audioPath": self.audioPath, "time": self.currentTimeInMilliSeconds()] as! [String : Any]
       let res = self.saveData(input: data)
        print(UserDefaults.standard.value(forKey: "index"),"is index")
        if res{
            let number = UserDefaults.standard.value(forKey: "index") as? Int ?? 1
            Indicator.shared.hideProgressView()
            UserDefaults.standard.setValue((number) + (1), forKey: "index")
            self.showAlert(title: "Yeah", message: "Note has been saved") { re in
                self.navigationController?.popViewController(animated: true)
            }
        }
        else{
            Indicator.shared.hideProgressView()
        }
        
        
    }
    
    func Delegates(){
        self.descriptionTF.layer.borderWidth = 0.5
        IQKeyboardManager.shared.enable = true
        imgPicker.delegate = self
        self.recordAudioBtn.layer.cornerRadius = 15
        self.saveBtn.layer.cornerRadius = 15
        imageCollectionView.dataSource = self
        self.categoryDropDown.isSearchEnable = false
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        loadRecordingUI()
                        print("recording permission allowed")
                    } else {
                        print("failed to record!")
                    }
                }
            }
        } catch {
            
        }
    }
}

//MARK:- IMAGE PICKER DELEGATES
extension AddNoteVc : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imgArray.append(selectedImage)
        self.imageCollectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK:- IMAGE COLLECTIONVIEW DELGATES & DATA SOURCES
extension AddNoteVc :  UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNoteImageCollectionCell", for: indexPath) as! AddNoteImageCollectionCell
        cell.imgBackView.layer.cornerRadius = 8
        cell.imgBackView.layer.borderWidth = 1
        cell.imgView.image = imgArray[indexPath.row]
        cell.deleteImgBtn.addTarget(self, action: #selector(removeIMg(sender:)), for: .touchUpInside)
        cell.deleteImgBtn.tag = indexPath.row
        return cell
    }
    
    @objc func removeIMg(sender:UIButton){
        self.imgArray.remove(at: sender.tag)
        self.imageCollectionView.reloadData()
    }
}

//MARK:- RECORD AUDIO DELEGATES
extension AddNoteVc :  AVAudioRecorderDelegate{
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordAudioBtn.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordAudioBtn.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordAudioBtn.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        do{
           // let recorData = try Data(contentsOf: recorder.url)
            print(recorder.url, "is recording data")
            self.audioPath = String(describing: recorder.url)
        }
        catch{
            
        }

        if !flag {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0], "recording path")
        return paths[0]
    }
}


//MARK:- FETCH USER'S CURRENT LOCATION
extension AddNoteVc : CLLocationManagerDelegate{
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)  {
        print("Error \(error)")
//        self.showAlert(title: "Location Permission Error", message: "Please Check Location Permission in Device Settings") { r in
//
//        }
    }
}


