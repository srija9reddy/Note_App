//
//  HomeVc.swift
//  NoteApp
//
//

import UIKit
import IQKeyboardManagerSwift

class HomeVc: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var notesList_TableView: UITableView!
    @IBOutlet weak var addNoteBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var resetSearch: UIButton!
    
    
    var allData = [[String:AnyObject]]()
    var removedArray = [Int]()
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        notesList_TableView.delegate = self
        notesList_TableView.dataSource = self
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetSearch.isHidden = true
        self.searchTF.text! = ""
        
        self.loadData()
    }
    //MARK:- IBACTIONS
    @IBAction func searchBtnAction(_ sender: UIButton) {
        self.allData = self.searchRecommendation(name: searchTF.text!)
        self.notesList_TableView.reloadData()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            self.resetSearch.isHidden = false
        }
        
    }
    
    @IBAction func addNoteAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteVc") as! AddNoteVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sortBtnAction(_ sender: UIButton) {
        self.showPopup()
    }
    
    @IBAction func resetSearchAction(_ sender: UIButton) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            self.resetSearch.isHidden = true
            self.loadData()
            self.searchTF.text! = ""
            self.searchTF.resignFirstResponder()
        }
    }
    
    func loadData(){
        self.allData = self.readAllData()
        self.notesList_TableView.reloadData()
    }
    
    func showPopup(){
        let alert1 = UIAlertController(title: nil, message: "Sort By", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Name ", style: .default) { re in
            self.allData = self.allData.sorted { self.itemsSort(p1:$0, p2:$1)}
            self.notesList_TableView.reloadData()
        }
        
        let action2 = UIAlertAction(title: "Time date", style: .default) { r in
            self.loadData()
        }
        let action3 = UIAlertAction(title: "Cancel", style: .default) { r in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert1.addAction(action1)
        alert1.addAction(action2)
        alert1.addAction(action3)
        self.present(alert1, animated: true, completion: nil)
    }
    
    func searchRecommendation(name: String) -> [[String:AnyObject]]{
        print(name, "is searched")
        var result = [[String:AnyObject]]()
         if name.replacingOccurrences(of: " ", with: "") != ""{
            for i in 0..<(allData.count){
             let name1 = allData[i]["name"] as? String ?? ""
            let descr1 = allData[i]["description"] as? String ?? ""
                if (name1.contains(name)) || (descr1.contains(name)){
                    result.append(allData[i])
                }
            }
            return result
        }
        return result
    }
    
    
}


//MARK:- TABLEVIEW DELEGATES & DATA SOURCES
extension HomeVc : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func itemsSort(p1:[String:Any], p2:[String:Any]) -> Bool {
        guard let s1 = p1["name"] as? String, let s2 = p2["name"] as? String else {
            return false
        }
        return s1 < s2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
        let value = allData[indexPath.row]
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
        vc.noteData = self.allData[indexPath.row]
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
