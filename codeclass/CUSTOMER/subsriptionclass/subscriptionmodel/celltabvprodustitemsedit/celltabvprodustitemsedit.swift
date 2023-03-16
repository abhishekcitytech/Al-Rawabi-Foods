//
//  celltabvprodustitemsedit.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/07/22.
//

import UIKit

class celltabvprodustitemsedit: UITableViewCell
{
    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var imgvproduct: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblspec: UILabel!
    @IBOutlet weak var lblunitprice: UILabel!
    
    @IBOutlet weak var btnremove: UIButton!
    
    @IBOutlet weak var btnaddonce: UIButton!
    @IBOutlet weak var btnaddtoall: UIButton!
    
    @IBOutlet weak var viewplusminus: UIView!
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var txtplusminus: UITextField!
    
    @IBOutlet weak var viewplusminusATA: UIView!
    @IBOutlet weak var btnminusATA: UIButton!
    @IBOutlet weak var btnplusATA: UIButton!
    @IBOutlet weak var txtplusminusATA: UITextField!
    
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
