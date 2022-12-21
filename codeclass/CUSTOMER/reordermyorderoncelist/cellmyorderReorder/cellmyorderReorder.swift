//
//  cellmyorderReorder.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class cellmyorderReorder: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblorderno: UILabel!
    @IBOutlet weak var lblordernovalue: UILabel!
    @IBOutlet weak var lbldeliverydate: UILabel!
    @IBOutlet weak var lbldeliverydatevalue: UILabel!
    @IBOutlet weak var lblquantity: UILabel!
    @IBOutlet weak var lblquantityvalue: UILabel!
    @IBOutlet weak var lbltotalamount: UILabel!
    @IBOutlet weak var lbltotalamountvalue: UILabel!
    @IBOutlet weak var btndetails: UIButton!
    @IBOutlet weak var btnreorder: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
