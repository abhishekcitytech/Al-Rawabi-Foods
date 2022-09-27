//
//  cellmyorders.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class cellmyorders: UITableViewCell
{

    @IBOutlet weak var viewcell: UIView!
    
    
    
    @IBOutlet weak var lblordernovalue: UILabel!
    @IBOutlet weak var lblstartdatevalue: UILabel!
    @IBOutlet weak var lblquantityvalue: UILabel!
    @IBOutlet weak var lbltotalamountvalue: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var btndetails: UIButton!
    
    @IBOutlet weak var lblsubscriptionplanname: UILabel!
    
    @IBOutlet weak var lblpauseresume: UILabel!
    @IBOutlet weak var switchpauseresume: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
