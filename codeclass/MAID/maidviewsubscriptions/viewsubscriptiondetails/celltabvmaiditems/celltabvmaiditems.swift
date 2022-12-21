//
//  celltabvmaiditems.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class celltabvmaiditems: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var lblsize: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lbladdonce: UILabel!
    @IBOutlet weak var lbladdtoall: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
