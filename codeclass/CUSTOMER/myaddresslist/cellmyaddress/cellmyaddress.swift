//
//  cellmyaddress.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class cellmyaddress: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var imgvlocation: UIImageView!
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblmobileno: UILabel!
    @IBOutlet weak var lblcity: UILabel!
    @IBOutlet weak var txtvaddress: UITextView!
    
    @IBOutlet weak var lbldefault: UILabel!
    
    @IBOutlet weak var imgvdetailsarrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
