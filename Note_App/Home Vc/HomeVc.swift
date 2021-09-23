//
//  HomeVc.swift
//  NoteApp
//
//

import UIKit

class HomeVc: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var notesList_TableView: UITableView!
    @IBOutlet weak var addNoteBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBACTIONS
    @IBAction func searchBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func addNoteAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteVc") as! AddNoteVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sortBtnAction(_ sender: UIButton) {
        
    }
}
