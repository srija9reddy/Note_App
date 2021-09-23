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
    
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBACTIONS
    @IBAction func searchBtnAction(_ sender: UIButton) {
        
    }
}
