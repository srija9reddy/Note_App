//
//  HelperExtension.swift
//  Note_App
//
//
import UIKit

extension UIViewController{
    
    func saveData(input : [String:Any]){
//        let noteName = input["name"]
//        let noteImages : [UIImage] = input["images"] as! [UIImage]
//        let noteDescription = input["description"]
//        let category = input["category"]
//        let audioPath = input["audioPath"]
        UserDefaults.standard.setValue(input, forKey: "\(input["name"] as? String ?? "")")
        print("note saved", UserDefaults.standard.value(forKey: (input["name"] as? String ?? "")))
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
