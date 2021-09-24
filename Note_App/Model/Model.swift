//
//  Model.swift
//  Note_App
//
//  Created by srija9reddy on 23/09/21.
//

import Foundation

// MARK: - Model
struct notesList: Codable {
    var time: Int?
    var name: String?
    var description: String?
    var category: String?
    var images : [String]?
    var audioPath : String?
    var lattitude : Double?
    var longitude : Double?
    
    enum CodingKeys: String, CodingKey {
        case time, name, description, category, images, audioPath, lattitude, longitude
    }
}

//["name":self.noteTitleTF.text!, "images":self.imagesArray, "description": self.descriptionTF.text!, "category": self.categoryTF.text!, "audioPath": self.noteData["audioPath"] as? String ?? "", "time": self.currentTimeInMilliSeconds(), "lattitude": lattitude, "longitude":longgitude]
