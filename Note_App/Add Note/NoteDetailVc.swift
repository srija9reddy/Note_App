//
//  NoteDetailVc.swift
//  Note_App
//
//

import UIKit
import MapKit

class NoteDetailVc: UIViewController {
    
    //MARK:- IBOUTLETS
    @IBOutlet weak var noteTitleTF: UITextField!
    @IBOutlet weak var categoryTF: DropDown!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var playAudioBtn: UIButton!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var saveChangeBtn: UIButton!
    @IBOutlet weak var appleMapView: MKMapView!
    @IBOutlet weak var backBtn: UIButton!
    
    
    //MARK:- VARIABLES
    var noteData = [String:AnyObject]()
    var index = -1
    var imagesArray = [UIImage]()
    var categoryArray = ["Category 1", "Category 2", "Category 3", "Category 4", "Category 5"]
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        imgCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    
    //MARK:- IBACTIONS
    @IBAction func playAudioAction(_ sender: UIButton) {
        
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        
    }
    
    //MARK:- USER DEFINED FUNCTIONS
    func loadData(){
        //        let noteName = input["name"]
        //        let noteImages : [UIImage] = input["images"] as! [UIImage]
        //        let noteDescription = input["description"]
        //        let category = input["category"]
        //        let audioPath = input["audioPath"]
        self.categoryTF.isSearchEnable = false
        self.categoryTF.optionArray = self.categoryArray
        self.saveChangeBtn.layer.cornerRadius = 15
        self.playAudioBtn.layer.cornerRadius = 15
        self.noteTitleTF.text! = noteData["name"] as? String ?? ""
        self.categoryTF.text! = noteData["category"] as? String ?? ""
        let lattitude = noteData["lattitude"] as? Double ?? 0.0
        let longgitude = noteData["longitude"] as? Double ?? 0.0
        self.descriptionTF.text = noteData["description"] as? String ?? ""
        let locationCoordinates = CLLocation.init(latitude: lattitude, longitude: longgitude)
        let viewRegion = MKCoordinateRegion(center: locationCoordinates.coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        self.appleMapView.setRegion(viewRegion, animated: true)
        if let images = noteData["images"] as? [UIImage]{
            for i in 0..<(images.count){
                self.imagesArray.append(images[i])
            }
            self.imgCollectionView.reloadData()
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension NoteDetailVc : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteDetailCollectionCell", for: indexPath) as! NoteDetailCollectionCell
        cell.imgBackView.layer.cornerRadius = 8
        cell.imgBackView.layer.borderWidth = 1
        cell.imgView.image = imagesArray[indexPath.row]
        return cell
    }
    
    
}

