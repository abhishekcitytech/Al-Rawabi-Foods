//
//  celltabvmysubscription.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 02/11/22.
//

import UIKit

class celltabvmysubscription: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblsubscriptionno: UILabel!
    @IBOutlet weak var lblsubscriptionname: UILabel!
    @IBOutlet weak var lblstartdate: UILabel!
    @IBOutlet weak var lblenddate: UILabel!
    @IBOutlet weak var lblautorenew: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var btnview: UIButton!
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var btnrenew: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
