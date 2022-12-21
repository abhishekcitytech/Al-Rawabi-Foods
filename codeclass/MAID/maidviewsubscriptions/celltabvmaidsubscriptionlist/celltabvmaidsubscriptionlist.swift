//
//  celltabvmaidsubscriptionlist.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/11/22.
//

import UIKit

class celltabvmaidsubscriptionlist: UITableViewCell {

    
    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblsubscriptionno: UILabel!
    @IBOutlet weak var lblsubscriptionname: UILabel!
    @IBOutlet weak var lblstartdate: UILabel!
    @IBOutlet weak var lblenddate: UILabel!
    @IBOutlet weak var lblautorenew: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
