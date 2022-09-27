//
//  productfilerpage.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/06/22.
//

import UIKit

class productfilerpage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var colfilter: UICollectionView!
    var reuseIdentifier1 = "colcellfilter"
    var collectionViewHeaderFooterReuseIdentifier = "cellexpHeader"
    
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnapplynow: UIButton!
    
    
    var arrmfilter1 = NSMutableArray()
    var arrmfilter2 = NSMutableArray()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Product Filter"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btncancel.layer.borderWidth = 1.0
        btncancel.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btncancel.layer.cornerRadius = 16.0
        btncancel.layer.masksToBounds = true
        
        btnapplynow.layer.cornerRadius = 16.0
        btnapplynow.layer.masksToBounds = true
        
        arrmfilter1 = ["Mango Juice","Apple Juice","Cocktail","Guava","Kiwi Juice","Lemon Mint"]
        arrmfilter2 = ["Fresh Juice","Long Life","Dairy","Bakery","Meat","Squeezed"]
        
        
        colfilter.backgroundColor = UIColor.white
        //let layout = colfilter.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/3 - 1, height: 352)
        colfilter.register(UINib(nibName: "colcellfilter", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colfilter.register(UINib(nibName: "cellexpHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
        colfilter.register(UINib(nibName: "cellexpHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
        colfilter.layer.cornerRadius = 8.0
        colfilter.layer.masksToBounds = true
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (section==0) {
            return arrmfilter1.count
        }
        else if (section==1) {
            return arrmfilter2.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if indexPath.section == 0
        {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellfilter
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            let  strName = String(format: "%@", arrmfilter1.object(at: indexPath.row) as! CVarArg)
            
            cellA.lblname.text = strName
            cellA.switchonoff.isOn = false
            
            return cellA
        }
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellfilter
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let  strName = String(format: "%@", arrmfilter2.object(at: indexPath.row) as! CVarArg)
        
        cellA.lblname.text = strName
        cellA.switchonoff.isOn = false
        
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width : CGFloat
        let height : CGFloat
        
        width = UIScreen.main.bounds.size.width/2 - 11
        height = 53
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            
            print("indexPath.section",indexPath.section)
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cellexpHeader", for: indexPath) as! cellexpHeader

            if indexPath.section == 0
            {
                headerView.backgroundColor = .white
                headerView.viewcellheader.backgroundColor = .clear
                headerView.lblcellheadername.text = "Filter by Lifestyle"
            }
            else if indexPath.section == 1
            {
                headerView.backgroundColor = .white
                headerView.viewcellheader.backgroundColor = .clear
                headerView.lblcellheadername.text = "Categories"
            }
            
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "cellexpHeader", for: indexPath) as! cellexpHeader
            footerView.backgroundColor = UIColor(named: "graybordercolor")!
            footerView.lblcellheadername.text = ""
            return footerView
            
        default:
            
            fatalError("Unexpected element kind")
            //assert(false, "Unexpected element kind")
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 1)
    }
    
    //MARK: - press apply now method
    @IBAction func pressapplynow(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - press cancel method
    @IBAction func presscancel(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
