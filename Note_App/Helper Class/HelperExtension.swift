//
//  HelperExtension.swift
//  Note_App
//
//
import UIKit

extension UIViewController{
    
    func saveData(input : [String:Any]) -> Bool{
//        let noteName = input["name"]
//        let noteImages : [UIImage] = input["images"] as! [UIImage]
//        let noteDescription = input["description"]
//        let category = input["category"]
//        let audioPath = input["audioPath"]
    //    UserDefaults.standard.setValue(input, forKey: "\(input["name"] as? String ?? "")")
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: input), forKey: (input["name"] as? String ?? ""))
       // print("note saved", UserDefaults.standard.value(forKey: (input["name"] as? String ?? "")))
        if let newObject = UserDefaults.standard.value(forKey: input["name"] as? String ?? "") as? NSData {
            
            print(NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: input["name"] as? String ?? "") as! Data) as! [String: AnyObject], "saved data")
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
    
}
