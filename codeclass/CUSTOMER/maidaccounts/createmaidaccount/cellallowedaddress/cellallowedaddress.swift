//
//  cellallowedaddress.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 08/12/22.
//

import UIKit

class cellallowedaddress: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var imgvselection: UIImageView!
    @IBOutlet weak var lbladdress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
