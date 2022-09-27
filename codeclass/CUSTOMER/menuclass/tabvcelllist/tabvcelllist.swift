//
//  tabvcelllist.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 23/06/22.
//

import UIKit

class tabvcelllist: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var imgvicon: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
