//
//  cellorderhistoryitems.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 05/09/22.
//

import UIKit

class cellorderhistoryitems: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
