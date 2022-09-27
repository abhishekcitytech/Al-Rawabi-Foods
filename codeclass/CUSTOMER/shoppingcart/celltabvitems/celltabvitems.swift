//
//  celltabvitems.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/06/22.
//

import UIKit

class celltabvitems: UITableViewCell
{
    
    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var viewleft: UIView!
    @IBOutlet weak var lbldateleft: UILabel!
    @IBOutlet weak var lbldayleft: UILabel!
    @IBOutlet weak var lbleftseparator: UILabel!
    
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var lblproductqty: UILabel!
    @IBOutlet weak var lbldeliveryon: UILabel!
    @IBOutlet weak var lbldeliverydate: UILabel!
    @IBOutlet weak var lblrpoductprice: UILabel!
    
    @IBOutlet weak var btneditproduct: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
