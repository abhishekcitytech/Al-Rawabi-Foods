//
//  cellwallettransaction.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class cellwallettransaction: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblorderno: UILabel!
    @IBOutlet weak var lblorderamount: UILabel!
    @IBOutlet weak var lblorderplacedon: UILabel!
    @IBOutlet weak var lblorderstatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
