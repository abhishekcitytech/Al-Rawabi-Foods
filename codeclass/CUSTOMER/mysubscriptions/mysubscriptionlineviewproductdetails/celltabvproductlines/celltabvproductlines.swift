//
//  celltabvproductlines.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 15/11/22.
//

import UIKit

class celltabvproductlines: UITableViewCell
{

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var lblsku: UILabel!
    @IBOutlet weak var lblrpice: UILabel!
    
    @IBOutlet weak var btnremove: UIButton!
    
    @IBOutlet weak var viewplusminus: UIView!
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var txtplusminus: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
