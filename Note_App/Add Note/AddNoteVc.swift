//
//  AddNoteVc.swift
//  Note_App
//
//

import UIKit

class AddNoteVc: UIViewController {
    //MARK:- IBOUTLETS
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var recordAudioBtn: UIButton!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var addImgBtn: UIButton!
    

    //MARK:- VARIABLES
    var imgPicker = UIImagePickerController()
    var imgArray = [UIImage]()
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate = self
        imageCollectionView.dataSource = self
    }
    
    //MARK:- IBACTIONS
    @IBAction func saveBtnAction(_ sender: UIButton) {
    
    }
    
    @IBAction func addImgAction(_ sender: UIButton) {
       showPopup()
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
        return cell
    }
    
}
