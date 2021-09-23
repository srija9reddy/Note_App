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
    
    //MARK:- VARIABLES
    var noteData = [String:AnyObject]()
    var index = -1
    var imagesArray = [UIImage]()
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        imgCollectionView.dataSource = self
    }
    
    
    //MARK:- IBACTIONS
    @IBAction func playAudioAction(_ sender: UIButton) {
        
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        
    }
    
    //MARK:- USER DEFINED FUNCTIONS

    
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

