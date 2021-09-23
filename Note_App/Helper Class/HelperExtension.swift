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
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        //07/21/2021 01:36:31
        //2021-09-23 10:16:23 +0000
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss Z"
        //dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:s"
        //2021-07-29 21:43:28
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MMM d, yyyy hh:mm:a"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func loadDate(ms: Int) -> String{
        let milisecond = ms
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)/1000)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        let datee = dateFormatter.string(from: dateVar)
        print(dateFormatter.string(from: dateVar))
        return datee
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
        for i in 1..<(indexCount){
            let indexName = String(describing: i)
            if let readIndex = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: indexName) as! Data) as? [String: AnyObject]{
                dataValue.append(readIndex)
            }
           // let readIndex = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: indexName) as! Data) as! [String: AnyObject]
          
        }
        return dataValue
    }
}

var appIndex = UserDefaults.standard.value(forKey: "index")
