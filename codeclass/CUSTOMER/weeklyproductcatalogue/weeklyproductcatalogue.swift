//
//  weeklyproductcatalogue.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 19/09/22.
//

import UIKit
import CoreData

class weeklyproductcatalogue: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var vieworderon: UIView!
    @IBOutlet weak var lblorderon: UILabel!
    @IBOutlet weak var btnReviewOrder: UIButton!
    @IBOutlet weak var colorderon: UICollectionView!
    var reuseIdentifier2 = "cellcolordernow"
    var arrmorderon = NSMutableArray()
    
    @IBOutlet weak var viewsearchbox: UIView!
    @IBOutlet weak var viewsearchbarbg: UIView!
    @IBOutlet weak var txtsearchbox: UITextField!
    @IBOutlet weak var btnsortby: UIButton!
    
    @IBOutlet weak var viewcategorycarousal: UIView!
    @IBOutlet weak var colcategory: UICollectionView!
    var reuseIdentifier3 = "colcellcat"
    var arrmcatlist = NSMutableArray()
    
    //sub catrgoey carousal
    @IBOutlet weak var viewsubcategorycarousal: UIView!
    @IBOutlet weak var colsubcategory: UICollectionView!
    var reuseIdentifier4 = "colcellcat"
    
    var strSelectedCat = ""
    var strSelectedSubCat = ""
    
    @IBOutlet weak var colproductlist: UICollectionView!
    var reuseIdentifier1 = "cellcolweeklyproduct"
    var msg = ""
    @IBOutlet weak var btnfilter: UIButton!
    var arrmproductlist = NSMutableArray()
    
    
    var strpageidentifier = ""
    var strselecteddateindex = ""
    var strselecteddateindexdate = ""
    var strselecteddateindexday = ""
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
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
        self.navigationController?.navigationBar.isHidden = false

        fetchDataWeeklymodelTable()
        postAllCategoryHomepageAPImethod()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language78")
        
        self.viewsearchbarbg.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        self.viewsearchbarbg.layer.borderWidth = 1.0
        self.viewsearchbarbg.layer.cornerRadius = 18.0
        self.viewsearchbarbg.layer.masksToBounds = true
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        createOrderonGallery()
        
        createCategoryGallery()
        
        createProductGallery()
        
    }
    
    //MARK: - press Cartbag method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Revieworder Method
    @IBAction func pressReviewOrder(_ sender: Any){
        let ctrl = subscriptionorderreview(nibName: "subscriptionorderreview", bundle: nil)
        ctrl.strpageidentifier = "200"
        ctrl.strpageidentifierplanname = "Weekly"
        self.navigationController?.pushViewController(ctrl, animated: true)
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
            let dict = self.arrmcatlist.object(at: Int(strSelectedCat)!) as! NSDictionary
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            self.getProductListingAPIMethod(strselectedcategoryid: strid)
        }
        
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    
    //MARK: - create order on date list gallery method
    func createOrderonGallery()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        lblorderon.text = myAppDelegate.changeLanguage(key: "msg_language45")
        lblorderon.isHidden = true
        btnReviewOrder.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language381")), for: .normal)
        
        txtsearchbox.placeholder = myAppDelegate.changeLanguage(key: "msg_language80")
        
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout1.itemSize = CGSize(width: colorderon.frame.size.width / 3 - 10, height: 100)
        layout1.minimumInteritemSpacing = 10
        layout1.minimumLineSpacing = 10
        colorderon.collectionViewLayout = layout1
        colorderon.register(UINib(nibName: "cellcolordernow", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
        colorderon.showsHorizontalScrollIndicator = false
        colorderon.showsVerticalScrollIndicator=false
        colorderon.backgroundColor = .clear
    }
    
    
    //MARK: - create select category gallery method
    func createCategoryGallery()
    {
        var floatDevider = 0.0
        var floatDevider1 = 0.0
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
            floatDevider = 2.8
            floatDevider1 = 1.8
        }
        else
        {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            floatDevider = 3.5
            floatDevider1 = 2.5
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colcategory.frame.size.width / floatDevider, height: 60)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colcategory.collectionViewLayout = layout
        colcategory.register(UINib(nibName: "colcellcat", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier3)
        colcategory.showsHorizontalScrollIndicator = false
        colcategory.showsVerticalScrollIndicator=false
        colcategory.backgroundColor = .clear
        
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout1.itemSize = CGSize(width: colsubcategory.frame.size.width / floatDevider1, height: 44)
        layout1.minimumInteritemSpacing = 5
        layout1.minimumLineSpacing = 5
        colsubcategory.collectionViewLayout = layout1
        colsubcategory.register(UINib(nibName: "colcellcat", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier4)
        colsubcategory.showsHorizontalScrollIndicator = false
        colsubcategory.showsVerticalScrollIndicator=false
        colsubcategory.backgroundColor = .clear
    }
    
    //MARK: - create product gallery method
    func createProductGallery()
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
            floatDevider = 3.0
        }
        else
        {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            floatDevider = 2.0
        }
        
        colproductlist.backgroundColor = .clear
        let layout = colproductlist.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/floatDevider - 15, height: 356)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colproductlist.register(UINib(nibName: "cellcolweeklyproduct", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colproductlist.showsVerticalScrollIndicator = false
        colproductlist.showsHorizontalScrollIndicator = false
    }
    
    
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if collectionView == colorderon
        {
            return self.arrmorderon.count
        }
        else  if collectionView == colcategory
        {
            return self.arrmcatlist.count
        }
        else if collectionView ==  colsubcategory
        {
            print("strSelectedCat",strSelectedCat)
            if strSelectedCat == ""{
                return 0
            }
            
            let intselectedcatIndex = Int(strSelectedCat)
            let dict = self.arrmcatlist.object(at: intselectedcatIndex!) as! NSDictionary
            let arrm1 = dict.value(forKey: "children") as? NSArray ?? []
            var arrm2 = NSMutableArray()
            arrm2 = NSMutableArray(array: arrm1)
            print("arrm2",arrm2)
            
            return arrm2.count
        }
        
        if arrmproductlist.count == 0 {
            self.colproductlist.setEmptyMessage(msg)
        } else {
            self.colproductlist.restore()
        }
        return arrmproductlist.count
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
            
            if self.strselecteddateindex == String(format: "%d", indexPath.row)
            {
                //Selected DATE DAY from TOP GALLERY
                cellA.viewcell.backgroundColor = .white
                cellA.viewcell.layer.cornerRadius = 4.0
                cellA.viewcell.layer.borderWidth = 4.0
                cellA.viewcell.layer.borderColor = UIColor(named: "yellowboxorder")!.cgColor
                cellA.viewcell.layer.masksToBounds = true
            }
            else{
                cellA.viewcell.backgroundColor = .white
                cellA.viewcell.layer.cornerRadius = 4.0
                cellA.viewcell.layer.borderWidth = 1.0
                cellA.viewcell.layer.borderColor = UIColor.clear.cgColor
                cellA.viewcell.layer.masksToBounds = true
            }
            
            
            let dict = self.arrmorderon.object(at: indexPath.row)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            var strisrenew = String(format: "%@", dict?.value(forKey: "isrenew")as? String ?? "")
            var strsubscriptionid = String(format: "%@", dict?.value(forKey: "subscriptionid")as? String ?? "")
            
            cellA.lbldate.text = strdate
            cellA.lblday.text = strday
            
            
            var flttotalprice = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From Dailyproduct TABLE As per ROW DATE -------------//
            let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
            let manageContent2 = appDelegate2.persistentContainer.viewContext
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData2.predicate = NSPredicate(format: "date = %@", strdate)
            do {
                let result2 = try manageContent2.fetch(fetchData2)
                print("result",result2)
                
                if result2.count > 0{
                    
                    for data2 in result2 as! [NSManagedObject]{
                        
                        // fetch
                        do {
                            
                            let qtyonce = data2.value(forKeyPath: "qtyonce") ?? ""
                            let qtyall = data2.value(forKeyPath: "qtyall") ?? ""
                            let productprice = data2.value(forKeyPath: "productprice") ?? ""
                            
                            var intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                            var intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                            var intproductprice = Float(String(format: "%@", productprice as! CVarArg))
                            
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + intqtyall!
                            var fltsubtotalprice = Float(Float(intproductprice!) * Float(inttotalqty))
                            print("fltsubtotalprice",fltsubtotalprice as Any)
                            
                            flttotalprice = flttotalprice + Double(fltsubtotalprice)
                            
                            try manageContent2.save()
                            print("fetch successfull")
                            
                        } catch let error as NSError {
                            print("Could not fetch. \(error), \(error.userInfo)")
                        }
                        //end update
                    }
                }
            }catch {
                print("err")
            }
            print("flttotalprice",flttotalprice as Any)
            
            
            if flttotalprice == 0.00{
                cellA.lbltotalprice.textColor = UIColor(named: "orangecolor")!
                cellA.lbltotalprice.text = "+ Add More"
            }
            else{
                cellA.lbltotalprice.textColor = UIColor.darkGray
                cellA.lbltotalprice.text = String(format: "AED %0.2f", flttotalprice)
            }
            
            //STATUS CHECKING WITH TOTAL PRICE FOR THAT DATE
            if flttotalprice == 0.00{
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
            else if flttotalprice >= Constants.conn.CutOffSubscriptionOrderTotal //15.00
            {
                
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
            else if flttotalprice < Constants.conn.CutOffSubscriptionOrderTotal //15.00
            {
                
                //RED
                
                cellA.lblseparator.backgroundColor = .white
                
                cellA.lbldate.backgroundColor = .clear
                cellA.lblday.backgroundColor = .clear
                cellA.lbltotalprice.backgroundColor = .clear
                
                cellA.lbldate.textColor = .black
                cellA.lblday.textColor = .black
                cellA.lbltotalprice.textColor = .black
                
                cellA.viewcell.backgroundColor = UIColor(named: "plate4")!
            }
            
            cellA.btnedit.tag = indexPath.row
            cellA.btnedit.addTarget(self, action: #selector(presseditOrderOn), for: .touchUpInside)
            
            return cellA
        }
        else if collectionView == self.colcategory
        {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! colcellcat
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
            else{
                cellA.viewcell.backgroundColor = .white
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
        else if collectionView ==  colsubcategory
        {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! colcellcat
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            let intselectedcatIndex = Int(strSelectedCat)
            print("intselectedcatIndex",intselectedcatIndex)
            let dict = self.arrmcatlist.object(at: intselectedcatIndex!) as! NSDictionary
            let arrm1 = dict.value(forKey: "children") as? NSArray ?? []
            var arrm2 = NSMutableArray()
            arrm2 = NSMutableArray(array: arrm1)
            print("arrm2",arrm2)
            
            let dict1 = arrm2.object(at: indexPath.row) as! NSDictionary
            
            let strtext = String(format: "%@", dict1.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict1.value(forKey: "id") as! CVarArg)
            //let strcategoryImage = String(format: "%@", dict.value(forKey: "categoryImage") as? String ?? "")
            //let strFinalurl = strcategoryImage.replacingOccurrences(of: " ", with: "%20")
            //print("strFinalurl",strFinalurl)
            
            cellA.viewcell.layer.cornerRadius = 6.0
            cellA.viewcell.layer.masksToBounds = true
            
            cellA.viewcell.backgroundColor = UIColor(named: "greenlighter")!
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
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! cellcolweeklyproduct
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 8.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let dict = arrmproductlist.object(at: indexPath.row)as? NSDictionary
        
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
        }else{
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
        }
        else{
            
            let stris_addedwishlist = String(format: "%@", dict!.value(forKey: "is_addedwishlist") as? String ?? "")
            
            print("stris_addedwishlist",stris_addedwishlist)
            if stris_addedwishlist == "True"
            {
                cellA.btnfav.setImage(UIImage(named: "favselected"), for: .normal)
            }
            
            cellA.btnfav.isHidden = true
        }
        
        cellA.viewcell.layer.cornerRadius = 8.0
        cellA.viewcell.layer.masksToBounds = true
        
        cellA.btnaddonce.layer.cornerRadius = 14.0
        cellA.btnaddonce.layer.masksToBounds = true
        
        cellA.btnaddtoall.setTitleColor(UIColor(named: "orangecolor")!, for: .normal)
        cellA.btnaddtoall.layer.cornerRadius = 14.0
        cellA.btnaddtoall.layer.borderWidth = 1.0
        cellA.btnaddtoall.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        cellA.btnaddtoall.layer.masksToBounds = true
        
        //CELL ADD ONCE & ADD TO ALL
        cellA.btnaddonce.tag = indexPath.row
        cellA.btnaddtoall.tag = indexPath.row
        cellA.btnaddonce.addTarget(self, action: #selector(pressaddonce), for: .touchUpInside)
        cellA.btnaddtoall.addTarget(self, action: #selector(pressaddtoall), for: .touchUpInside)
        
        
        //CELL PLUS MINUS
        cellA.viewplusminus.layer.cornerRadius = 14.0
        cellA.viewplusminus.layer.borderWidth = 1.0
        cellA.viewplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cellA.viewplusminus.layer.masksToBounds = true
        
        cellA.txtplusminus.layer.cornerRadius = 1.0
        cellA.txtplusminus.layer.borderWidth = 1.0
        cellA.txtplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cellA.txtplusminus.layer.masksToBounds = true
        
        cellA.btnplus.tag = indexPath.row
        cellA.btnminus.tag = indexPath.row
        cellA.btnplus.addTarget(self, action: #selector(pressplus), for: .touchUpInside)
        cellA.btnminus.addTarget(self, action: #selector(pressminus), for: .touchUpInside)
        
        //CELL PLUS MINUS ALL
        cellA.viewplusminusATA.layer.cornerRadius = 14.0
        cellA.viewplusminusATA.layer.borderWidth = 1.0
        cellA.viewplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        cellA.viewplusminusATA.layer.masksToBounds = true
        
        cellA.txtplusminusATA.layer.cornerRadius = 1.0
        cellA.txtplusminusATA.layer.borderWidth = 1.0
        cellA.txtplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        cellA.txtplusminusATA.layer.masksToBounds = true
        
        cellA.btnplusATA.tag = indexPath.row
        cellA.btnminusATA.tag = indexPath.row
        cellA.btnplusATA.addTarget(self, action: #selector(pressplusATA), for: .touchUpInside)
        cellA.btnminusATA.addTarget(self, action: #selector(pressminusATA), for: .touchUpInside)
        
        
        cellA.btnaddonce.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language71")), for: .normal)
        cellA.btnaddtoall.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language70")), for: .normal)
        cellA.lbladdonce.text = myAppDelegate.changeLanguage(key: "msg_language71")
        cellA.lbladdtoall.text = myAppDelegate.changeLanguage(key: "msg_language70")
        
        //-----Fetch qtyonce && qtyall for each product id from Weeklyproduct Table ----//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
        fetchData.predicate = NSPredicate(format: "date == %@ && productid == %@",self.strselecteddateindexdate,strproductid)
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            
            if result.count > 0
            {
                for data in result as! [NSManagedObject]{
                    
                    let qtyoo = data.value(forKeyPath: "qtyonce") ?? ""
                    let qtyaa = data.value(forKeyPath: "qtyall") ?? ""
                    print("qtyoo",qtyoo)
                    print("qtyaa",qtyaa)
                    
                    if qtyoo as! String != "0"{
                        cellA.btnaddonce.isHidden = true
                        cellA.viewplusminus.isHidden = false
                        cellA.txtplusminus.text = qtyoo as! String
                    }else{
                        cellA.btnaddonce.isHidden = false
                        cellA.viewplusminus.isHidden = true
                    }
                    
                    if qtyaa as! String != "0"{
                        cellA.btnaddtoall.isHidden = true
                        cellA.viewplusminusATA.isHidden = false
                        cellA.txtplusminusATA.text = qtyaa as! String
                    }else{
                        cellA.btnaddtoall.isHidden = false
                        cellA.viewplusminusATA.isHidden = true
                    }
                }
            }
            else{
                cellA.btnaddonce.isHidden = false
                cellA.btnaddtoall.isHidden = false
                cellA.viewplusminus.isHidden = true
                cellA.viewplusminusATA.isHidden = true
            }
        }catch {
            print("err")
        }
        
        //cellA.viewplusminus.isHidden = true
        //cellA.viewplusminusATA.isHidden = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == colorderon
        {
            let dict = self.arrmorderon.object(at: indexPath.row)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            var strisrenew = String(format: "%@", dict?.value(forKey: "isrenew")as? String ?? "")
            var strsubscriptionid = String(format: "%@", dict?.value(forKey: "subscriptionid")as? String ?? "")
            
            self.strselecteddateindex = String(format: "%d", indexPath.row)
            self.strselecteddateindexdate = strdate
            self.strselecteddateindexday = strday
            self.colorderon.reloadData()
            
            self.colproductlist.reloadData()
        }
        else if collectionView == colcategory
        {
            let dict = arrmcatlist.object(at: indexPath.row) as! NSDictionary
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            
            self.strSelectedCat = String(format: "%d", indexPath.row)
            self.colcategory.reloadData()
            
            let arrm1 = dict.value(forKey: "children") as? NSArray ?? []
            if arrm1.count > 0{
                self.viewsubcategorycarousal.isHidden = false
                
                let dict2222 = arrm1.object(at: 0) as! NSDictionary
                let strid2222 = String(format: "%@", dict2222.value(forKey: "id") as! CVarArg)
                self.strSelectedSubCat = String(format: "%@", strid2222)
                self.colsubcategory.reloadData()
            }
            else{
                self.viewsubcategorycarousal.isHidden = true
            }
            
            self.getProductListingAPIMethod(strselectedcategoryid: strid)
        }
        else if collectionView == self.colsubcategory
        {
            let intselectedcatIndex = Int(strSelectedCat)
            let dict = self.arrmcatlist.object(at: intselectedcatIndex!) as! NSDictionary
            let arrm1 = dict.value(forKey: "children") as? NSArray ?? []
            var arrm2 = NSMutableArray()
            arrm2 = NSMutableArray(array: arrm1)
            print("arrm2",arrm2)
            
            let dict1 = arrm2.object(at: indexPath.row) as! NSDictionary
            
            let strtext = String(format: "%@", dict1.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict1.value(forKey: "id") as! CVarArg)
            
            print("strid",strid)
            print("strtext",strtext)
            
            self.strSelectedSubCat = String(format: "%@", strid)
            self.colsubcategory.reloadData()
            
            print("self.strSelectedSubCat",self.strSelectedSubCat)
            
            let dict111 = arrmcatlist.object(at: Int(self.strSelectedCat)!) as! NSDictionary
            let strid111 = String(format: "%@", dict111.value(forKey: "id") as! CVarArg)
            self.getProductListingAPIMethod(strselectedcategoryid: strid111)
        }
        else if collectionView == colproductlist
        {
            let dict = arrmproductlist.object(at: indexPath.row)as? NSDictionary
            let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            
            let strname = String(format: "%@", dict!.value(forKey: "name") as? String ?? "")
            let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
            let strsize = String(format: "%@", dict!.value(forKey: "size") as? String ?? "")
            let arrmedia = dict!.value(forKey: "media")as? NSArray ?? []
            let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")
            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
            
            let ctrl = subscriptionproductdetails(nibName: "subscriptionproductdetails", bundle: nil)
            ctrl.strpageidentifier = "200"
            ctrl.strselecteddateindex = strselecteddateindex
            ctrl.strselecteddateindexdate = strselecteddateindexdate
            ctrl.strselecteddateindexday = strselecteddateindexday
            ctrl.strSelectedProductID = strproductid
            ctrl.strprdnamefromlist = strname
            ctrl.strprdimagefromlist = strFinalurl
            ctrl.strprdsizefromlist = strsize
            ctrl.strprdpricefromlist = strprice
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        
    }
    
    //MARK: - press edit OrderOn method
    @objc func presseditOrderOn(sender:UIButton)
    {
        
    }
    
    //MARK: - press ADDONCE method
    @objc func pressaddonce(sender:UIButton)
    {
        let dict = arrmproductlist.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strname = String(format: "%@", dict!.value(forKey: "name") as? String ?? "")
        let strsku = String(format: "%@", dict!.value(forKey: "sku") as? String ?? "")
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        let strsize = String(format: "%@", dict!.value(forKey: "size") as? String ?? "")
        let strbrand = String(format: "%@", dict!.value(forKey: "brand") as? String ?? "")
        let arrmedia = dict!.value(forKey: "media")as? NSArray ?? []
        let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")
        let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
        fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strproductid,self.strselecteddateindexdate)
        do {
            let result1 = try manageContent1.fetch(fetchData1)
            print("result",result1)
            
            if result1.count > 0
            {
                //AVAILABLE
                
                for data1 in result1 as! [NSManagedObject]{
                    
                    // update
                    do {
                        
                        let qtyonce = data1.value(forKeyPath: "qtyonce") ?? ""
                        var intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                        intqtyonce = intqtyonce! + 1 // ADDONCE + 1 INCREAMENTAL WHEN CLICK ON PLUS ICON
                        
                        let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                        var intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                        
                        if intqtyall != 0.00
                        {
                            //qtyall available only update add once qty
                            
                            data1.setValue(String(format: "%.0f", intqtyonce!), forKey: "qtyonce")
                            
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + intqtyall!
                            
                            var fltsubtotalprice = Float(strprice)! * Float(inttotalqty)
                            print("fltsubtotalprice",fltsubtotalprice as Any)
                            data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                        }
                        else
                        {
                            //qtyall not available add new  add once qty
                            
                            var intsubtotalprice = Float(strprice)! * 1
                            print("intsubtotalprice",intsubtotalprice)
                            
                            //------------------- INSERT INTO Weeklyproduct TABLE ---------------- //
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                            let manageContent = appDelegate.persistentContainer.viewContext
                            let userEntity = NSEntityDescription.entity(forEntityName: "Weeklyproduct", in: manageContent)!
                            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                            users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                            users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                            users.setValue(strproductid, forKeyPath: "productid")
                            users.setValue(strFinalurl, forKeyPath: "productimage")
                            users.setValue(strname, forKeyPath: "productname")
                            users.setValue(strprice, forKeyPath: "productprice")
                            users.setValue(strsize, forKeyPath: "productsize")
                            users.setValue("0", forKeyPath: "qtyall")
                            users.setValue("1", forKeyPath: "qtyonce")
                            users.setValue("1", forKeyPath: "selected")
                            users.setValue(String(format: "%0.2f", intsubtotalprice), forKeyPath: "subtotal")
                            do{
                                try manageContent.save()
                            }catch let error as NSError {
                                print("could not save . \(error), \(error.userInfo)")
                            }
                        }
                        
                        
                        
                        try manageContent1.save()
                        print("update successfull")
                        
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
            }
            else
            {
                //NOT AVAILABLE
                
                var intsubtotalprice = Float(strprice)! * 1
                print("intsubtotalprice",intsubtotalprice)
                
                //------------------- INSERT INTO Weeklyproduct TABLE ---------------- //
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent = appDelegate.persistentContainer.viewContext
                let userEntity = NSEntityDescription.entity(forEntityName: "Weeklyproduct", in: manageContent)!
                let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                users.setValue(strproductid, forKeyPath: "productid")
                users.setValue(strFinalurl, forKeyPath: "productimage")
                users.setValue(strname, forKeyPath: "productname")
                users.setValue(strprice, forKeyPath: "productprice")
                users.setValue(strsize, forKeyPath: "productsize")
                users.setValue("0", forKeyPath: "qtyall")
                users.setValue("1", forKeyPath: "qtyonce")
                users.setValue("1", forKeyPath: "selected")
                users.setValue(String(format: "%0.2f", intsubtotalprice), forKeyPath: "subtotal")
                do{
                    try manageContent.save()
                }catch let error as NSError {
                    print("could not save . \(error), \(error.userInfo)")
                }
            }
        }catch {
            print("err")
        }
        
        self.fetchDataWeeklymodelTable()
        self.colproductlist.reloadData()
        
    }
    
    //MARK: - press ADDTOALL method
    @objc func pressaddtoall(sender:UIButton)
    {
        let dict = arrmproductlist.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strname = String(format: "%@", dict!.value(forKey: "name") as? String ?? "")
        let strsku = String(format: "%@", dict!.value(forKey: "sku") as? String ?? "")
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        let strsize = String(format: "%@", dict!.value(forKey: "size") as? String ?? "")
        let strbrand = String(format: "%@", dict!.value(forKey: "brand") as? String ?? "")
        let arrmedia = dict!.value(forKey: "media")as? NSArray ?? []
        let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")
        let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        var intsubtotalprice = Float(strprice)! * 1
        print("intsubtotalprice",intsubtotalprice)
        
        for x in 0 ..< arrmorderon.count
        {
            let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICI DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strproductid,strdate)
            do {
                let result1 = try manageContent1.fetch(fetchData1)
                print("result",result1)
                
                if result1.count > 0
                {
                    //AVAILABLE
                    
                    for data1 in result1 as! [NSManagedObject]{
                        
                        // update
                        do {
                            
                            let qtyonce = data1.value(forKeyPath: "qtyonce") ?? ""
                            let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                            
                            var intqtyonce = Int(String(format: "%@", qtyonce as! CVarArg))
                            var intqtyall = Int(String(format: "%@", qtyall as! CVarArg))
                            var inttotalqty = Int()
                            inttotalqty = intqtyonce! + (intqtyall! + 1)
                            
                            data1.setValue(String(format: "%d", (intqtyall! + 1)), forKey: "qtyall")
                            
                            var fltsubtotalprice = Float(strprice)! * Float(inttotalqty)
                            print("fltsubtotalprice",fltsubtotalprice as Any)
                            
                            data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                            
                            try manageContent1.save()
                            print("update successfull")
                            
                        } catch let error as NSError {
                            print("Could not Update. \(error), \(error.userInfo)")
                        }
                        //end update
                    }
                }
                else{
                    //NOT AVAILABLE
                    
                    //------------------- INSERT INTO Weeklyproduct TABLE ---------------- //
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent = appDelegate.persistentContainer.viewContext
                    let userEntity = NSEntityDescription.entity(forEntityName: "Weeklyproduct", in: manageContent)!
                    let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                    users.setValue(strdate, forKeyPath: "date")
                    users.setValue(strday, forKeyPath: "day")
                    users.setValue(strproductid, forKeyPath: "productid")
                    users.setValue(strFinalurl, forKeyPath: "productimage")
                    users.setValue(strname, forKeyPath: "productname")
                    users.setValue(strprice, forKeyPath: "productprice")
                    users.setValue(strsize, forKeyPath: "productsize")
                    users.setValue("1", forKeyPath: "qtyall")
                    users.setValue("0", forKeyPath: "qtyonce")
                    users.setValue("1", forKeyPath: "selected")
                    users.setValue(String(format: "%0.2f", intsubtotalprice), forKeyPath: "subtotal")
                    do{
                        try manageContent.save()
                    }catch let error as NSError {
                        print("could not save . \(error), \(error.userInfo)")
                    }
                    
                }
            }catch {
                print("err")
            }
            
        }
        
        self.fetchDataWeeklymodelTable()
        self.colproductlist.reloadData()
    }
    
    //MARK: - press ADDONCE PLUS && MINUS method
    @objc func pressplus(sender:UIButton)
    {
        let dict = arrmproductlist.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
        fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strproductid,self.strselecteddateindexdate)
        do {
            let result1 = try manageContent1.fetch(fetchData1)
            print("result",result1)
            
            if result1.count > 0
            {
                //AVAILABLE
                
                for data1 in result1 as! [NSManagedObject]{
                    
                    // update
                    do {
                        
                        let qtyonce = data1.value(forKeyPath: "qtyonce") ?? ""
                        var intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                        intqtyonce = intqtyonce! + 1 // ADDONCE + 1 INCREAMENTAL WHEN CLICK ON PLUS ICON
                        
                        let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                        var intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                        
                        var inttotalqty = Float()
                        inttotalqty = intqtyonce! + intqtyall!
                        
                        var fltsubtotalprice = Float(strprice)! * Float(inttotalqty)
                        print("fltsubtotalprice",fltsubtotalprice as Any)
                        
                        data1.setValue(String(format: "%.0f", intqtyonce!), forKey: "qtyonce")
                        data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                        
                        try manageContent1.save()
                        print("update successfull")
                        
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
            }
            else{
                //NOT AVAILABLE
            }
        }catch {
            print("err")
        }
        
        self.fetchDataWeeklymodelTable()
        self.colproductlist.reloadData()
    }
    @objc func pressminus(sender:UIButton)
    {
        let dict = arrmproductlist.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
        fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strproductid,self.strselecteddateindexdate)
        do {
            let result1 = try manageContent1.fetch(fetchData1)
            print("result",result1)
            
            if result1.count > 0
            {
                //AVAILABLE
                
                for data1 in result1 as! [NSManagedObject]{
                    
                    // update
                    do {
                        
                        let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                        var intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                        
                        let qtyonce = data1.value(forKeyPath: "qtyonce") ?? ""
                        var intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                        intqtyonce = intqtyonce! - 1 // ADDONCE - 1 DECREAMENTAL WHEN CLICK ON PLUS ICON
                        
                        if intqtyonce! <= 0
                        {
                            if intqtyall! <= 0{
                                //Will remove that product from dailyproduct TABLE
                                manageContent1.delete(data1 as! NSManagedObject)
                            }else{
                                //only qty once set to 0 for that product id on that date
                                data1.setValue("0", forKey: "qtyonce")
                            }
                        }
                        else
                        {
                            data1.setValue(String(format: "%.0f", intqtyonce!), forKey: "qtyonce")
                            
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + intqtyall!
                            
                            let fltsubtotalprice = Float(strprice)! * Float(inttotalqty)
                            print("fltsubtotalprice",fltsubtotalprice as Any)

                            data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                        }
                        try manageContent1.save()
                        print("update successfull")
                        
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
            }
            else{
                //NOT AVAILABLE
            }
        }catch {
            print("err")
        }
        
        self.fetchDataWeeklymodelTable()
        self.colproductlist.reloadData()
    }
    
    //MARK: - press ADDTOALL PLUS && MINUS method
    @objc func pressplusATA(sender:UIButton)
    {
        let dict = arrmproductlist.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        for x in 0 ..< arrmorderon.count
        {
            let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strproductid,strdate)
            do {
                let result1 = try manageContent1.fetch(fetchData1)
                print("result",result1)
                
                if result1.count > 0
                {
                    //AVAILABLE
                    
                    for data1 in result1 as! [NSManagedObject]{
                        
                        // update
                        do {
                            
                            let qtyonce = data1.value(forKeyPath: "qtyonce") ?? ""
                            let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                            
                            let intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                            let intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + (intqtyall! + 1)
                            
                            data1.setValue(String(format: "%0.0f", (intqtyall! + 1)), forKey: "qtyall")
                            
                            let fltsubtotalprice = Float(strprice)! * Float(inttotalqty)
                            print("fltsubtotalprice",fltsubtotalprice as Any)
                            
                            data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                            
                            try manageContent1.save()
                            print("update successfull")
                            
                        } catch let error as NSError {
                            print("Could not Update. \(error), \(error.userInfo)")
                        }
                        //end update
                    }
                }
                else{
                    //NOT AVAILABLE
                }
            }catch {
                print("err")
            }
        }
        
        self.fetchDataWeeklymodelTable()
        self.colproductlist.reloadData()
    }
    @objc func pressminusATA(sender:UIButton)
    {
        let dict = arrmproductlist.object(at: sender.tag)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        for x in 0 ..< arrmorderon.count
        {
            let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strproductid,strdate)
            do {
                let result1 = try manageContent1.fetch(fetchData1)
                print("result",result1)
                
                if result1.count > 0
                {
                    //AVAILABLE
                    
                    for data1 in result1 as! [NSManagedObject]{
                        
                        // update
                        do {
                            
                            let qtyonce = data1.value(forKeyPath: "qtyonce") ?? ""
                            let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                            
                            let intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                            let intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                            
                            var updatedqtyall = intqtyall! - 1
                            
                            if updatedqtyall <= 0
                            {
                                if intqtyonce! <= 0{
                                    //Will remove that product from dailyproduct TABLE
                                    manageContent1.delete(data1 as! NSManagedObject)
                                }else{
                                    //only qty once set to 0 for that product id on that date
                                    data1.setValue("0", forKey: "qtyall")
                                }
                            }
                            else
                            {
                                data1.setValue(String(format: "%.0f", updatedqtyall), forKey: "qtyall")
                                
                                var inttotalqty = Float()
                                inttotalqty = intqtyonce! + updatedqtyall
                                
                                let fltsubtotalprice = Float(strprice)! * Float(inttotalqty)
                                print("fltsubtotalprice",fltsubtotalprice as Any)
                                
                                data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                            }
                            try manageContent1.save()
                            print("update successfull")
                            
                        } catch let error as NSError {
                            print("Could not Update. \(error), \(error.userInfo)")
                        }
                        //end update
                    }
                }
                else{
                    //NOT AVAILABLE
                }
            }catch {
                print("err")
            }
        }
        
        self.fetchDataWeeklymodelTable()
        self.colproductlist.reloadData()
    }
    
    //MARK: - post All Category Home Page method
    func postAllCategoryHomepageAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        //let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        //print("strbearertoken",strbearertoken)
        
        //$pageFromId = 1 (all), $pageFromId = 2 (main + offer + newarrival), $pageFromId = 3 (main)
        
        let parameters = ["categoryCount": "none",
                          "categoryImage": "all",
                          "categoryName": "none",
                          "categoryId": "none","pageFromId": "3","language": ""] as [String : Any]

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
                            let arrm1 = dict.value(forKey: "children") as? NSArray ?? []
                            print("arrm1",arrm1)
                            if arrm1.count > 0{
                                let dict1 = arrm1.object(at: 0) as! NSDictionary
                                let strid1 = String(format: "%@", dict1.value(forKey: "id") as! CVarArg)
                                self.strSelectedSubCat = String(format: "%@", strid1)
                                self.colsubcategory.reloadData()
                            }
                            
                            self.getProductListingAPIMethod(strselectedcategoryid: strid)
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
    
    //MARK: - get Product Listing API method
    func getProductListingAPIMethod(strselectedcategoryid:String)
    {
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
        
        print("strselectedcategoryid",strselectedcategoryid)
        strsearchkeyword = strsearchkeyword.replacingOccurrences(of: " ", with: "%20")
        print("strsearchkeyword",strsearchkeyword)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?categoryId=%@&product_name=%@&subCategoryId=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod10,strselectedcategoryid,strsearchkeyword,strSelectedSubCat,strLangCode)
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
                            if self.arrmproductlist.count > 0{
                                self.arrmproductlist.removeAllObjects()
                            }
                            let arrmproducts = json.value(forKey: "product") as? NSArray ?? []
                            self.arrmproductlist = NSMutableArray(array: arrmproducts)
                            print("arrMproducts --->",self.arrmproductlist)
                            
                            if self.arrmproductlist.count == 0{
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

    //MARK: - Fetch Weeklymodel data Weekly exist or not
    func fetchDataWeeklymodelTable()
    {
        if self.arrmorderon.count > 0 {
            self.arrmorderon.removeAllObjects()
        }
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && selected == %@", strcustomerid,"2","1")
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    dictemp.setValue(data.value(forKeyPath: "isrenew") ?? "", forKey: "isrenew")
                    dictemp.setValue(data.value(forKeyPath: "selected") ?? "", forKey: "selected")
                    dictemp.setValue(data.value(forKeyPath: "subscriptionid") ?? "", forKey: "subscriptionid")
                    dictemp.setValue(data.value(forKeyPath: "userid") ?? "", forKey: "userid")
                    
                    self.arrmorderon.add(dictemp)
                    
                }
            }
        }catch {
            print("err")
        }
        
        let dict = self.arrmorderon.object(at: 0)as? NSMutableDictionary
        let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
        self.strselecteddateindex = String(format: "%d", 0)
        self.strselecteddateindexdate = strdate
        
        self.colorderon.reloadData()
    }
}
