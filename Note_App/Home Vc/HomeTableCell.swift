//
//  HomeTableCell.swift
//  NoteApp
//
//

import UIKit

class HomeTableCell: UITableViewCell {

    //MARK:- IBOUTLETS
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteDescriptionLabel: UILabel!
    @IBOutlet weak var noteUploadedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
