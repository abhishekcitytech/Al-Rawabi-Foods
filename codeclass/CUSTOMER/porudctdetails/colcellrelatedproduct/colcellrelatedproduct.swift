//
//  colcellrelatedproduct.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 06/09/22.
//

import UIKit

class colcellrelatedproduct: UICollectionViewCell {

    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var imgv: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblbrand: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblincludetax: UILabel!
    @IBOutlet weak var btnfav: UIButton!
    
    @IBOutlet weak var btnaddonce: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
