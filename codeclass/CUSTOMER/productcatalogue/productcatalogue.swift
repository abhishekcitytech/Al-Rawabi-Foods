//
//  productcatalogue.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/06/22.
//

import UIKit

class productcatalogue: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var colproductlist: UICollectionView!
    var reuseIdentifier1 = "colcelltopdeals"
    @IBOutlet weak var btnfilter: UIButton!
    var msg = ""
    
    @IBOutlet weak var vieworderon: UIView!
    @IBOutlet weak var lblorderon: UILabel!
    @IBOutlet weak var colorderon: UICollectionView!
    var reuseIdentifier2 = "cellcolordernow"
    
    @IBOutlet weak var viewsearchbox: UIView!
    @IBOutlet weak var txtsearchbox: UITextField!
    
    @IBOutlet weak var btnsortby: UIButton!
    
    
    var strpageidentifier = ""
    var arrmdatblocks = NSMutableArray()
    var strSubscriptionselectediexdate = ""
    
    var strFromCategoryID = ""
    var strFromCategoryNAME = ""
    
    var arrMCategorywiseProductlist = NSMutableArray()
    
    @IBOutlet weak var btnplacereviewsubscriptionorder: UIButton!
    
    
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
        
        if strpageidentifier == "1001"
        {
            print("FROM CATEGORY PAGE")
            self.btnplacereviewsubscriptionorder.isHidden = true
            self.getProductListingFromCategoryIDAPIMethod()
        }
        else if strpageidentifier == "100"
        {
            print("FROM SUBSCRIPTION SELECTION PAGE DAILY")
            
            self.btnplacereviewsubscriptionorder.isHidden = false
        }
        else if strpageidentifier == "200"
        {
            print("FROM SUBSCRIPTION SELECTION PAGE WEEKLY")
            
            self.btnplacereviewsubscriptionorder.isHidden = false
        }
        else if strpageidentifier == "300"
        {
            print("FROM SUBSCRIPTION SELECTION PAGE MONTHLY")
            
            self.btnplacereviewsubscriptionorder.isHidden = false
        }
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        if strFromCategoryNAME.count > 0 {
            self.title = strFromCategoryNAME
        }else{
            self.title = "Products"
        }
        
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        /*let searchicon = UIImage(named: "search")
        let search = UIBarButtonItem(image: searchicon, style: .plain, target: self, action: #selector(pressSearch))
        search.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = search*/
        
        
        colproductlist.backgroundColor = .clear
        let layout = colproductlist.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2.0 - 15, height: 316)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colproductlist.register(UINib(nibName: "colcelltopdeals", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colproductlist.showsVerticalScrollIndicator = false
        colproductlist.showsHorizontalScrollIndicator = false
        
        viewsearchbox.layer.cornerRadius = 16.0
        viewsearchbox.layer.masksToBounds = true
        
        self.btnplacereviewsubscriptionorder.layer.cornerRadius = 12.0
        self.btnplacereviewsubscriptionorder.layer.masksToBounds = true
        
        if strpageidentifier == "100" || strpageidentifier == "200" || strpageidentifier == "300"
        {
            self.btnplacereviewsubscriptionorder.isHidden = false
            
            print("TOP ORDER ON VIEW WILL SHOW")
            self.vieworderon.isHidden = false
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: colorderon.frame.size.width / 3 - 10, height: 100)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            colorderon.collectionViewLayout = layout
            colorderon.register(UINib(nibName: "cellcolordernow", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
            colorderon.showsHorizontalScrollIndicator = false
            colorderon.showsVerticalScrollIndicator=false
            colorderon.backgroundColor = .clear
        }
        else if strpageidentifier == "1001"
        {
            self.btnplacereviewsubscriptionorder.isHidden = true
            
            //TOP ORDER ON VIEW WILL HIDDEN and ONLY PRODUCT GRID WILL SHOW --  THIS IS COMMING FROM HOME CATEGORY SELECTION
            self.vieworderon.isHidden = true
            self.viewsearchbox.frame = CGRect(x: self.viewsearchbox.frame.origin.x, y: 8, width: self.viewsearchbox.frame.size.width, height: self.viewsearchbox.frame.size.height)
            colproductlist.frame = CGRect(x: colproductlist.frame.origin.x, y: self.viewsearchbox.frame.maxY + 15, width: colproductlist.frame.size.width, height: colproductlist.frame.size.height + self.vieworderon.frame.size.height + 15)
        }
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - press search method
    /*@objc func pressSearch()
    {
     let ctrl = searchproductlist(nibName: "searchproductlist", bundle: nil)
     self.navigationController?.pushViewController(ctrl, animated: true)
    }*/
    
    //MARK: - press Sortby Method
    @IBAction func pressSortby(_ sender: Any){
        
    }
    
    //MARK: - press filter method
    @IBAction func pressfilter(_ sender: Any)
    {
        let ctrl = productfilerpage(nibName: "productfilerpage", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    //MARK: - press Review order place Subscription order
    @IBAction func pressplacereviewsubscriptionorder(_ sender: Any)
    {
        let ctrl = subscriptionorderreview(nibName: "subscriptionorderreview", bundle: nil)
        ctrl.strpageidentifier = strpageidentifier
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    


    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if collectionView == colorderon
        {
            if strpageidentifier == "100"{
                
                return appDel.arrMDATEWISEPRODUCTPLAN.count
            }
            else if strpageidentifier == "200"{
                return appDel.arrMDATEWISEPRODUCTPLANWEEKLY.count
            }
            return appDel.arrMDATEWISEPRODUCTPLANMONTHLY.count
        }
        
        if strpageidentifier == "1001"{
            //FROM CATEGORY PAGE
            
            if arrMCategorywiseProductlist.count == 0 {
                self.colproductlist.setEmptyMessage(msg)
            } else {
                self.colproductlist.restore()
            }
            return arrMCategorywiseProductlist.count
        }
        //FROM SUBSCRIPTION SELECTION PAGE
        return appDel.arrMproductlist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == colorderon
        {
            let appDel = UIApplication.shared.delegate as! AppDelegate
            
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! cellcolordernow
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 4.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            print("self.strSubscriptionselectediexdate",self.strSubscriptionselectediexdate)
            if self.strSubscriptionselectediexdate == String(format: "%d", indexPath.row)
            {
                //Selected DATE DAY from TOP GALLERY
                cellA.viewcell.backgroundColor = .white
                cellA.viewcell.layer.cornerRadius = 4.0
                cellA.viewcell.layer.borderWidth = 4.0
                cellA.viewcell.layer.borderColor = UIColor(named: "lightblue")!.cgColor
                cellA.viewcell.layer.masksToBounds = true
            }else{
                cellA.viewcell.backgroundColor = .white
                cellA.viewcell.layer.cornerRadius = 4.0
                cellA.viewcell.layer.borderWidth = 1.0
                cellA.viewcell.layer.borderColor = UIColor.clear.cgColor
                cellA.viewcell.layer.masksToBounds = true
            }
            
            
            if strpageidentifier == "100"
            {
                //DAILY
                
                let dict = appDel.arrMDATEWISEPRODUCTPLAN.object(at: indexPath.row)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                let arrm = dict?.value(forKey: "items")as! NSMutableArray
                var intvalueTotal = 0
                for x in 0 ..< arrm.count
                {
                    let dict = arrm.object(at: x)as? NSMutableDictionary
                    let strunitprice = String(format: "%@", dict?.value(forKey: "price")as? String ?? "")
                    let strunitqty = String(format: "%@", dict?.value(forKey: "qty")as! CVarArg)
                    let strunitqtyATA = String(format: "%@", dict?.value(forKey: "qtyATA")as! CVarArg)

                    var intvalue = Float()
                    intvalue = Float(strunitqty)! * Float(strunitprice)!
                    
                    var intvalueATA = Float()
                    intvalueATA = Float(strunitqtyATA)! * Float(strunitprice)!
                    
                    
                    intvalueTotal = intvalueTotal + Int(intvalue) + Int(intvalueATA)
                    
                }
                let strtotalprice = String(format: "%d", intvalueTotal)
                
                cellA.lbldate.text = strdate
                cellA.lblday.text = strday
                
                if strtotalprice == "0"{
                    cellA.lbltotalprice.textColor = UIColor(named: "orangecolor")!
                    cellA.lbltotalprice.text = "+ Add More"
                    
                    cellA.lbldate.textAlignment = .center
                    cellA.btnedit.isHidden = true
                }
                else{
                    cellA.lbltotalprice.textColor = UIColor.darkGray
                    cellA.lbltotalprice.text = String(format: "AED %@", strtotalprice)
                    
                    cellA.lbldate.textAlignment = .left
                    cellA.btnedit.isHidden = false
                }
                
                //STATUS CHECKING WITH TOTAL PRICE FOR THAT DATE
                if intvalueTotal == 0{
                    //GRAY
                    
                    cellA.lblseparator.backgroundColor = UIColor(named: "darkredcolor")!
                    
                    cellA.lbldate.backgroundColor = .clear
                    cellA.lblday.backgroundColor = .clear
                    cellA.lbltotalprice.backgroundColor = .clear
                    
                    cellA.lbldate.textColor = .black
                    cellA.lblday.textColor = .black
                    cellA.lbltotalprice.textColor = .black
                    
                    cellA.viewcell.backgroundColor = .white
                }
                else if intvalueTotal >= 15{
                    
                    //GREEN
                    cellA.lblseparator.backgroundColor = .white
                    
                    cellA.lbldate.backgroundColor = .clear
                    cellA.lblday.backgroundColor = .clear
                    cellA.lbltotalprice.backgroundColor = .clear
                    
                    cellA.lbldate.textColor = .white
                    cellA.lblday.textColor = .white
                    cellA.lbltotalprice.textColor = .white
                    
                    cellA.viewcell.backgroundColor = UIColor(named: "greencolor")!
                }
                else if intvalueTotal < 15{
                    
                    //RED
                    
                    cellA.lblseparator.backgroundColor = .white
                    
                    cellA.lbldate.backgroundColor = .clear
                    cellA.lblday.backgroundColor = .clear
                    cellA.lbltotalprice.backgroundColor = .clear
                    
                    cellA.lbldate.textColor = .white
                    cellA.lblday.textColor = .white
                    cellA.lbltotalprice.textColor = .white
                    
                    cellA.viewcell.backgroundColor = UIColor(named: "plate4")!
                }
                
                // Set up cell
                return cellA
            }
            else if strpageidentifier == "200"
            {
                //WEEKLY
                
                let dict = appDel.arrMDATEWISEPRODUCTPLANWEEKLY.object(at: indexPath.row)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
                print("strselected",strselected)
                
                if strselected != "0"
                {
                    //ONLY SELECTED DATE DAY DATA WILL SHOW IN TOP ORDERON GALLERY
                    
                    let arrm = dict?.value(forKey: "items")as! NSMutableArray
                    var intvalueTotal = 0
                    for x in 0 ..< arrm.count
                    {
                        let dict = arrm.object(at: x)as? NSMutableDictionary
                        let strunitprice = String(format: "%@", dict?.value(forKey: "price")as? String ?? "")
                        let strunitqty = String(format: "%@", dict?.value(forKey: "qty")as! CVarArg)
                        let strunitqtyATA = String(format: "%@", dict?.value(forKey: "qtyATA")as! CVarArg)

                        var intvalue = Float()
                        intvalue = Float(strunitqty)! * Float(strunitprice)!
                        
                        var intvalueATA = Float()
                        intvalueATA = Float(strunitqtyATA)! * Float(strunitprice)!
                        
                        
                        intvalueTotal = intvalueTotal + Int(intvalue) + Int(intvalueATA)
                        
                    }
                    let strtotalprice = String(format: "%d", intvalueTotal)
                    
                    cellA.lbldate.text = strdate
                    cellA.lblday.text = strday
                    
                    if strtotalprice == "0"{
                        cellA.lbltotalprice.textColor = UIColor(named: "orangecolor")!
                        cellA.lbltotalprice.text = "+ Add More"
                        
                        cellA.lbldate.textAlignment = .center
                        cellA.btnedit.isHidden = true
                    }
                    else{
                        cellA.lbltotalprice.textColor = UIColor.darkGray
                        cellA.lbltotalprice.text = String(format: "AED %@", strtotalprice)
                        
                        cellA.lbldate.textAlignment = .left
                        cellA.btnedit.isHidden = false
                    }
                    
                    //STATUS CHECKING WITH TOTAL PRICE FOR THAT DATE
                    if intvalueTotal == 0{
                        //GRAY
                        
                        cellA.lblseparator.backgroundColor = UIColor(named: "darkredcolor")!
                        
                        cellA.lbldate.backgroundColor = .clear
                        cellA.lblday.backgroundColor = .clear
                        cellA.lbltotalprice.backgroundColor = .clear
                        
                        cellA.lbldate.textColor = .black
                        cellA.lblday.textColor = .black
                        cellA.lbltotalprice.textColor = .black
                        
                        cellA.viewcell.backgroundColor = .white
                        
                    }
                    else if intvalueTotal >= 15{
                        
                        //GREEN
                        cellA.lblseparator.backgroundColor = .white
                        
                        cellA.lbldate.backgroundColor = .clear
                        cellA.lblday.backgroundColor = .clear
                        cellA.lbltotalprice.backgroundColor = .clear
                        
                        cellA.lbldate.textColor = .white
                        cellA.lblday.textColor = .white
                        cellA.lbltotalprice.textColor = .white
                        
                        cellA.viewcell.backgroundColor = UIColor(named: "greencolor")!
                        
                    }
                    else if intvalueTotal < 15{
                        
                        //RED
                        
                        cellA.lblseparator.backgroundColor = .white
                        
                        cellA.lbldate.backgroundColor = .clear
                        cellA.lblday.backgroundColor = .clear
                        cellA.lbltotalprice.backgroundColor = .clear
                        
                        cellA.lbldate.textColor = .white
                        cellA.lblday.textColor = .white
                        cellA.lbltotalprice.textColor = .white
                        
                        cellA.viewcell.backgroundColor = UIColor(named: "plate4")!
                        
                    }
                   
                    cellA.isHidden = false
                }
                else{
                    cellA.isHidden = true
                }
                
                // Set up cell
                return cellA
            }
            
            //MONTHLY
            
            let dict = appDel.arrMDATEWISEPRODUCTPLANMONTHLY.object(at: indexPath.row)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            print("strselected",strselected)
            
            if strselected != "0"
            {
                //ONLY SELECTED DATE DAY DATA WILL SHOW IN TOP ORDERON GALLERY
                
                let arrm = dict?.value(forKey: "items")as! NSMutableArray
                var intvalueTotal = 0
                for x in 0 ..< arrm.count
                {
                    let dict = arrm.object(at: x)as? NSMutableDictionary
                    let strunitprice = String(format: "%@", dict?.value(forKey: "price")as? String ?? "")
                    let strunitqty = String(format: "%@", dict?.value(forKey: "qty")as! CVarArg)
                    let strunitqtyATA = String(format: "%@", dict?.value(forKey: "qtyATA")as! CVarArg)

                    var intvalue = Float()
                    intvalue = Float(strunitqty)! * Float(strunitprice)!
                    
                    var intvalueATA = Float()
                    intvalueATA = Float(strunitqtyATA)! * Float(strunitprice)!
                    
                    
                    intvalueTotal = intvalueTotal + Int(intvalue) + Int(intvalueATA)
                }
                let strtotalprice = String(format: "%d", intvalueTotal)
                
                cellA.lbldate.text = strdate
                cellA.lblday.text = strday
                
                if strtotalprice == "0"{
                    cellA.lbltotalprice.textColor = UIColor(named: "orangecolor")!
                    cellA.lbltotalprice.text = "+ Add More"
                    
                    cellA.lbldate.textAlignment = .center
                    cellA.btnedit.isHidden = true
                }
                else{
                    cellA.lbltotalprice.textColor = UIColor.darkGray
                    cellA.lbltotalprice.text = String(format: "AED %@", strtotalprice)
                    
                    cellA.lbldate.textAlignment = .left
                    cellA.btnedit.isHidden = false
                }
                
                //STATUS CHECKING WITH TOTAL PRICE FOR THAT DATE
                if intvalueTotal == 0{
                    //GRAY
                    
                    cellA.lblseparator.backgroundColor = UIColor(named: "darkredcolor")!
                    
                    cellA.lbldate.backgroundColor = .clear
                    cellA.lblday.backgroundColor = .clear
                    cellA.lbltotalprice.backgroundColor = .clear
                    
                    cellA.lbldate.textColor = .black
                    cellA.lblday.textColor = .black
                    cellA.lbltotalprice.textColor = .black
                    
                    cellA.viewcell.backgroundColor = .white
                    
                }
                else if intvalueTotal >= 15{
                    
                    //GREEN
                    cellA.lblseparator.backgroundColor = .white
                    
                    cellA.lbldate.backgroundColor = .clear
                    cellA.lblday.backgroundColor = .clear
                    cellA.lbltotalprice.backgroundColor = .clear
                    
                    cellA.lbldate.textColor = .white
                    cellA.lblday.textColor = .white
                    cellA.lbltotalprice.textColor = .white
                    
                    cellA.viewcell.backgroundColor = UIColor(named: "greencolor")!
                    
                }
                else if intvalueTotal < 15{
                    
                    //RED
                    
                    cellA.lblseparator.backgroundColor = .white
                    
                    cellA.lbldate.backgroundColor = .clear
                    cellA.lblday.backgroundColor = .clear
                    cellA.lbltotalprice.backgroundColor = .clear
                    
                    cellA.lbldate.textColor = .white
                    cellA.lblday.textColor = .white
                    cellA.lbltotalprice.textColor = .white
                    
                    cellA.viewcell.backgroundColor = UIColor(named: "plate4")!
                    
                }
                
                cellA.isHidden = false
            }
            else{
                cellA.isHidden = true
            }
            
            // Set up cell
            return cellA
        }
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcelltopdeals
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 8.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        
        if strpageidentifier == "1001"
        {
            //FROM CATEGORY PAGE
            let dict = arrMCategorywiseProductlist.object(at: indexPath.row)as? NSDictionary
            
            let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            let strname = String(format: "%@", dict!.value(forKey: "name") as? String ?? "")
            let strsku = String(format: "%@", dict!.value(forKey: "sku") as? String ?? "")
            let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
            let strsize = String(format: "%@", dict!.value(forKey: "size") as? String ?? "")
            let strbrand = String(format: "%@", dict!.value(forKey: "brand") as? String ?? "")
            let strstatus = String(format: "%@", dict!.value(forKey: "productStatus") as? String ?? "")
            
            let strcurrent_currencecode = String(format: "%@", dict!.value(forKey: "current_currencecode") as? String ?? "")
            
            
            let arrmedia = dict!.value(forKey: "media")as? NSArray ?? []
            if arrmedia.count > 0 {
                let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")
                let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
                print("strFinalurl",strFinalurl)
               
                cellA.imgv.contentMode = .scaleAspectFit
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else{
                cellA.imgv.contentMode = .scaleAspectFit
                cellA.imgv.image = UIImage(named: "productplaceholder.png")
            }
            
            
            cellA.lblname.text = strname
            cellA.lblbrand.text = strbrand
            cellA.lblqty.text = strsize
            
            print("strprice",strprice)
            if strprice != ""{
                let fltprice = Float(strprice)
                cellA.lblprice.text = String(format: "%@ %.2f",strcurrent_currencecode,fltprice!)
            }
            
            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
            if strbearertoken == ""{
                cellA.btnfav.isHidden = true
                cellA.btnright.isHidden = true
            }
            else{
                
                let stris_addedwishlist = String(format: "%@", dict!.value(forKey: "is_addedwishlist") as? String ?? "")
                
                print("stris_addedwishlist",stris_addedwishlist)
                if stris_addedwishlist == "True"
                {
                    cellA.btnfav.setImage(UIImage(named: "favselected"), for: .normal)
                }
                
                cellA.btnfav.isHidden = false
                cellA.btnright.isHidden = true
            }
            
            cellA.btnaddonce.backgroundColor = .white
            cellA.btnaddonce.setTitle("ADD TO CART", for: .normal)
            cellA.btnaddonce.setTitleColor(UIColor(named: "themecolor")!, for: .normal)
            cellA.btnaddonce.titleLabel?.font = UIFont (name: "NunitoSans-Bold", size: 16)
            
            cellA.btnaddonce.isHidden = false
            cellA.btnaddtoall.isHidden = true
            cellA.viewplusminus.isHidden = true
            cellA.viewplusminusATA.isHidden = true
            
            cellA.btnaddonce.frame = CGRect(x: cellA.btnaddonce.frame.origin.x, y: cellA.btnaddonce.frame.origin.y + 20, width: cellA.btnaddonce.frame.size.width, height: cellA.btnaddonce.frame.size.height)
            
        }
        else
        {
            //FROM SUBSCRIPTION SELECTION PAGE
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let dict = appDel.arrMproductlist.object(at: indexPath.row)as! NSMutableDictionary
            let strid = String(format: "%@", dict.value(forKey: "id")as? String ?? "")
            let strname = String(format: "%@", dict.value(forKey: "name")as? String ?? "")
            let strqty = String(format: "%@", dict.value(forKey: "qty")as? String ?? "")
            let strqtyATA = String(format: "%@", dict.value(forKey: "qtyATA")as? String ?? "")
            let strprice = String(format: "%@", dict.value(forKey: "price")as? String ?? "")
            
            print("strqty",strqty)
            print("strqtyATA",strqtyATA)
            
            cellA.lblname.text = strname
            cellA.lblprice.text = String(format: "AED %@", strprice)
            
            cellA.lblbrand.text = "AlRawabi"
            cellA.lblqty.text = "1.4 ltr"
            
            cellA.imgv.image = UIImage(named: "cathome2.png")
            
            if strqty != "0"
            {
                //PLUSMINUS SHOW
                cellA.btnaddonce.isHidden = true
                cellA.viewplusminus.isHidden = false

                cellA.txtplusminus.text = strqty
            }
            else{
                //ADDONCE SHOW
                cellA.btnaddonce.isHidden = false
                cellA.viewplusminus.isHidden = true
            }
            
            if strqtyATA != "0"
            {
                //PLUSMINUSATA SHOW
                cellA.btnaddtoall.isHidden = true
                cellA.viewplusminusATA.isHidden = false
                
                cellA.txtplusminusATA.text = strqtyATA
            }
            else{
                //ADDTOALL SHOW
                cellA.btnaddtoall.isHidden = false
                cellA.viewplusminusATA.isHidden = true
            }
            
            cellA.btnfav.isHidden = true
            cellA.btnright.isHidden = true
        }
        
       
        cellA.btnaddonce.layer.cornerRadius = 14.0
        cellA.btnaddonce.layer.masksToBounds = true
        
        cellA.btnaddtoall.setTitleColor(UIColor(named: "orangecolor")!, for: .normal)
        cellA.btnaddtoall.layer.cornerRadius = 14.0
        cellA.btnaddtoall.layer.borderWidth = 1.0
        cellA.btnaddtoall.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        cellA.btnaddtoall.layer.masksToBounds = true
        
        cellA.viewcell.layer.cornerRadius = 8.0
        cellA.viewcell.layer.masksToBounds = true
        
        
        //CELL PLUS MINUS
        cellA.viewplusminus.layer.cornerRadius = 14.0
        cellA.viewplusminus.layer.borderWidth = 1.0
        cellA.viewplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cellA.viewplusminus.layer.masksToBounds = true
        
        //CELL PLUS MINUS ATA
        cellA.viewplusminusATA.layer.cornerRadius = 14.0
        cellA.viewplusminusATA.layer.borderWidth = 1.0
        cellA.viewplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        cellA.viewplusminusATA.layer.masksToBounds = true
        
        cellA.txtplusminus.layer.cornerRadius = 1.0
        cellA.txtplusminus.layer.borderWidth = 1.0
        cellA.txtplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cellA.txtplusminus.layer.masksToBounds = true
        
        cellA.txtplusminusATA.layer.cornerRadius = 1.0
        cellA.txtplusminusATA.layer.borderWidth = 1.0
        cellA.txtplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        cellA.txtplusminusATA.layer.masksToBounds = true
        
        cellA.btnplus.tag = indexPath.row
        cellA.btnminus.tag = indexPath.row
        cellA.btnplus.addTarget(self, action: #selector(pressplus), for: .touchUpInside)
        cellA.btnminus.addTarget(self, action: #selector(pressminus), for: .touchUpInside)
        
        cellA.btnplusATA.tag = indexPath.row
        cellA.btnminusATA.tag = indexPath.row
        cellA.btnplusATA.addTarget(self, action: #selector(pressplusATA), for: .touchUpInside)
        cellA.btnminusATA.addTarget(self, action: #selector(pressminusATA), for: .touchUpInside)
        
        cellA.btnaddonce.tag = indexPath.row
        cellA.btnaddtoall.tag = indexPath.row
        cellA.btnaddonce.addTarget(self, action: #selector(pressaddonce), for: .touchUpInside)
        cellA.btnaddtoall.addTarget(self, action: #selector(pressaddtoall), for: .touchUpInside)
        
        cellA.btnfav.tag = indexPath.row
        cellA.btnfav.addTarget(self, action: #selector(pressAddToWishlist), for: .touchUpInside)
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == colorderon
        {
            self.strSubscriptionselectediexdate = String(format: "%d", indexPath.row)
            self.colorderon.reloadData()
        }
        else
        {
            if strpageidentifier == "1001"
            {
                //FROM CATEGORY PAGE
                let dict = arrMCategorywiseProductlist.object(at: indexPath.row)as? NSDictionary
                let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
                
                let ctrl = porudctdetails(nibName: "porudctdetails", bundle: nil)
                ctrl.strSelectedProductID = strproductid
                ctrl.strFrompageIdentifier = strpageidentifier
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else
            {
                //FROM SUBSCRTION SELECTION PAGE
                let ctrl = porudctdetails(nibName: "porudctdetails", bundle: nil)
                ctrl.strFrompageIdentifier = strpageidentifier
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
    //MARK: - press Add To Wishlist Method
    @objc func pressAddToWishlist(sender:UIButton)
    {
        if strpageidentifier == "1001"
        {
            //FROM CATEGORY PAGE
            let dict = arrMCategorywiseProductlist.object(at: sender.tag)as? NSDictionary
            let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            
            let refreshAlert = UIAlertController(title: "", message: "Do you want to Add to Wishlist?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.postAddtoWishlistAPIMethod(strproductid: strproductid)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    //MARK: - press Add Once Method
    @objc func pressaddonce(sender:UIButton)
    {
        if strpageidentifier == "1001"
        {
            //FROM CATEGORY PAGE
            let dict = arrMCategorywiseProductlist.object(at: sender.tag)as? NSDictionary
            let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            self.postAddToCartApiMethod(strqty: "1", strproductid: strproductid)
        }
        else{
            //SUBSCRIPTION PAGE
            
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let dict = appDel.arrMproductlist.object(at: sender.tag)as! NSMutableDictionary
            let strid = String(format: "%@", dict.value(forKey: "id")as? String ?? "")
            let strname = String(format: "%@", dict.value(forKey: "name")as? String ?? "")
            let strprice = String(format: "%@", dict.value(forKey: "price")as? String ?? "")
            let strqty = String(format: "%@", dict.value(forKey: "qty")as? String ?? "")
            var intqty = Int(strqty)
            if intqty! == 0{
                intqty = intqty! + 1
            }
            print("intqty",intqty as Any)
            dict.setValue(String(format: "%d", intqty!), forKey: "qty")
        
            print("arrm >>>",appDel.arrMproductlist)
            self.colproductlist.reloadData()
            
            //PASS Value to subscription model array
            self.updateSubscriptionmodelArray(dictproduct: dict, strprdid: strid,stridentifier: strpageidentifier)
        }
        
    }
    
    //MARK: - press PLUS / MINUS Method
    @objc func pressplus(sender:UIButton)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let dict = appDel.arrMproductlist.object(at: sender.tag)as! NSMutableDictionary
        let strid = String(format: "%@", dict.value(forKey: "id")as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qty")as? String ?? "")
        var intqty = Int(strqty)
        if intqty! >= 0{
            intqty = intqty! + 1
        }
        print("intqty",intqty as Any)
        dict.setValue(String(format: "%d", intqty!), forKey: "qty")
    
        print("arrm >>>",appDel.arrMproductlist)
        self.colproductlist.reloadData()
        
        //PASS Value to subscription model array
        self.updateSubscriptionmodelArray(dictproduct: dict, strprdid: strid,stridentifier: strpageidentifier)
    }
    @objc func pressminus(sender:UIButton)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let dict = appDel.arrMproductlist.object(at: sender.tag)as! NSMutableDictionary
        let strid = String(format: "%@", dict.value(forKey: "id")as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qty")as? String ?? "")
        var intqty = Int(strqty)
        if intqty != 0{
            if intqty == 1{
                intqty = 0
            }
            else{
                intqty = intqty! - 1
            }
        }
        print("intqty",intqty as Any)
        dict.setValue(String(format: "%d", intqty!), forKey: "qty")
    
        print("arrm >>>",appDel.arrMproductlist)
        self.colproductlist.reloadData()
        
        //PASS Value to subscription model array
        self.updateSubscriptionmodelArray(dictproduct: dict, strprdid: strid,stridentifier: strpageidentifier)
    }
    
    //MARK: - press Add To All Method
    @objc func pressaddtoall(sender:UIButton)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let dict = appDel.arrMproductlist.object(at: sender.tag)as! NSMutableDictionary
        let strid = String(format: "%@", dict.value(forKey: "id")as? String ?? "")
        let strname = String(format: "%@", dict.value(forKey: "name")as? String ?? "")
        let strprice = String(format: "%@", dict.value(forKey: "price")as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qtyATA")as? String ?? "")
        var intqty = Int(strqty)
        if intqty! == 0{
            intqty = intqty! + 1
        }
        print("intqty",intqty as Any)
        dict.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
        print("arrm >>>",appDel.arrMproductlist)
        
        let strUpdtatedqty = String(format: "%@", dict.value(forKey: "qtyATA")as? String ?? "")
        print("strUpdtatedqty",strUpdtatedqty)
        
        if strpageidentifier == "100"
        {
            //DAILY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLAN.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLAN.object(at: x)as? NSMutableDictionary
                
                let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                
                /*var condition = true
                loopReset: do {
                  for i in 0..<arrmitems.count
                    {
                      let dict = arrmitems.object(at: i)as? NSMutableDictionary
                      let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                      let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                      if (strid == strprdid) || strqty == "0"
                      {
                          arrmitems.removeObject(at: i)
                          condition = false
                          continue loopReset
                      }
                      print("index",i)
                      print("arrmitems",arrmitems)
                  }
                }*/
                
                if strUpdtatedqty != "0"
                {
                      for i in 0..<arrmitems.count
                      {
                        let dict = arrmitems.object(at: i)as? NSMutableDictionary
                        let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                        let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                        if (strid == strprdid)
                        {
                            dict?.setValue(strUpdtatedqty, forKey: "qtyATA")
                            dict1?.setValue("1", forKey: "selected")
                        }
                      }
                    
                    if arrmitems.count == 0{
                        let dictttemp = NSMutableDictionary()
                        dictttemp.setValue(strid, forKey: "id")
                        dictttemp.setValue(strname, forKey: "name")
                        dictttemp.setValue(strprice, forKey: "price")
                        dictttemp.setValue("0", forKey: "qty")
                        dictttemp.setValue(strUpdtatedqty, forKey: "qtyATA")
                        
                        arrmitems.add(dictttemp as Any)
                        dict1?.setValue("1", forKey: "selected")
                    }
                 }
            }
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLANWEEKLY.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLANWEEKLY.object(at: x)as? NSMutableDictionary
                let strselected = String(format: "%@", dict1?.value(forKey: "selected")as? String ?? "")
                
                if strselected == "1"
                {
                    let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                    
                    /*var condition = true
                    loopReset: do {
                      for i in 0..<arrmitems.count
                        {
                          let dict = arrmitems.object(at: i)as? NSMutableDictionary
                          let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                          let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                          if (strid == strprdid) || strqty == "0"
                          {
                              arrmitems.removeObject(at: i)
                              condition = false
                              continue loopReset
                          }
                          print("index",i)
                          print("arrmitems",arrmitems)
                      }
                    }*/
                    
                    if strUpdtatedqty != "0"
                    {
                          for i in 0..<arrmitems.count
                          {
                            let dict = arrmitems.object(at: i)as? NSMutableDictionary
                            let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                            let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                            if (strid == strprdid)
                            {
                                dict?.setValue(strUpdtatedqty, forKey: "qtyATA")
                                dict1?.setValue("1", forKey: "selected")
                            }
                          }
                        
                        if arrmitems.count == 0{
                            let dictttemp = NSMutableDictionary()
                            dictttemp.setValue(strid, forKey: "id")
                            dictttemp.setValue(strname, forKey: "name")
                            dictttemp.setValue(strprice, forKey: "price")
                            dictttemp.setValue("0", forKey: "qty")
                            dictttemp.setValue(strUpdtatedqty, forKey: "qtyATA")
                            
                            arrmitems.add(dictttemp as Any)
                            dict1?.setValue("1", forKey: "selected")
                        }
                     }
                }
                
            }
            print("appDel.arrMDATEWISEPRODUCTPLANWEEKLY",appDel.arrMDATEWISEPRODUCTPLANWEEKLY)
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLANMONTHLY.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLANMONTHLY.object(at: x)as? NSMutableDictionary
                let strselected = String(format: "%@", dict1?.value(forKey: "selected")as? String ?? "")
                
                if strselected == "1"
                {
                    let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                    
                    /*var condition = true
                    loopReset: do {
                      for i in 0..<arrmitems.count
                        {
                          let dict = arrmitems.object(at: i)as? NSMutableDictionary
                          let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                          let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                          if (strid == strprdid) || strqty == "0"
                          {
                              arrmitems.removeObject(at: i)
                              condition = false
                              continue loopReset
                          }
                          print("index",i)
                          print("arrmitems",arrmitems)
                      }
                    }*/
                    
                    if strUpdtatedqty != "0"
                    {
                          for i in 0..<arrmitems.count
                          {
                            let dict = arrmitems.object(at: i)as? NSMutableDictionary
                            let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                            let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                            if (strid == strprdid)
                            {
                                dict?.setValue(strUpdtatedqty, forKey: "qtyATA")
                                dict1?.setValue("1", forKey: "selected")
                            }
                          }
                        
                        if arrmitems.count == 0{
                            let dictttemp = NSMutableDictionary()
                            dictttemp.setValue(strid, forKey: "id")
                            dictttemp.setValue(strname, forKey: "name")
                            dictttemp.setValue(strprice, forKey: "price")
                            dictttemp.setValue("0", forKey: "qty")
                            dictttemp.setValue(strUpdtatedqty, forKey: "qtyATA")
                            
                            arrmitems.add(dictttemp as Any)
                            dict1?.setValue("1", forKey: "selected")
                        }
                     }
                }
            }
            print("appDel.arrMDATEWISEPRODUCTPLANMONTHLY",appDel.arrMDATEWISEPRODUCTPLANMONTHLY)
        }
        
        self.colproductlist.reloadData()
        self.colorderon.reloadData()
         
    }
    
    //MARK: - press PLUS / MINUS ADD TO ALL Method
    @objc func pressplusATA(sender:UIButton)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let dict = appDel.arrMproductlist.object(at: sender.tag)as! NSMutableDictionary
        let strid = String(format: "%@", dict.value(forKey: "id")as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qtyATA")as? String ?? "")
        var intqty = Int(strqty)
        if intqty! >= 0{
            intqty = intqty! + 1
        }
        print("intqty",intqty as Any)
        dict.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
        print("arrm >>>",appDel.arrMproductlist)
        
        let strUpdtatedqty = String(format: "%@", dict.value(forKey: "qtyATA")as? String ?? "")
        print("strUpdtatedqty",strUpdtatedqty)
        
        if strpageidentifier == "100"
        {
            //DAILY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLAN.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLAN.object(at: x)as? NSMutableDictionary
                let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                
                /*var condition = true
                loopReset: do {
                  for i in 0..<arrmitems.count
                    {
                      let dict = arrmitems.object(at: i)as? NSMutableDictionary
                      let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                      let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                      if (strid == strprdid) || strqty == "0"
                      {
                          arrmitems.removeObject(at: i)
                          condition = false
                          continue loopReset
                      }
                      print("index",i)
                      print("arrmitems",arrmitems)
                  }
                }*/
                
                if strUpdtatedqty != "0"
                {
                    /*arrmitems.add(dict)
                    dict1?.setValue("1", forKey: "selected")*/
                    
                    for i in 0..<arrmitems.count
                    {
                      let dict = arrmitems.object(at: i)as? NSMutableDictionary
                      let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                      let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                       var intqty = Int(strqty)
                      if (strid == strprdid)
                      {
                          intqty = intqty! + 1
                          dict?.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
                          dict1?.setValue("1", forKey: "selected")
                      }
                    }
                }
            }
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLANWEEKLY.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLANWEEKLY.object(at: x)as? NSMutableDictionary
                let strselected = String(format: "%@", dict1?.value(forKey: "selected")as? String ?? "")
                
                if strselected == "1"
                {
                    let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                    
                    /*var condition = true
                    loopReset: do {
                      for i in 0..<arrmitems.count
                        {
                          let dict = arrmitems.object(at: i)as? NSMutableDictionary
                          let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                          let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                          if (strid == strprdid) || strqty == "0"
                          {
                              arrmitems.removeObject(at: i)
                              condition = false
                              continue loopReset
                          }
                          print("index",i)
                          print("arrmitems",arrmitems)
                      }
                    }*/
                    
                    if strUpdtatedqty != "0"
                    {
                        /*arrmitems.add(dict)
                        dict1?.setValue("1", forKey: "selected")*/
                        for i in 0..<arrmitems.count
                        {
                          let dict = arrmitems.object(at: i)as? NSMutableDictionary
                          let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                          let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                           var intqty = Int(strqty)
                          if (strid == strprdid)
                          {
                              intqty = intqty! + 1
                              dict?.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
                              dict1?.setValue("1", forKey: "selected")
                          }
                        }
                    }
                }
                
            }
            print("appDel.arrMDATEWISEPRODUCTPLANWEEKLY",appDel.arrMDATEWISEPRODUCTPLANWEEKLY)
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLANMONTHLY.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLANMONTHLY.object(at: x)as? NSMutableDictionary
                let strselected = String(format: "%@", dict1?.value(forKey: "selected")as? String ?? "")
                
                if strselected == "1"
                {
                    let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                    
                    /*var condition = true
                    loopReset: do {
                      for i in 0..<arrmitems.count
                        {
                          let dict = arrmitems.object(at: i)as? NSMutableDictionary
                          let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                          let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                          if (strid == strprdid) || strqty == "0"
                          {
                              arrmitems.removeObject(at: i)
                              condition = false
                              continue loopReset
                          }
                          print("index",i)
                          print("arrmitems",arrmitems)
                      }
                    }*/

                    
                    if strUpdtatedqty != "0"
                    {
                        /*arrmitems.add(dict)
                        dict1?.setValue("1", forKey: "selected")*/
                        
                        for i in 0..<arrmitems.count
                        {
                          let dict = arrmitems.object(at: i)as? NSMutableDictionary
                          let strprdid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                          let strqty = String(format: "%@", dict?.value(forKey: "qtyATA")as? String ?? "")
                           var intqty = Int(strqty)
                          if (strid == strprdid)
                          {
                              intqty = intqty! + 1
                              dict?.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
                              dict1?.setValue("1", forKey: "selected")
                          }
                        }
                    }
                }
            }
            print("appDel.arrMDATEWISEPRODUCTPLANMONTHLY",appDel.arrMDATEWISEPRODUCTPLANMONTHLY)
        }
        
        self.colproductlist.reloadData()
        self.colorderon.reloadData()
    }
    @objc func pressminusATA(sender:UIButton)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let dict = appDel.arrMproductlist.object(at: sender.tag)as! NSMutableDictionary
        let strid = String(format: "%@", dict.value(forKey: "id")as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qtyATA")as? String ?? "")
        var intqty = Int(strqty)
        if intqty! >= 0{
            intqty = intqty! - 1
        }
        print("intqty",intqty as Any)
        dict.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
        print("arrm >>>",appDel.arrMproductlist)
        
        let strUpdtatedqty = String(format: "%@", dict.value(forKey: "qtyATA")as? String ?? "")
        print("strUpdtatedqty",strUpdtatedqty)
        
        if strpageidentifier == "100"
        {
            //DAILY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLAN.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLAN.object(at: x)as? NSMutableDictionary
                let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                
                for i in 0..<arrmitems.count
                {
                  let dict22 = arrmitems.object(at: i)as? NSMutableDictionary
                  let strid22 = String(format: "%@", dict22?.value(forKey: "id")as? String ?? "")
                  let strqtyATA = String(format: "%@", dict22?.value(forKey: "qtyATA")as? String ?? "")
                    var intqty = Int(strqtyATA)
                  if (strid == strid22)
                  {
                      intqty = intqty! - 1
                      
                      if intqty! <= 0{
                          arrmitems.removeObject(at: i)
                      }
                      else{
                          dict22!.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
                          dict1?.setValue("1", forKey: "selected")
                      }
                  }
                }
                
                
                /*if strUpdtatedqty != "0"
                {
                    arrmitems.add(dict)
                    dict1?.setValue("1", forKey: "selected")
                }*/
            }
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLANWEEKLY.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLANWEEKLY.object(at: x)as? NSMutableDictionary
                let strselected = String(format: "%@", dict1?.value(forKey: "selected")as? String ?? "")
                
                if strselected == "1"
                {
                    let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                    
                    for i in 0..<arrmitems.count
                    {
                      let dict22 = arrmitems.object(at: i)as? NSMutableDictionary
                      let strid22 = String(format: "%@", dict22?.value(forKey: "id")as? String ?? "")
                      let strqtyATA = String(format: "%@", dict22?.value(forKey: "qtyATA")as? String ?? "")
                        var intqty = Int(strqtyATA)
                      if (strid == strid22)
                      {
                          intqty = intqty! - 1
                          
                          if intqty! <= 0{
                              arrmitems.removeObject(at: i)
                          }
                          else{
                              dict22!.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
                              dict1?.setValue("1", forKey: "selected")
                          }
                      }
                    }
                    
                    /*if strUpdtatedqty != "0"
                    {
                        arrmitems.add(dict)
                        dict1?.setValue("1", forKey: "selected")
                    }*/
                }
            }
            print("appDel.arrMDATEWISEPRODUCTPLANWEEKLY",appDel.arrMDATEWISEPRODUCTPLANWEEKLY)
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            for x in 0 ..< appDel.arrMDATEWISEPRODUCTPLANMONTHLY.count
            {
                let dict1 = appDel.arrMDATEWISEPRODUCTPLANMONTHLY.object(at: x)as? NSMutableDictionary
                let strselected = String(format: "%@", dict1?.value(forKey: "selected")as? String ?? "")
                
                if strselected == "1"
                {
                    let arrmitems = dict1?.value(forKey: "items")as! NSMutableArray
                    
                    for i in 0..<arrmitems.count
                    {
                      let dict22 = arrmitems.object(at: i)as? NSMutableDictionary
                      let strid22 = String(format: "%@", dict22?.value(forKey: "id")as? String ?? "")
                      let strqtyATA = String(format: "%@", dict22?.value(forKey: "qtyATA")as? String ?? "")
                        var intqty = Int(strqtyATA)
                      if (strid == strid22)
                      {
                          intqty = intqty! - 1
                          
                          if intqty! <= 0{
                              arrmitems.removeObject(at: i)
                          }
                          else{
                              dict22!.setValue(String(format: "%d", intqty!), forKey: "qtyATA")
                              dict1?.setValue("1", forKey: "selected")
                          }
                      }
                    }
                    
                    /*if strUpdtatedqty != "0"
                    {
                        arrmitems.add(dict)
                        dict1?.setValue("1", forKey: "selected")
                    }*/
                }
            }
            print("appDel.arrMDATEWISEPRODUCTPLANMONTHLY",appDel.arrMDATEWISEPRODUCTPLANMONTHLY)
        }
        
        self.colproductlist.reloadData()
        self.colorderon.reloadData()
    }
    
    //MARK: - Update Sybscription Model Calss Array Locally
    @objc func updateSubscriptionmodelArray(dictproduct:NSMutableDictionary,strprdid:String,stridentifier:String)
    {
        print("stridentifier",stridentifier)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if stridentifier == "100"
        {
            //DAILY
            print("selectedindex",self.strSubscriptionselectediexdate)
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
            let intSelcetedIndex = Int(self.strSubscriptionselectediexdate)
            
            let dict = appDel.arrMDATEWISEPRODUCTPLAN.object(at: intSelcetedIndex!)as? NSMutableDictionary
            
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            let strtotalprice = String(format: "%@", dict?.value(forKey: "totalprice")as? String ?? "")
            
            let arrmitems = dict?.value(forKey: "items")as! NSMutableArray
            
            //From Product Listing Array
            let strUpdtatedqty = String(format: "%@", dictproduct.value(forKey: "qty")as? String ?? "")
            print("strUpdtatedqty",strUpdtatedqty)
            
            if strselected == "1"
            {
                var condition = true

                loopReset: do {
                  for i in 0..<arrmitems.count
                    {
                      let dict = arrmitems.object(at: i)as? NSMutableDictionary
                      let strid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                      let strqty = String(format: "%@", dict?.value(forKey: "qty")as? String ?? "")
                      if (strid == strprdid) || strqty == "0"
                      {
                          arrmitems.removeObject(at: i)
                          condition = false
                          continue loopReset
                      }
                      print("index",i)
                      print("arrmitems",arrmitems)
                  }
                }
                
                /*for var x in 0 ..< arrmitems.count
                {
                    let dict = arrmitems.object(at: x)as? NSMutableDictionary
                    let strid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                    let strqty = String(format: "%@", dict?.value(forKey: "qty")as? String ?? "")
                    if (strid == strprdid)
                    {
                        arrmitems.removeObject(at: x)
                        x = 0
                    }
                    print("arrmitems",arrmitems)
                }*/
                print("arrmitems",arrmitems)
                
                if strUpdtatedqty != "0"
                {
                    arrmitems.add(dictproduct)
                }
                else
                {
                }
            }
            print("arrmitems",arrmitems)
            
            print("dict---->>>",dict as Any)
            
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
            
            self.colproductlist.reloadData()
            self.colorderon.reloadData()
        }
        else if stridentifier == "200"
        {
            //WEEKLY
            print("selectedindex",self.strSubscriptionselectediexdate)
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLANWEEKLY)
            let intSelcetedIndex = Int(self.strSubscriptionselectediexdate)
            
            let dict = appDel.arrMDATEWISEPRODUCTPLANWEEKLY.object(at: intSelcetedIndex!)as? NSMutableDictionary
            
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            let strtotalprice = String(format: "%@", dict?.value(forKey: "totalprice")as? String ?? "")
            
            let arrmitems = dict?.value(forKey: "items")as! NSMutableArray
            print("arrmitems",arrmitems)
            
            //From Product Listing Array
            let strUpdtatedqty = String(format: "%@", dictproduct.value(forKey: "qty")as? String ?? "")
            print("strUpdtatedqty",strUpdtatedqty)
            
            if strselected == "1"
            {
                var condition = true

                loopReset: do {
                  for i in 0..<arrmitems.count
                    {
                      let dict = arrmitems.object(at: i)as? NSMutableDictionary
                      let strid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                      let strqty = String(format: "%@", dict?.value(forKey: "qty")as? String ?? "")
                      if (strid == strprdid) || strqty == "0"
                      {
                          arrmitems.removeObject(at: i)
                          condition = false
                          continue loopReset
                      }
                      print("index",i)
                      print("arrmitems",arrmitems)
                  }
                }
                
                /*for var x in 0 ..< arrmitems.count
                {
                    let dict = arrmitems.object(at: x)as? NSMutableDictionary
                    let strid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                    let strqty = String(format: "%@", dict?.value(forKey: "qty")as? String ?? "")
                    if (strid == strprdid)
                    {
                        arrmitems.removeObject(at: x)
                        x = 0
                    }
                    print("arrmitems",arrmitems)
                }*/
                print("arrmitems",arrmitems)
                
                if strUpdtatedqty != "0"
                {
                    arrmitems.add(dictproduct)
                }
                else
                {
                }
            }
            print("arrmitems",arrmitems)
            print("dict---->>>",dict as Any)
            
            print("appDel.arrMDATEWISEPRODUCTPLANWEEKLY",appDel.arrMDATEWISEPRODUCTPLANWEEKLY)
            
            self.colproductlist.reloadData()
            self.colorderon.reloadData()
        }
        else if stridentifier == "300"
        {
            //MONTHLY
            print("selectedindex",self.strSubscriptionselectediexdate)
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLANMONTHLY)
            let intSelcetedIndex = Int(self.strSubscriptionselectediexdate)
            
            let dict = appDel.arrMDATEWISEPRODUCTPLANMONTHLY.object(at: intSelcetedIndex!)as? NSMutableDictionary
            
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            let strtotalprice = String(format: "%@", dict?.value(forKey: "totalprice")as? String ?? "")
            let arrmitems = dict?.value(forKey: "items")as! NSMutableArray
            
            //From Product Listing Array
            let strUpdtatedqty = String(format: "%@", dictproduct.value(forKey: "qty")as? String ?? "")
            print("strUpdtatedqty",strUpdtatedqty)
            
            if strselected == "1"
            {
                var condition = true

                loopReset: do {
                  for i in 0..<arrmitems.count
                    {
                      let dict = arrmitems.object(at: i)as? NSMutableDictionary
                      let strid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                      let strqty = String(format: "%@", dict?.value(forKey: "qty")as? String ?? "")
                      if (strid == strprdid) || strqty == "0"
                      {
                          arrmitems.removeObject(at: i)
                          condition = false
                          continue loopReset
                      }
                      print("index",i)
                      print("arrmitems",arrmitems)
                  }
                }
                
                /*for var x in 0 ..< arrmitems.count
                {
                    let dict = arrmitems.object(at: x)as? NSMutableDictionary
                    let strid = String(format: "%@", dict?.value(forKey: "id")as? String ?? "")
                    let strqty = String(format: "%@", dict?.value(forKey: "qty")as? String ?? "")
                    if (strid == strprdid)
                    {
                        arrmitems.removeObject(at: x)
                        x = 0
                    }
                    print("arrmitems",arrmitems)
                }*/
                print("arrmitems",arrmitems)
                
                if strUpdtatedqty != "0"
                {
                    arrmitems.add(dictproduct)
                }
                else
                {
                }
            }
            print("arrmitems",arrmitems)
            
            print("dict---->>>",dict as Any)
            
            print("appDel.arrMDATEWISEPRODUCTPLANMONTHLY",appDel.arrMDATEWISEPRODUCTPLANMONTHLY)
            
            self.colproductlist.reloadData()
            self.colorderon.reloadData()
        }
        
    }
    
    
    
    //MARK: - get Product Listing From Category ID API method
    func getProductListingFromCategoryIDAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?categoryId=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod10,strFromCategoryID)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        if strbearertoken != ""{
            request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    //print("dictemp --->",dictemp)
                   
                    
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            let arrmproducts = json.value(forKey: "product") as? NSArray ?? []
                            self.arrMCategorywiseProductlist = NSMutableArray(array: arrmproducts)
                            print("arrMCategorywiseProductlist --->",self.arrMCategorywiseProductlist)
                            
                            if self.arrMCategorywiseProductlist.count == 0{
                                self.msg = "No products found!"
                            }
                            self.colproductlist.reloadData()
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Add to Wishlist Product Details API method
    func postAddtoWishlistAPIMethod(strproductid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
      
        let parameters = ["productid": strproductid
                          ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod12)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_networkerror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_wishlistadd") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))

                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Add To Cart API Method
    func postAddToCartApiMethod(strqty:String,strproductid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["customerId": strcustomerid,
                          "productId": strproductid,
                          "productQuantity": strqty] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod16)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_networkerror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_addtocart") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
}
