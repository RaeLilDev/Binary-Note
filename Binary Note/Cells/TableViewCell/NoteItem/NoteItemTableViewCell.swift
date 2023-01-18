//
//  NoteItemTableViewCell.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import UIKit

class NoteItemTableViewCell: UITableViewCell {

    @IBOutlet weak var containerNote: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var data: NoteVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.title
                lblDesc.text = data.desc
                lblDate.text = data.date?.toFormattedString()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerNote.layer.cornerRadius = 12.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
