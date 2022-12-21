//
//  cellSelectShippingMethod.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 13/10/22.
//

import UIKit

class cellSelectShippingMethod: UITableViewCell {

    
    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var imgvradio: UIImageView!
    
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lbltypename: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
