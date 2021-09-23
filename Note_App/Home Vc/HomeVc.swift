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
        self.allData = self.readAllData()
        self.notesList_TableView.reloadData()
    }
}


//MARK:- TABLEVIEW DELEGATES & DATA SOURCES
extension HomeVc : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
        let value = allData[indexPath.row]
        //        let noteName = input["name"]
        //        let noteImages : [UIImage] = input["images"] as! [UIImage]
        //        let noteDescription = input["description"]
        //        let category = input["category"]
        //        let audioPath = input["audioPath"]
        cell.noteLabel.text = value["name"] as? String ?? "note title"
        cell.noteDescriptionLabel.text = value["description"] as? String ?? "description"
        let newDate = Date(timeIntervalSince1970: (Double((value["time"] as? Int ?? 0)) / 1000.0))
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        cell.noteUploadedLabel.text = self.utcToLocal(dateStr: df.string(from: newDate))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailVc") as! NoteDetailVc
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
