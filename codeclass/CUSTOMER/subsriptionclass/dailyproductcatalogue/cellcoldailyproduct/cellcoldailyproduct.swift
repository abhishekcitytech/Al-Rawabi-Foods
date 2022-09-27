//
//  cellcoldailyproduct.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 19/09/22.
//

import UIKit

class cellcoldailyproduct: UICollectionViewCell {

    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var imgv: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblbrand: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    
    @IBOutlet weak var btnfav: UIButton!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
