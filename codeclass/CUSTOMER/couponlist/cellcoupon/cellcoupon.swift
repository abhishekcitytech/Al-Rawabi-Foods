//
//  cellcoupon.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 05/09/22.
//

import UIKit

class cellcoupon: UITableViewCell {
    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblcouponcode: UILabel!
    @IBOutlet weak var lblexpdate: UILabel!
    @IBOutlet weak var btnselectcopy: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
