//
//  NoteDetailVc.swift
//  Note_App
//
//

import UIKit

class NoteDetailVc: UIViewController {
    
    //MARK:- IBOUTLETS
    @IBOutlet weak var noteTitleTF: UITextField!
    @IBOutlet weak var categoryTF: DropDown!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var playAudioBtn: UIButton!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var saveChangeBtn: UIButton!
    
    //MARK:- VARIABLES
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK:- IBACTIONS
    @IBAction func playAudioAction(_ sender: UIButton) {
        
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        
    }
    
}
