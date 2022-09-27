//
//  tabvcellreview.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/06/22.
//

import UIKit
import Cosmos

class tabvcellreview: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var imgvuser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var viewrating: CosmosView!
    @IBOutlet weak var txtvdesc: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
