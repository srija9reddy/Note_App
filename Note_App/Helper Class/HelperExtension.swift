//
//  HelperExtension.swift
//  Note_App
//
//
import UIKit

extension UIViewController{
    
    func currentTimeInMilliSeconds()-> Int {
            let currentDate = Date()
            let since1970 = currentDate.timeIntervalSince1970
            return Int(since1970 * 1000)
        }
    
    func saveData(input : [String:Any]) -> Bool{
//        let noteName = input["name"]
//        let noteImages : [UIImage] = input["images"] as! [UIImage]
//        let noteDescription = input["description"]
//        let category = input["category"]
//        let audioPath = input["audioPath"]
    //    UserDefaults.standard.setValue(input, forKey: "\(input["name"] as? String ?? "")")
        let inndex = String(describing: (UserDefaults.standard.value(forKey: "index") as? Int ?? 1))
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: input), forKey: inndex)
       // print("note saved", UserDefaults.standard.value(forKey: (input["name"] as? String ?? "")))
        if let newObject = UserDefaults.standard.value(forKey: inndex) as? NSData {
            
            print(NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: inndex) as! Data) as! [String: AnyObject], "saved data")
            return true
        }
        else{
            self.showAlert(title: "Error", message: "Something went wrong") { r in
                
            }
            return false
        }
        return true
    }
    
    func showAlert(title: String, message: String,outputBlock:@escaping (_ okAction: UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (res) in
            outputBlock(res)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func readAllData() -> [[String:AnyObject]]{
        var dataValue = [[String:AnyObject]]()
        //        let noteName = input["name"]
        //        let noteImages : [UIImage] = input["images"] as! [UIImage]
        //        let noteDescription = input["description"]
        //        let category = input["category"]
        //        let audioPath = input["audioPath"]
        let indexCount = UserDefaults.standard.value(forKey: "index") as? Int ?? 0
        for i in 0..<(indexCount){
            let indexName = String(describing: i)
            let readIndex = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: indexName) as! Data) as! [String: AnyObject]
            dataValue.append(readIndex)
        }
        return dataValue
    }
}

var appIndex = UserDefaults.standard.value(forKey: "index")
