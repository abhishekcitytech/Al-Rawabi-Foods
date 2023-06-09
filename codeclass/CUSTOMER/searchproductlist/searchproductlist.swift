//
//  searchproductlist.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 16/09/22.
//

import UIKit

class searchproductlist: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{

    @IBOutlet var viewoverall: UIView!
    
    @IBOutlet var viewtopsearch: UIView!
    @IBOutlet var txtsearchbar: UITextField!
    @IBOutlet var btncrosssearch: UIButton!
    
    @IBOutlet weak var viewfloatcart: UIView!
    @IBOutlet weak var imgvfloatcart: UIImageView!
    @IBOutlet weak var lblfloatcartcount: UILabel!
    @IBOutlet weak var btnfloatcart: UIButton!
    
    
    @IBOutlet weak var colproductlist: UICollectionView!
    var reuseIdentifier1 = "colcelltopdeals"
    var msg = ""
    
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
        
        setupRTLLTR()
        
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        addSwipe()
        
        self.title = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language265"))
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        if strbearertoken != ""{
            self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
        }
        
        
        self.viewfloatcart.backgroundColor = .clear
        self.lblfloatcartcount.layer.cornerRadius = self.lblfloatcartcount.frame.self.width / 2.0
        self.lblfloatcartcount.layer.masksToBounds = true
        
        txtsearchbar.layer.cornerRadius = 16.0
        txtsearchbar.layer.masksToBounds = true
        txtsearchbar.setLeftPaddingPoints(10.0)
        
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/floatDevider - 15, height: 350)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colproductlist.register(UINib(nibName: "colcelltopdeals", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colproductlist.showsVerticalScrollIndicator = false
        colproductlist.showsHorizontalScrollIndicator = false
        
        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: "")
    }
    
    
    //MARK: - Gesture Motion Control Method
    func addSwipe()
    {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)// self.view
        }
    }
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        switch direction {
            case .right:
                print("Gesture direction: Right")
            self.pressBack()
            case .left:
                print("Gesture direction: Left")
            default:
                print("Unrecognized Gesture Direction")
        }
    }
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
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
        navigationItem.rightBarButtonItems = [rightBarButtomItem]
    }
    @objc func presscartbag()
    {
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.tabBarController?.selectedIndex = 3
        }else{
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    //MARK: - press Cross Search Method
    @IBAction func pressCrossSearch(_ sender: Any)
    {
        self.txtsearchbar.text = ""
        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: txtsearchbar.text!)
    }
    
    //MARK: - press FLOAT CART METHOD
    @IBAction func pressFloatCart(_ sender: Any)
    {
        let ctrl = cartlistorderonce(nibName: "cartlistorderonce", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        txtsearchbar.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language80"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.btncrosssearch.frame = CGRect(x: self.viewtopsearch.frame.size.width - self.btncrosssearch.frame.size.width - 8, y: self.btncrosssearch.frame.origin.y, width: self.btncrosssearch.frame.size.width, height: self.btncrosssearch.frame.size.height)
            
            self.txtsearchbar.frame = CGRect(x: 8, y: self.txtsearchbar.frame.origin.y, width: self.txtsearchbar.frame.size.width, height: self.txtsearchbar.frame.size.height)
            self.txtsearchbar.textAlignment = .left
        }
        else{
            
            self.btncrosssearch.frame = CGRect(x: 8, y: self.btncrosssearch.frame.origin.y, width: self.btncrosssearch.frame.size.width, height: self.btncrosssearch.frame.size.height)
            
            self.txtsearchbar.frame = CGRect(x: self.btncrosssearch.frame.maxX + 5, y: self.txtsearchbar.frame.origin.y, width: self.txtsearchbar.frame.size.width, height: self.txtsearchbar.frame.size.height)
            self.txtsearchbar.textAlignment = .right
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
        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: self.txtsearchbar.text!)
        
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
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
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcelltopdeals
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 8.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        
        let dict = arrMCategorywiseProductlist.object(at: indexPath.row)as? NSDictionary
        
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strname = String(format: "%@", dict!.value(forKey: "name") as? String ?? "")
        let strsku = String(format: "%@", dict!.value(forKey: "sku") as? String ?? "")
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        let strsize = String(format: "%@", dict!.value(forKey: "size") as? String ?? "")
        let strbrand = String(format: "%@", dict!.value(forKey: "brand") as? String ?? "")
        let strstatus = String(format: "%@", dict!.value(forKey: "productStatus") as? String ?? "")
        
        var strcurrent_currencecode = String(format: "%@", dict!.value(forKey: "current_currencecode") as? String ?? "")
        strcurrent_currencecode = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
        
        let strin_cart = String(format: "%@", dict!.value(forKey: "in_cart") as! CVarArg)
        
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
        
        // if you need to Left to right flow //FIXMESIZE
        let addLTR = "\u{200E}\(strsize)"
        cellA.lblqty.text = addLTR
        
        print("strprice",strprice)
        if strprice != ""
        {
            //let fltprice = Float(strprice)
            //cellA.lblprice.text = String(format: "%@ %.2f",strcurrent_currencecode,fltprice!)
            //cellA.lblincludetax.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language474"))
            
            //FIXMEPRICEVAT
            let str2 = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language474"))
            let fltprice = Float(strprice)
            let str1 = String(format: "%@ %.2f %@",myAppDelegate.changeLanguage(key: "msg_language481"), fltprice!,str2)
            
            let range = (str1 as NSString).range(of: str2)
            let mutableAttributedString = NSMutableAttributedString.init(string: str1)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "themecolor")!, range: range);
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont(name: "NunitoSans-Regular", size: 10) as Any], range: range)
            cellA.lblprice.attributedText = mutableAttributedString
        }
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            cellA.lblname.textAlignment = .left
            cellA.lblbrand.textAlignment = .left
            cellA.lblqty.textAlignment = .left
            cellA.lblprice.textAlignment = .left
        }
        else
        {
            cellA.lblname.textAlignment = .right
            cellA.lblbrand.textAlignment = .right
            cellA.lblqty.textAlignment = .right
            cellA.lblprice.textAlignment = .right
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
        
        cellA.viewPlusMinus.layer.borderWidth = 1.0
        cellA.viewPlusMinus.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        cellA.viewPlusMinus.layer.cornerRadius = 16.0
        cellA.viewPlusMinus.layer.masksToBounds = true
        
        cellA.btnMinusCart.tag = indexPath.row
        cellA.btnMinusCart.addTarget(self, action: #selector(pressMinusCart), for: .touchUpInside)
        cellA.btnPlusCart.tag = indexPath.row
        cellA.btnPlusCart.addTarget(self, action: #selector(pressPlusCart), for: .touchUpInside)
        
        //FIXMESTOCK
        let strstock = String(format: "%@", dict!.value(forKey: "stock") as! CVarArg)
        let strstock_status = String(format: "%@", dict!.value(forKey: "stock_status") as? String ?? "")
        print("strstock",strstock)
        print("strstock_status",strstock_status)
        
        cellA.lbloutofstock.layer.borderWidth = 1.0
        cellA.lbloutofstock.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cellA.lbloutofstock.layer.cornerRadius = 16.0
        cellA.lbloutofstock.layer.masksToBounds = true

        
        print("strin_cart",strin_cart)
        if strin_cart == "0"{
            print("NOT IN CART")
            
            
            if strstock == "0"{
                //Out of stock
                cellA.lbloutofstock.isHidden = false
                cellA.btnaddonce.isHidden = true
                cellA.viewPlusMinus.isHidden = true
                cellA.lbloutofstock.text = strstock_status
                
            }else{
                //in stock
                cellA.lbloutofstock.isHidden = true
                cellA.btnaddonce.isHidden = false
                cellA.viewPlusMinus.isHidden = true
            }
        }
        else{
            print("WITHIN CART")
            
            
            if strstock == "0"{
                //Out of stock
                cellA.lbloutofstock.isHidden = false
                cellA.btnaddonce.isHidden = true
                cellA.viewPlusMinus.isHidden = true
                cellA.lbloutofstock.text = strstock_status
                
            }else{
                //in stock
                cellA.lbloutofstock.isHidden = true
                cellA.btnaddonce.isHidden = true
                cellA.viewPlusMinus.isHidden = false
                cellA.txtMinusPlusCart.text = strin_cart
            }
        }
        
        
        //FIXMELOGINCHECK
        print("strbearertoken",strbearertoken)
        if strbearertoken == ""{
            
            
            cellA.btnfav.isHidden = true
            cellA.btnaddonce.isHidden = false
            cellA.viewPlusMinus.isHidden = true
            
            //cellA.btnaddonce.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language512")), for: .normal)
        }
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dict = arrMCategorywiseProductlist.object(at: indexPath.row)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strproductUrl = String(format: "%@", dict!.value(forKey: "productUrl") as? String ?? "")
        
        let ctrl = porudctdetails(nibName: "porudctdetails", bundle: nil)
        ctrl.strSelectedProductID = strproductid
        ctrl.strFrompageIdentifier = "1001"
        ctrl.strShareableProductUrl = strproductUrl
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
    //MARK: - press PLUS MINUS BUY ONCE CART QUANTITY METHOD
    @objc func pressMinusCart(sender:UIButton)
    {
        let dict = arrMCategorywiseProductlist.object(at: sender.tag) as! NSDictionary
        let strproductid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
        let strin_cart = String(format: "%@", dict.value(forKey: "in_cart") as! CVarArg)
        let stritem_id = String(format: "%@", dict.value(forKey: "item_id") as! CVarArg)
        let strquote_id = String(format: "%@", dict.value(forKey: "quote_id") as! CVarArg)
        print("strproductid %@ + strin_cart %@",strproductid,strin_cart)
        
        var intqty = (strin_cart as NSString).intValue
        print("intqty",intqty as Any)
        if intqty >= 0{
            intqty = intqty - 1
        }
        else{
            //product qunatity item 0 - Add to cart button will show
        }
        print("intqty",intqty as Any)
        
        if intqty == 0
        {
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //product qunatity item 0 - Add to cart button will show
            
            /*let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language115"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                
                self.postCartListRemoveItemAPIMethod(stritemid: stritem_id, strquoteid: strquote_id)
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)*/
            
            self.postCartListRemoveItemAPIMethod(stritemid: stritem_id, strquoteid: strquote_id)
            
        }
        else
        {
            self.postCartListUpdateQTYItemAPIMethod(stritemid: stritem_id, strquoteid: strquote_id, strproductQty: String(format: "%d", intqty))
        }
    }
    @objc func pressPlusCart(sender:UIButton)
    {
        let dict = arrMCategorywiseProductlist.object(at: sender.tag) as! NSDictionary
        let strproductid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
        let strin_cart = String(format: "%@", dict.value(forKey: "in_cart") as! CVarArg)
        let stritem_id = String(format: "%@", dict.value(forKey: "item_id") as! CVarArg)
        let strquote_id = String(format: "%@", dict.value(forKey: "quote_id") as! CVarArg)
        print("strproductid %@ + strin_cart %@",strproductid,strin_cart)
        
        var intqty = (strin_cart as NSString).intValue
        print("intqty",intqty)
        if intqty >= 0{
            intqty = intqty + 1
        }
        else{
            //product qunatity item 0 - Add to cart button will show
        }
        print("intqty",intqty as Any)

        self.postCartListUpdateQTYItemAPIMethod(stritemid: stritem_id, strquoteid: strquote_id, strproductQty: String(format: "%d", intqty))
    }
    
    //MARK: - press Add To Wishlist Method
    @objc func pressAddToWishlist(sender:UIButton)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dict = arrMCategorywiseProductlist.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        
        let stris_addedwishlist = String(format: "%@", dict!.value(forKey: "is_addedwishlist") as? String ?? "")
        print("stris_addedwishlist",stris_addedwishlist)
        if stris_addedwishlist != "True"
        {
            /*let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language149"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.postAddtoWishlistAPIMethod(strproductid: strproductid)
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)*/
            self.postAddtoWishlistAPIMethod(strproductid: strproductid)
        }
        else{
            /*let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language152"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.postRemoveFromWishlistAPIMethod(strSelectedProductID: strproductid)
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)*/
            
            self.postRemoveFromWishlistAPIMethod(strSelectedProductID: strproductid)
        }
    }
    
    //MARK: - press Add Once Method
    @objc func pressaddonce(sender:UIButton)
    {
        //FIXMELOGINCHECK
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        if strbearertoken == ""{
            
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language510"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language511"), style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                let obj = loginclass(nibName: "loginclass", bundle: nil)
                obj.strislogin = "100"
                self.navigationController?.pushViewController(obj, animated: true)
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        else{
            let dict = arrMCategorywiseProductlist.object(at: sender.tag)as? NSDictionary
            let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            self.postAddToCartApiMethod(strqty: "1", strproductid: strproductid)
        }
        
    }
    


    //MARK: - get Product Listing From Category ID API method
    func getProductListingFromCategoryIDAPIMethod(strkeywrod:String)
    {
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        
        if self.arrMCategorywiseProductlist.count > 0{
            self.arrMCategorywiseProductlist.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let strkeywrodfinal = strkeywrod.replacingOccurrences(of: " ", with: "%20")
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?categoryId=%@&product_name=%@&subCategoryId=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod10,"",strkeywrodfinal,"",strLangCode)
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
                        
                        
                        
                        if strsuccess == true
                        {
                            if self.arrMCategorywiseProductlist.count > 0{
                                self.arrMCategorywiseProductlist.removeAllObjects()
                            }
                            
                            let arrmproducts = json.value(forKey: "product") as? NSArray ?? []
                            self.arrMCategorywiseProductlist = NSMutableArray(array: arrmproducts)
                            //print("arrMCategorywiseProductlist --->",self.arrMCategorywiseProductlist)
                            
                            if self.arrMCategorywiseProductlist.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language150")
                            }
                            self.colproductlist.reloadData()
                            
                            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                            if strbearertoken != ""{
                                self.getOrderOnceCartCountAPIMethod()
                            }
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
                        
                        if strsuccess == true
                        {
                            /*let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language269") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))*/

                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: self.txtsearchbar.text!)
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
                        
                        if strsuccess == true
                        {
                            var strupdatedmessg = ""
                            if strmessage.contains("Item added successfully")
                            {
                                //strupdatedmessg = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language386"))
                            }
                            else
                            {
                                strupdatedmessg = strmessage
                                let uiAlert = UIAlertController(title: "", message: strupdatedmessg , preferredStyle: UIAlertController.Style.alert)
                                self.present(uiAlert, animated: true, completion: nil)
                                uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                    print("Click of default button")
                                }))
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: self.txtsearchbar.text!)
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
                        
                        if strsuccess == true
                        {
                            self.getProductListingFromCategoryIDAPIMethod(strkeywrod: self.txtsearchbar.text!)
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
    
    //MARK: - post Cart List Update QTY Item API Method
    func postCartListUpdateQTYItemAPIMethod(stritemid:String,strquoteid:String,strproductQty:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            //self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["itemId": stritemid,
                          "quoteId": strquoteid,
                          "productQty": strproductQty] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod19)
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
                    
                    self.view.isUserInteractionEnabled = true
                    //self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.isUserInteractionEnabled = true
                        //self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.getProductListingFromCategoryIDAPIMethod(strkeywrod: self.txtsearchbar.text!)
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
                    self.view.isUserInteractionEnabled = true
                    //self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Cart List Remove Item API Method
    func postCartListRemoveItemAPIMethod(stritemid:String,strquoteid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            //self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["itemId": stritemid,
                          "quoteId": strquoteid] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod18)
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
                    
                    //self.view.activityStopAnimating()
                    self.view.isUserInteractionEnabled = true
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        //self.view.activityStopAnimating()
                        self.view.isUserInteractionEnabled = true
                    }
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.getProductListingFromCategoryIDAPIMethod(strkeywrod: self.txtsearchbar.text!)
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
                    //self.view.activityStopAnimating()
                    self.view.isUserInteractionEnabled = true
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
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        /*let parameters = ["productid": strSelectedProductID
         ] as [String : Any]*/
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod29)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            if json["total_quantity"] != nil
                            {
                                print("found!")
                                
                                let strqty = dictemp.value(forKey: "total_quantity")as! CVarArg
                                UserDefaults.standard.set(strqty, forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                
                                let strcount = UserDefaults.standard.value(forKey: "orderoncecartcount")as? Int ?? 0
                                print("strcount",strcount)
                                
                                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                                if (strLangCode == "en")
                                {
                                    (myAppDelegate.tabBarController.tabBar.items![3] ).badgeValue = String(format: "%d", strcount)
                                    
                                }else{
                                    (myAppDelegate.tabBarController.tabBar.items![1] ).badgeValue = String(format: "%d", strcount)
                                }
                                
                                let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                                print("strbearertoken",strbearertoken)
                                if strbearertoken != ""{
                                    self.setupRightBarCartBagDesignMethod(intcountOrder: strcount)
                                }
                                
                            }
                            else{
                                print("Not found!")//
                                
                                UserDefaults.standard.set("0", forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                
                                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                                if (strLangCode == "en")
                                {
                                    (myAppDelegate.tabBarController.tabBar.items![3] ).badgeValue = ""
                                }else{
                                    (myAppDelegate.tabBarController.tabBar.items![1] ).badgeValue = ""
                                }
                                
                                let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                                print("strbearertoken",strbearertoken)
                                if strbearertoken != ""{
                                    self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
                                }
                                 
                                
                            }
                            
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
