//
//  tabvcellplan.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 23/06/22.
//

import UIKit

class tabvcellplan: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lblselect: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
