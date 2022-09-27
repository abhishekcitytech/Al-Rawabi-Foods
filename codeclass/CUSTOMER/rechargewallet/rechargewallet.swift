//
//  rechargewallet.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class rechargewallet: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var viewcards: UIView!
    @IBOutlet weak var colcards: UICollectionView!
    var reuseIdentifier2 = "colcellcards"
    
    @IBOutlet weak var switchsaveornot: UISwitch!
    @IBOutlet weak var lblsave: UILabel!
    
    
    @IBOutlet weak var viewbottom: UIView!
    
    @IBOutlet weak var viewnamecard: UIView!
    @IBOutlet weak var txtnamecard: UITextField!
    @IBOutlet weak var viewcardno: UIView!
    @IBOutlet weak var txtcardno: UITextField!
    @IBOutlet weak var viewmonthyear: UIView!
    @IBOutlet weak var txtmonthyear: UITextField!
    @IBOutlet weak var viewcv: UIView!
    @IBOutlet weak var txtcvv: UITextField!
    
    
    @IBOutlet weak var btnpayment: UIButton!
    
    var arrMcards = NSMutableArray()
    

    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Recharge Wallet"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnpayment.layer.cornerRadius = 18.0
        btnpayment.layer.masksToBounds = true
        
        
        viewcardno.layer.borderWidth = 1.0
        viewcardno.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcardno.layer.cornerRadius = 6.0
        viewcardno.layer.masksToBounds = true
        
        viewnamecard.layer.borderWidth = 1.0
        viewnamecard.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewnamecard.layer.cornerRadius = 6.0
        viewnamecard.layer.masksToBounds = true
        
        viewmonthyear.layer.borderWidth = 1.0
        viewmonthyear.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewmonthyear.layer.cornerRadius = 6.0
        viewmonthyear.layer.masksToBounds = true
        
        viewcv.layer.borderWidth = 1.0
        viewcv.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcv.layer.cornerRadius = 6.0
        viewcv.layer.masksToBounds = true
        
        arrMcards = ["1","2","3"]
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colcards.frame.size.width / 1.02, height: 191)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        colcards.collectionViewLayout = layout
        colcards.register(UINib(nibName: "colcellcards", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
        colcards.showsHorizontalScrollIndicator = false
        colcards.showsVerticalScrollIndicator=false
        colcards.backgroundColor = .clear
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - save switch press method
    @IBAction func pressswitchsaveornot(_ sender: Any) {
    }
    
    //MARK: - press make payment method
    @IBAction func pressmakepayment(_ sender: Any) {
    }
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrMcards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! colcellcards
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
}
