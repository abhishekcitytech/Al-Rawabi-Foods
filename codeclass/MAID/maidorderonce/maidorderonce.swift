//
//  maidorderonce.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 29/11/22.
//

import UIKit

class maidorderonce: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var colproductlist: UICollectionView!
    var reuseIdentifier1 = "cellcolbuyonce"
    var msg = ""
    
    //catrgoey carousal
    @IBOutlet weak var viewcategorycarousal: UIView!
    @IBOutlet weak var colcategory: UICollectionView!
    var reuseIdentifier2 = "colcellcat"
    
    var arrmcatlist = NSMutableArray()
    var strSelectedCat = ""
    
    var arrMproducts = NSMutableArray()
    
    var arrMAvailbleTimeSlots = NSMutableArray()

    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        
        setupRTLLTR()
        
        createCategoryGallery()
        postAllCategoryHomepageAPImethod()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language104")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
        
        colproductlist.backgroundColor = .clear
        let layout = colproductlist.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2.0 - 15, height: 275)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colproductlist.register(UINib(nibName: "cellcolbuyonce", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colproductlist.showsVerticalScrollIndicator = false
        colproductlist.showsHorizontalScrollIndicator = false
        
       
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Cartbag method
    @objc func presscartbag()
    {
        let ctrl = maidcartlist(nibName: "maidcartlist", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - Set Up Right Bar Cart Bag Item UI Design Method
    @objc func setupRightBarCartBagDesignMethod(intcountOrder:Int)
    {
        let badgeCount = UILabel(frame: CGRect(x: 20, y: -4, width: 20, height: 20))
        badgeCount.layer.borderColor = UIColor.clear.cgColor
        badgeCount.layer.borderWidth = 0
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = UIFont(name: "NunitoSans-Regular", size: 12.5)
        badgeCount.backgroundColor = UIColor(red: 239/255, green: 53/255, blue: 48/255, alpha: 1.0)
        badgeCount.text = String(format: "%d", intcountOrder)
        
        let rightBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        rightBarButton.setBackgroundImage(UIImage(named: "cartbag"), for: .normal)
        //rightBarButton.tintColor = .black
        rightBarButton.addTarget(self, action: #selector(presscartbag), for: .touchUpInside)
        rightBarButton.addSubview(badgeCount)
        let rightBarButtomItem = UIBarButtonItem(customView: rightBarButton)
        
        let stackViewAppearance = UIStackView.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        stackViewAppearance.spacing = 1
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            navigationItem.rightBarButtonItems = [rightBarButtomItem]
        }
        else{
            navigationItem.leftBarButtonItems = [rightBarButtomItem]
        }
        
    }
    
    //MARK: - press Search method
    /*@objc func pressSearch()
    {
        let ctrl = searchproductlist(nibName: "searchproductlist", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }*/
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            
        }
        else
        {
            
        }
        
    }

    
    //MARK: - create select category gallery method
    func createCategoryGallery()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colcategory.frame.size.width / 3.5, height: 60)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colcategory.collectionViewLayout = layout
        colcategory.register(UINib(nibName: "colcellcat", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
        colcategory.showsHorizontalScrollIndicator = false
        colcategory.showsVerticalScrollIndicator=false
        colcategory.backgroundColor = .clear
    }
    


    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView ==  colcategory
        {
            return arrmcatlist.count
        }
        
        if arrMproducts.count == 0 {
            self.colproductlist.setEmptyMessage(msg)
        } else {
            self.colproductlist.restore()
        }
        return arrMproducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.colcategory
        {
            
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! colcellcat
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            let dict = arrmcatlist.object(at: indexPath.row) as! NSDictionary
            
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            //let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            let strcategoryImage = String(format: "%@", dict.value(forKey: "categoryImage") as? String ?? "")
            let strFinalurl = strcategoryImage.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
            
            cellA.viewcell.layer.cornerRadius = 6.0
            cellA.viewcell.layer.masksToBounds = true
            
            
            
            if strtext.containsIgnoreCase("Dairy"){
                cellA.viewcell.backgroundColor = UIColor(named: "plate1")!
            }
            else if strtext.containsIgnoreCase("Juice"){
                cellA.viewcell.backgroundColor = UIColor(named: "plate2")!
            }
            else if strtext.containsIgnoreCase("Bakery"){
                cellA.viewcell.backgroundColor = UIColor(named: "plate3")!
            }
            else if strtext.containsIgnoreCase("Meat"){
                cellA.viewcell.backgroundColor = UIColor(named: "plate4")!
            }
            else if strtext.containsIgnoreCase("Functional"){
                cellA.viewcell.backgroundColor = UIColor(named: "plate5")!
            }
            else{
                cellA.viewcell.backgroundColor = UIColor(named: "plate7")!
            }
            
            cellA.lblcell.text =  strtext
            
            
            
            if self.strSelectedCat == String(format: "%d", indexPath.row){
                cellA.viewcell.layer.borderWidth = 2.0
                cellA.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
                cellA.viewcell.layer.cornerRadius = 6.0
                cellA.viewcell.layer.masksToBounds = true
            }
            else{
                cellA.viewcell.layer.borderWidth = 2.0
                cellA.viewcell.layer.borderColor = UIColor.clear.cgColor
                cellA.viewcell.layer.cornerRadius = 6.0
                cellA.viewcell.layer.masksToBounds = true
            }
            
            // Set up cell
            return cellA
        }
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! cellcolbuyonce
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 8.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let dict = arrMproducts.object(at: indexPath.row)as? NSDictionary
        
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
        }
        else{
            
            let stris_addedwishlist = String(format: "%@", dict!.value(forKey: "is_addedwishlist") as? String ?? "")
            
            print("stris_addedwishlist",stris_addedwishlist)
            if stris_addedwishlist == "True"
            {
                cellA.btnfav.setImage(UIImage(named: "favselected"), for: .normal)
            }
            
            cellA.btnfav.isHidden = false
        }
        
        cellA.viewcell.layer.cornerRadius = 8.0
        cellA.viewcell.layer.masksToBounds = true
        
        
        cellA.btnaddtocart.layer.borderWidth = 1.0
        cellA.btnaddtocart.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        cellA.btnaddtocart.layer.cornerRadius = 16.0
        cellA.btnaddtocart.layer.masksToBounds = true
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        cellA.btnaddtocart.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language47")), for: .normal)
        
        cellA.btnaddtocart.tag = indexPath.row
        cellA.btnaddtocart.addTarget(self, action: #selector(pressAddtoCart), for: .touchUpInside)
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.colcategory
        {
            let dict = arrmcatlist.object(at: indexPath.row) as! NSDictionary
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            
            self.strSelectedCat = String(format: "%d", indexPath.row)
            self.colcategory.reloadData()
            
            self.getProductListingAPIMethod(strselectedcategoryid: strid)
        }
        else{
            
            let dict = arrMproducts.object(at: indexPath.row)as? NSDictionary
            let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            
            //let ctrl = porudctdetails(nibName: "porudctdetails", bundle: nil)
            //ctrl.strSelectedProductID = strproductid
            //ctrl.strFrompageIdentifier = "1001"
            //self.navigationController?.pushViewController(ctrl, animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
  
    //MARK: - press Add To Cart Method
    @objc func pressAddtoCart(sender:UIButton)
    {
        let dict = arrMproducts.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        self.postAddToCartApiMethod(strqty: "1", strproductid: strproductid)
    }
    
    
    //MARK: - post All Category Home Page method
    func postAllCategoryHomepageAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        //let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        //print("strbearertoken",strbearertoken)
        
        let parameters = ["categoryCount": "none",
                          "categoryImage": "all",
                          "categoryName": "none",
                          "categoryId": "none"] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod9)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        //request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
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
                            let arrmcategorytree = dictemp.value(forKey: "categoryTree") as? NSArray ?? []
                            self.arrmcatlist = NSMutableArray(array: arrmcategorytree)
                            print("arrmcatlist --->",self.arrmcatlist)
                            
                            if self.arrmcatlist.count > 0{
                                self.colcategory.reloadData()
                            }
                            
                            //BY DEFAULT SELECTED CATEGORY FIXME
                            self.strSelectedCat = "0"
                            let dict = self.arrmcatlist.object(at: 0) as! NSDictionary
                            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
                            self.getProductListingAPIMethod(strselectedcategoryid: strid)
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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
    
    //MARK: - get Product Listing API method
    func getProductListingAPIMethod(strselectedcategoryid:String)
    {
        if self.arrMproducts.count > 0{
            self.arrMproducts.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?categoryId=%@&product_name=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod10,strselectedcategoryid,"")
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
                        self.getOrderOnceCartCountAPIMethod()
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
                            self.arrMproducts = NSMutableArray(array: arrmproducts)
                            print("arrMproducts --->",self.arrMproducts)
                            
                            if self.arrMproducts.count == 0{
                                self.msg = "No products found!"
                            }
                            self.colproductlist.reloadData()
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        self.getOrderOnceCartCountAPIMethod()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.getOrderOnceCartCountAPIMethod()
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
        
        let strcustomerid = UserDefaults.standard.value(forKey: "maidid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)

        
        let parameters = ["customerId": strcustomerid,
                          "productId": strproductid,
                          "productQuantity": strqty] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod16)
        print("strconnurl",strconnurl)
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
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
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                                self.getOrderOnceCartCountAPIMethod()
                            }))
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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
    
    //MARK: - get Order Once Cart Count API method
    func getOrderOnceCartCountAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        /*let parameters = ["productid": strSelectedProductID
         ] as [String : Any]*/
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod29)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        //let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        //print("json string = \(jsonString)")
        //request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
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
                            if let total_quantity = json["total_quantity"]
                            {
                                print("found!")
                                
                                let strqty = dictemp.value(forKey: "total_quantity")as! CVarArg
                                UserDefaults.standard.set(strqty, forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                
                                let strcount = UserDefaults.standard.value(forKey: "orderoncecartcount")as? Int ?? 0
                                print("strcount",strcount)
                                self.setupRightBarCartBagDesignMethod(intcountOrder: strcount)
                            }
                            else{
                                print("Not found!")
                                
                                UserDefaults.standard.set("0", forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
                                
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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

                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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