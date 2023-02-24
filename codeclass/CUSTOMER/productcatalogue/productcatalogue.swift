//
//  productcatalogue.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/06/22.
//

import UIKit

class productcatalogue: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var colproductlist: UICollectionView!
    var reuseIdentifier1 = "colcelltopdeals"
    @IBOutlet weak var btnfilter: UIButton!
    var msg = ""
    
    
    @IBOutlet weak var viewfloatcart: UIView!
    @IBOutlet weak var imgvfloatcart: UIImageView!
    @IBOutlet weak var lblfloatcartcount: UILabel!
    @IBOutlet weak var btnfloatcart: UIButton!
    
    
    //sub catrgoet carousal
    @IBOutlet weak var viewsubcategorycarousal: UIView!
    @IBOutlet weak var colsubcategory: UICollectionView!
    var reuseIdentifier2 = "colcellcat"
    var arrmsubcatlist = NSMutableArray()
    var strSelectedSubCat = ""
    
    
    @IBOutlet weak var viewsearchbox: UIView!
    @IBOutlet weak var viewsearchbox1: UIView!
    @IBOutlet weak var txtsearchbox: UITextField!
    
    @IBOutlet weak var btnsortby: UIButton!
    
    
    var strpageidentifier = ""
    var arrmdatblocks = NSMutableArray()
    var strSubscriptionselectediexdate = ""
    
    var strFromCategoryID = ""
    var strFromCategoryNAME = ""
    
    var arrMCategorywiseProductlist = NSMutableArray()
    
    
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
        
        print("arrmsubcatlist",arrmsubcatlist)
        
        
        setupRTLLTR()
        
        if strpageidentifier == "1001"
        {
            print("FROM CATEGORY PAGE")
            self.getProductListingFromCategoryIDAPIMethod()
        }
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if strFromCategoryNAME.count > 0 {
            self.title = strFromCategoryNAME
        }else{
            self.title = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language147"))
        }
        
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        var floatDevider = 0.0
        //FIXMEDEVICETYPE
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            // iPad
            let screenSize = UIScreen.main.bounds
            if (screenSize.height == 1024){
                print("7.9 inch")
            }
            else if(screenSize.height == 1133){
                print("8.3 inch")
            }
            else if(screenSize.height == 1024){
                print("9.7 inch")
            }
            else if(screenSize.height == 1080){
                print("10.2 inch")
            }
            else if(screenSize.height == 1112){
                print("10.5 inch")
            }
            else if(screenSize.height == 1180){
                print("10.9 inch")
            }
            else if(screenSize.height == 1194){
                print("11 inch")
            }
            else if(screenSize.height == 1366){
                print("12.9 inch")
            }
            else{
                
            }
            floatDevider = 3.0
        }
        else
        {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            floatDevider = 2.0
        }
        
        colproductlist.backgroundColor = .clear
        let layout = colproductlist.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/floatDevider - 15, height: 275)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colproductlist.register(UINib(nibName: "colcelltopdeals", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colproductlist.showsVerticalScrollIndicator = false
        colproductlist.showsHorizontalScrollIndicator = false
        
        viewsearchbox.layer.cornerRadius = 16.0
        viewsearchbox.layer.masksToBounds = true
        
        self.viewfloatcart.backgroundColor = .clear
        self.lblfloatcartcount.layer.cornerRadius = self.lblfloatcartcount.frame.self.width / 2.0
        self.lblfloatcartcount.layer.masksToBounds = true
        
        self.createSubCategoryGallery()
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Sortby Method
    @IBAction func pressSortby(_ sender: Any){
        
    }
    
    //MARK: - press filter method
    @IBAction func pressfilter(_ sender: Any)
    {
        let ctrl = productfilerpage(nibName: "productfilerpage", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press FLOAT CART METHOD
    @IBAction func pressFloatCart(_ sender: Any)
    {
        let ctrl = cartlistorderonce(nibName: "cartlistorderonce", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    //MARK: - create select category gallery method
    func createSubCategoryGallery()
    {
        var floatDevider = 0.0
        //FIXMEDEVICETYPE
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            // iPad
            let screenSize = UIScreen.main.bounds
            if (screenSize.height == 1024){
                print("7.9 inch")
            }
            else if(screenSize.height == 1133){
                print("8.3 inch")
            }
            else if(screenSize.height == 1024){
                print("9.7 inch")
            }
            else if(screenSize.height == 1080){
                print("10.2 inch")
            }
            else if(screenSize.height == 1112){
                print("10.5 inch")
            }
            else if(screenSize.height == 1180){
                print("10.9 inch")
            }
            else if(screenSize.height == 1194){
                print("11 inch")
            }
            else if(screenSize.height == 1366){
                print("12.9 inch")
            }
            else{
                
            }
            
            if arrmsubcatlist.count >= 3{
                floatDevider = 2.4
            }else{
                floatDevider = 2
            }
        }
        else
        {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            if arrmsubcatlist.count >= 3{
                floatDevider = 3.5
            }else{
                floatDevider = 1.8
            }
        }
        print("floatDevider",floatDevider)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colsubcategory.frame.size.width / floatDevider, height: 44)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colsubcategory.collectionViewLayout = layout
        colsubcategory.register(UINib(nibName: "colcellcat", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
        colsubcategory.showsHorizontalScrollIndicator = false
        colsubcategory.showsVerticalScrollIndicator=false
        colsubcategory.backgroundColor = .clear
        
        if arrmsubcatlist.count == 0{
            //NO SUB CATEGORY FOUND
            self.viewsubcategorycarousal.isHidden = true
            self.colproductlist.frame = CGRect(x: self.colproductlist.frame.origin.x, y: self.viewsubcategorycarousal.frame.minY, width: self.colproductlist.frame.size.width, height: self.colproductlist.frame.size.height + self.viewsubcategorycarousal.frame.size.height)
        }else{
            
            let dict = arrmsubcatlist.object(at: 0) as! NSDictionary
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            print("strid",strid)
            self.strSelectedSubCat = String(format: "%@", strid)
            
            self.viewsubcategorycarousal.isHidden = false
            self.colproductlist.frame = CGRect(x: self.colproductlist.frame.origin.x, y: self.viewsubcategorycarousal.frame.maxY, width: self.colproductlist.frame.size.width, height: self.colproductlist.frame.size.height)
        }
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        txtsearchbox.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language80"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.viewsearchbox1.frame = CGRect(x: 1, y: self.viewsearchbox1.frame.origin.y, width: self.viewsearchbox1.frame.size.width, height: self.viewsearchbox1.frame.size.height)
            
            self.txtsearchbox.frame = CGRect(x: 54, y: self.txtsearchbox.frame.origin.y, width: self.txtsearchbox.frame.size.width, height: self.txtsearchbox.frame.size.height)
            self.txtsearchbox.textAlignment = .left
        }
        else{
            
            self.viewsearchbox1.frame = CGRect(x: self.viewsearchbox.frame.size.width - 53, y: self.viewsearchbox1.frame.origin.y, width: self.viewsearchbox1.frame.size.width, height: self.viewsearchbox1.frame.size.height)
            
            self.txtsearchbox.frame = CGRect(x: 1, y: self.txtsearchbox.frame.origin.y, width: self.txtsearchbox.frame.size.width, height: self.txtsearchbox.frame.size.height)
            self.txtsearchbox.textAlignment = .right
            
        }
        
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
        if textField == txtsearchbox
        {
            self.getProductListingFromCategoryIDAPIMethod()
        }
        
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView ==  colsubcategory
        {
            return arrmsubcatlist.count
        }
        
        //FROM CATEGORY PAGE
        if arrMCategorywiseProductlist.count == 0 {
            self.colproductlist.setEmptyMessage(msg)
        } else {
            self.colproductlist.restore()
        }
        return arrMCategorywiseProductlist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if collectionView == self.colsubcategory
        {
            
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! colcellcat
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            let dict = arrmsubcatlist.object(at: indexPath.row) as! NSDictionary
            
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            //let strcategoryImage = String(format: "%@", dict.value(forKey: "childCategoryImage") as? String ?? "")
            //let strFinalurl = strcategoryImage.replacingOccurrences(of: " ", with: "%20")
            //print("strFinalurl",strFinalurl)
            
            cellA.viewcell.layer.cornerRadius = 6.0
            cellA.viewcell.layer.masksToBounds = true
            
            
            cellA.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
            cellA.lblcell.text =  strtext
            
            
            if self.strSelectedSubCat == strid
            {
                cellA.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
                cellA.viewcell.layer.borderWidth = 4.0
                cellA.viewcell.layer.borderColor = UIColor(named: "darkgreencolor")!.cgColor
                cellA.viewcell.layer.cornerRadius = 6.0
                cellA.viewcell.layer.masksToBounds = true
            }
            else{
                cellA.viewcell.backgroundColor = UIColor(named: "graybordercolor")!
                cellA.viewcell.layer.borderWidth = 2.0
                cellA.viewcell.layer.borderColor = UIColor.clear.cgColor
                cellA.viewcell.layer.cornerRadius = 6.0
                cellA.viewcell.layer.masksToBounds = true
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
                cellA.imgv.image = UIImage(named: "productplaceholder")
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
                else{
                    cellA.btnfav.setImage(UIImage(named: "fav1"), for: .normal)
                }
                
                cellA.btnfav.isHidden = false
                cellA.btnright.isHidden = true
            }
            
        }
        
        cellA.lblincludetax.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language474"))
        
        cellA.btnaddonce.layer.borderWidth = 1.0
        cellA.btnaddonce.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        cellA.btnaddonce.layer.cornerRadius = 16.0
        cellA.btnaddonce.layer.masksToBounds = true
        
        cellA.viewcell.layer.cornerRadius = 8.0
        cellA.viewcell.layer.masksToBounds = true
        
        cellA.btnaddonce.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language47")), for: .normal)
        
        cellA.btnaddonce.tag = indexPath.row
        cellA.btnaddonce.addTarget(self, action: #selector(pressaddonce), for: .touchUpInside)
        
        cellA.btnfav.tag = indexPath.row
        cellA.btnfav.addTarget(self, action: #selector(pressAddToWishlist), for: .touchUpInside)
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.colsubcategory
        {
            let dict = arrmsubcatlist.object(at: indexPath.row) as! NSDictionary
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            
            print("strid",strid)
            print("strtext",strtext)
            
            self.strSelectedSubCat = String(format: "%@", strid)
            self.colsubcategory.reloadData()
            
            print("self.strSelectedSubCat",self.strSelectedSubCat)
            
            self.getProductListingFromCategoryIDAPIMethod()
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if strpageidentifier == "1001"
        {
            //FROM CATEGORY PAGE
            let dict = arrMCategorywiseProductlist.object(at: sender.tag)as? NSDictionary
            let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            
            let stris_addedwishlist = String(format: "%@", dict!.value(forKey: "is_addedwishlist") as? String ?? "")
            print("stris_addedwishlist",stris_addedwishlist)
            if stris_addedwishlist != "True"
            {
                let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language149"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")
                    self.postAddtoWishlistAPIMethod(strproductid: strproductid)
                }))
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
            else{
                let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language152"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")
                    self.postRemoveFromWishlistAPIMethod(strSelectedProductID: strproductid)
                }))
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
            
            
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
        }
        
    }
    
    
    
    //MARK: - get Product Listing From Category ID API method
    func getProductListingFromCategoryIDAPIMethod()
    {
        if self.arrMCategorywiseProductlist.count > 0{
            self.arrMCategorywiseProductlist.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strsearchkeyword = String(format: "%@", self.txtsearchbox.text!)
        if strsearchkeyword == " " || strsearchkeyword == "" || strsearchkeyword.count == 0{
            strsearchkeyword = ""
        }
        
        print("strFromCategoryID",strFromCategoryID)
        
        strsearchkeyword = strsearchkeyword.replacingOccurrences(of: " ", with: "%20")
        print("strsearchkeyword",strsearchkeyword)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?categoryId=%@&product_name=%@&subCategoryId=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod10,strFromCategoryID,strsearchkeyword,strSelectedSubCat,strLangCode)
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
                    
                    print("json --->",json)
                    let dictemp = json as NSDictionary
                    //print("dictemp --->",dictemp)
                    
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            
                            if self.arrMCategorywiseProductlist.count > 0{
                                self.arrMCategorywiseProductlist.removeAllObjects()
                            }
                            
                            let arrmproducts = json.value(forKey: "product") as? NSArray ?? []
                            self.arrMCategorywiseProductlist = NSMutableArray(array: arrmproducts)
                            //print("arrMCategorywiseProductlist --->",self.arrMCategorywiseProductlist)
                            
                            if self.arrMCategorywiseProductlist.count == 0{
                                self.msg = "No products found!"
                            }
                            self.colproductlist.reloadData()
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        self.colproductlist.reloadData()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.colproductlist.reloadData()
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
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
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
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language269") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getProductListingFromCategoryIDAPIMethod()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
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
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
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
                            var strupdatedmessg = ""
                            if strmessage.contains("Item added successfully")
                            {
                                strupdatedmessg = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language386"))
                            }else{
                                strupdatedmessg = strmessage
                            }
                            
                            let uiAlert = UIAlertController(title: "", message: strupdatedmessg , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getProductListingFromCategoryIDAPIMethod()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Remove From Wishlist Product Details API method
    func postRemoveFromWishlistAPIMethod(strSelectedProductID:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["productid": strSelectedProductID
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod31)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
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
                            self.getProductListingFromCategoryIDAPIMethod()
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
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
