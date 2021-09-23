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

    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBACTIONS
    @IBAction func saveBtnAction(_ sender: UIButton) {
    
    }
    
    @IBAction func addImgAction(_ sender: UIButton) {
       
    }
}
