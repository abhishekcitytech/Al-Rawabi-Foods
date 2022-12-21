//
//  celltabvmaidlist.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class celltabvmaidlist: UITableViewCell
{
    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblmaxamountlimit: UILabel!
    @IBOutlet weak var lblwalletbalance: UILabel!
    
    @IBOutlet weak var viewwallettransfer: UIView!
    @IBOutlet weak var btnwallettransfer: UIButton!
    @IBOutlet weak var imgvwallettransfer: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
