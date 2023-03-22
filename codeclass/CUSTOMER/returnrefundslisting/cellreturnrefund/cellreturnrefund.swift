//
//  cellreturnrefund.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/11/22.
//

import UIKit

class cellreturnrefund: UITableViewCell
{
    
    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var lblorderno: UILabel!
    @IBOutlet weak var lblordernovalue: UILabel!
    @IBOutlet weak var lbldatevalue: UILabel!
    @IBOutlet weak var lblamount: UILabel!
    
    @IBOutlet weak var imgvarrow: UIImageView!
    
    @IBOutlet weak var btnViewDetails: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
