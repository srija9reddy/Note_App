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
    
    
    var allData = [[String:AnyObject]]()
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        notesList_TableView.delegate = self
        notesList_TableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
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
    
    func loadData(){
       print( self.readAllData())
    }
}


//MARK:- TABLEVIEW DELEGATES & DATA SOURCES
extension HomeVc : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
        return cell
    }
    
    
}
