//
//  celltrackorder.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class celltrackorder: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!

    @IBOutlet weak var imgvstatus: UIImageView!
    @IBOutlet weak var lblstatusname: UILabel!
    @IBOutlet weak var lblplacedon: UILabel!
    @IBOutlet weak var lblseparator: UILabel!
    
    @IBOutlet weak var lblvertical1: UILabel!
    @IBOutlet weak var lblvertical2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
