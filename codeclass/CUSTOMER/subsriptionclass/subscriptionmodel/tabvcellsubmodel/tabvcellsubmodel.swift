//
//  tabvcellsubmodel.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/06/22.
//

import UIKit

class tabvcellsubmodel: UITableViewCell
{
    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblday: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    
    @IBOutlet weak var btnaddplus: UIButton!
    @IBOutlet weak var btneditpencil: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
