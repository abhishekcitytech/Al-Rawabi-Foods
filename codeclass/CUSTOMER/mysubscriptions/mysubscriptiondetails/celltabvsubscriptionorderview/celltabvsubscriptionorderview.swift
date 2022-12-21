//
//  celltabvsubscriptionorderview.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 09/11/22.
//

import UIKit

class celltabvsubscriptionorderview: UITableViewCell
{
    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lbldateday: UILabel!
    @IBOutlet weak var lbltotal: UILabel!
    
    
    @IBOutlet weak var imgvstatus: UIImageView!
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var viewshippingwarning: UIView!
    @IBOutlet weak var btnwarningicon: UIButton!
    @IBOutlet weak var lblwarningmessage: UILabel!
    
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var btndetail: UIButton!
    @IBOutlet weak var btnAddMore: UIButton!
    
    
    @IBOutlet weak var viewupdatetimeslot: UIView!
    @IBOutlet weak var lblupdatetimeslot: UILabel!
    @IBOutlet weak var imgvdropdownupdatetimeslot: UIImageView!
    @IBOutlet weak var btnupdatetimeslot: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
