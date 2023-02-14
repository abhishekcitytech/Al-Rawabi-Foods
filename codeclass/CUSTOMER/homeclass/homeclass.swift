//
//  homeclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 16/05/22.
//

import UIKit
import ImageSlideshow
import SDWebImage
import Alamofire

import MapKit
import CoreLocation

import GoogleMaps
import GooglePlaces
import GoogleMapsCore
import GoogleMapsUtils

import Nominatim

class homeclass: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,ImageSlideshowDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var viewfloatcart: UIView!
    @IBOutlet weak var imgvfloatcart: UIImageView!
    @IBOutlet weak var lblfloatcartcount: UILabel!
    @IBOutlet weak var btnfloatcart: UIButton!
    
    
    
    
    @IBOutlet weak var viewsearchbar: UIView!
    @IBOutlet weak var viewsearchbarbg: UIView!
    @IBOutlet weak var viewsearchbar1: UIView!
    @IBOutlet weak var imgvsearchbar: UIImageView!
    @IBOutlet weak var txtsearchbar: UITextField!
    @IBOutlet weak var btnsearchbar: UIButton!
    
    
    @IBOutlet weak var viewone: UIView!
    @IBOutlet weak var viewbanner: ImageSlideshow!
    
    @IBOutlet weak var viewtwo: UIView!
    @IBOutlet weak var colcategory: UICollectionView!
    var reuseIdentifier1 = "colcellcategory"
    
    @IBOutlet weak var viewthree: UIView!
    @IBOutlet weak var lbltopdeals: UILabel!
    @IBOutlet weak var btnviewalltopdeals: UIButton!
    
    @IBOutlet weak var coltopdeals: UICollectionView!
    var reuseIdentifier2 = "colcelltopdeals"
    
    @IBOutlet weak var viewfour: UIView!
    @IBOutlet weak var viewpromobox1: UIView!
    @IBOutlet weak var viewpromobox2: UIView!
    @IBOutlet weak var viewpromobox3: UIView!
    @IBOutlet weak var imgvpromobox1: UIImageView!
    @IBOutlet weak var imgvpromobox2: UIImageView!
    @IBOutlet weak var imgvpromobox3: UIImageView!
    
    
    
    //MARK: - POPUP SUBSCRIPTION BUY ONCE
    @IBOutlet var viewpopupSubscribe: UIView!
    @IBOutlet weak var imgvlogosubscribe: UIImageView!
    @IBOutlet weak var viewlocationselect: UIView!
    @IBOutlet weak var txtlocationselect: UITextField!
    @IBOutlet weak var btnlocationselect: UIButton!
    @IBOutlet weak var imgvlocationselect: UIImageView!
    @IBOutlet weak var lblchoosesubscriptionplan: UILabel!
    @IBOutlet weak var lblalertmessagelocationchecking: UILabel!
    @IBOutlet weak var btnBuyoncepopup: UIButton!
    
    @IBOutlet var viewpopupSubscribeDaily: UIView!
    @IBOutlet weak var btnpopupSubscribeDaily: UIButton!
    @IBOutlet weak var lbldaily1: UILabel!
    @IBOutlet weak var lbldaily2: UILabel!
    
    @IBOutlet var viewpopupSubscribeWeekly: UIView!
    @IBOutlet weak var btnBpopupSubscribeWeekly: UIButton!
    @IBOutlet weak var lblweekly1: UILabel!
    @IBOutlet weak var lblweekly2: UILabel!
    
    @IBOutlet var viewpopupSubscribeMothly: UIView!
    @IBOutlet weak var btnpopupSubscribeMothly: UIButton!
    @IBOutlet weak var lblmonthly1: UILabel!
    @IBOutlet weak var lblmonthly2: UILabel!
    
    @IBOutlet weak var lblgetyourdelivery: UILabel!
    
    @IBOutlet weak var btncrossSubscribeBuyoncePopup: UIButton!
    @IBOutlet weak var btninfoSubscriptionBuyoncePopup: UIButton!
    
    var viewPopupAddNewExistingBG123 = UIView()
    
    var isBoolDropdown = Bool()
    let cellReuseIdentifier = "cell"
    var tblViewDropdownList: UITableView? = UITableView()
    var arrMGlobalDropdownFeed = NSMutableArray()
    
    
    var arrMbanner = NSMutableArray()
    var arrMcategory = NSMutableArray()
    var arrMtopdeals = NSMutableArray()
    
    var arrMALLLOCATIONS = NSMutableArray()
    
    
    var locationManager = CLLocationManager()
    var strcurrentlat = ""
    var strcurrentlong = ""
    
    
    var arrmPolygonlist = NSMutableArray()
    var arrmpolygonobject = NSMutableArray()
    var boolcheck = false
    
    
    
    var strBottomBANNER1name = ""
    var strBottomBANNER1image = ""
    var strBottomBANNER2name = ""
    var strBottomBANNER2image = ""
    var strBottomBANNER3name = ""
    var strBottomBANNER3image = ""
    
    
    var strPOPUPstreetaddressfrommap = ""
    var strPOPUPstreetaddressfrommapLocation = ""
    var strPOPUPstreetaddressfrommapCity = ""
    var strPOPUPSelectedLATITUDE = ""
    var strPOPUPSelectedLONGITUDE = ""
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let subscribebyoncepopupshown = UserDefaults.standard.integer(forKey: "subscribebyoncepopupshown")
        if subscribebyoncepopupshown == 0
        {
            //POPUP SHOW FIRST TIME
            print("subscribebyoncepopupshown",subscribebyoncepopupshown)
            
            
            self.createSubscribePopup()
        }
        else if subscribebyoncepopupshown == 2
        {
            //POPUP ALREADY CREATED BUT LOCATION EDIT
            print("subscribebyoncepopupshown",subscribebyoncepopupshown)
            
            if strPOPUPSelectedLATITUDE != "" && strPOPUPSelectedLONGITUDE != ""
            {
                print("strPOPUPstreetaddressfrommap",strPOPUPstreetaddressfrommap)
                print("strPOPUPstreetaddressfrommapLocation",strPOPUPstreetaddressfrommapLocation)
                print("strPOPUPstreetaddressfrommapCity",strPOPUPstreetaddressfrommapCity)
                print("strPOPUPSelectedLATITUDE",strPOPUPSelectedLATITUDE)
                print("strPOPUPSelectedLONGITUDE",strPOPUPSelectedLONGITUDE)
                
                self.txtlocationselect.text = self.strPOPUPstreetaddressfrommap
                self.strcurrentlat = self.strPOPUPSelectedLATITUDE
                self.strcurrentlong = self.strPOPUPSelectedLONGITUDE
                
                self.boolcheck = true
                self.alertViewFunction()
            }
            else
            {
                let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language324") , preferredStyle: UIAlertController.Style.alert)
                self.present(uiAlert, animated: true, completion: nil)
                uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                    print("Click of default button")
                }))
            }
        }
        else{
            //POPUP NOT SHOW FIRST TIME
            print("subscribebyoncepopupshown",subscribebyoncepopupshown)
        }
        
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        setupRTLLTR()
        
        self.gethomepagebannermethod()
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillDisappear(_ animated: Bool)
    {
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(true)
    }
    
    // MARK: - viewDidLayoutSubviews Method
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()

    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        setupNavLogo()
        
        self.viewfloatcart.backgroundColor = .clear
        self.lblfloatcartcount.layer.cornerRadius = self.lblfloatcartcount.frame.self.width / 2.0
        self.lblfloatcartcount.layer.masksToBounds = true
        
        self.viewsearchbarbg.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        self.viewsearchbarbg.layer.borderWidth = 1.0
        self.viewsearchbarbg.layer.cornerRadius = 18.0
        self.viewsearchbarbg.layer.masksToBounds = true
        
        let searchicon = UIImage(named: "search")
        let search = UIBarButtonItem(image: searchicon, style: .plain, target: self, action: #selector(pressSearch))
        search.tintColor = UIColor.black
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            //self.navigationItem.leftBarButtonItem = search
        }
        else{
            //self.navigationItem.rightBarButtonItem = search
        }
        
        
        
        print("self.viewoverall.bounds.size.height",self.viewoverall.bounds.size.height)
        self.scrolloverall.contentSize = CGSize(width: self.viewoverall.bounds.size.width, height: self.viewoverall.bounds.size.height)
        self.scrolloverall.showsVerticalScrollIndicator = false
        
        self.btnviewalltopdeals.isHidden = true
        
        //self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
        
        if (strLangCode == "en")
        {
            self.tabBarController!.tabBar.items![3].badgeValue = ""
        }else{
            self.tabBarController!.tabBar.items![1].badgeValue = ""
        }
        
        self.createExploreCategory()
        self.createExploreTopDeals()
        

        //--- Updating --- Location - Latitude - Longitude ----//
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        //self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.activityType = .otherNavigation
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        self.getPolygonApiList()
        //self.addPolygonZoneArea()
        //self.createMultiPolygon()
        
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
        lbltopdeals.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language34"))
        btnviewalltopdeals.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language35")), for: .normal)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            lbltopdeals.textAlignment = .left
            
            self.btnviewalltopdeals.frame = CGRect(x:self.viewthree.frame.size.width - self.btnviewalltopdeals.frame.size.width - 8, y: self.btnviewalltopdeals.frame.origin.y, width: self.btnviewalltopdeals.frame.size.width, height: self.btnviewalltopdeals.frame.size.height)
        }
        else{
            lbltopdeals.textAlignment = .right
            
            self.btnviewalltopdeals.frame = CGRect(x:10, y: self.btnviewalltopdeals.frame.origin.y, width: self.btnviewalltopdeals.frame.size.width, height: self.btnviewalltopdeals.frame.size.height)
            
        }
        
    }
    
    //MARK: - press Search method
    @objc func pressSearch()
    {
        let ctrl = searchproductlist(nibName: "searchproductlist", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    @IBAction func pressSearchbar(_ sender: Any)
    {
        let ctrl = searchproductlist(nibName: "searchproductlist", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    //MARK: - press View All Top Deals Method
    @IBAction func pressviewalltopdeals(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        print("self.arrMcategory",self.arrMcategory)
        var strcatid = ""
        var strcatname = ""
        var arrm1 = NSArray()
        for x in 0 ..< self.arrMcategory.count
        {
            let dictemp = self.arrMcategory.object(at: x)as! NSDictionary
            let strname = String(format: "%@", dictemp.value(forKey: "text")as? String ?? "")
            arrm1 = dictemp.value(forKey: "children") as? NSArray ?? []
            
            if strname.containsIgnoreCase("offers")
            {
                let strid = String(format: "%@", dictemp.value(forKey: "id") as! CVarArg)
                strcatid = strid
                strcatname = strname
            }
        }
        
        if strcatid == "" || strcatname == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language46"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            let ctrl = productcatalogue(nibName: "productcatalogue", bundle: nil)
            ctrl.strpageidentifier = "1001"
            ctrl.strFromCategoryID = strcatid
            ctrl.strFromCategoryNAME = strcatname
            ctrl.arrmsubcatlist = NSMutableArray(array: arrm1)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
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
    
    //MARK: - press Cartbag method
    @objc func presscartbag()
    {
        let ctrl = cartlistorderonce(nibName: "cartlistorderonce", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Bottom Promotion Box Method
    @IBAction func presspromobox1(_ sender: Any)
    {
        print("strBottomBANNER1name",strBottomBANNER1name)
    }
    @IBAction func presspromobox2(_ sender: Any)
    {
        print("strBottomBANNER1name",strBottomBANNER2name)
        
        for x in 0 ..< self.arrMcategory.count
        {
            let dict = self.arrMcategory.object(at: x)as? NSDictionary
            let strtext = String(format: "%@", dict!.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
            let arrm1 = dict!.value(forKey: "children") as? NSArray ?? []
            
            if strtext.containsIgnoreCase("Juice")
            {
                let ctrl = productcatalogue(nibName: "productcatalogue", bundle: nil)
                ctrl.strpageidentifier = "1001"
                ctrl.strFromCategoryID = strid
                ctrl.strFromCategoryNAME = strtext
                ctrl.arrmsubcatlist = NSMutableArray(array: arrm1)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
    }
    @IBAction func presspromobox3(_ sender: Any)
    {
        print("strBottomBANNER1name",strBottomBANNER3name)
        
        let ctrl = newarrivalproduct(nibName: "newarrivalproduct", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    //MARK: - Polygon Zone Area Method
    func addPolygonZoneArea()
    {
        let dict1 = NSMutableDictionary()
        dict1.setValue("JLT Dubai", forKey: "name")
        let arrm1 = NSMutableArray()
        arrm1.add(String(format: "%@", "25.060434, 55.137123"))
        arrm1.add(String(format: "%@", "25.069423, 55.146558"))
        arrm1.add(String(format: "%@", "25.070085, 55.146663"))
        arrm1.add(String(format: "%@", "25.072293, 55.144330"))
        arrm1.add(String(format: "%@", "25.076550, 55.148299"))
        arrm1.add(String(format: "%@", "25.075951, 55.149378"))
        arrm1.add(String(format: "%@", "25.078505, 55.156899"))
        arrm1.add(String(format: "%@", "25.081168, 55.154189"))
        arrm1.add(String(format: "%@", "25.081480, 55.149907"))
        arrm1.add(String(format: "%@", "25.076452, 55.143786"))
        arrm1.add(String(format: "%@", "25.072730, 55.140333"))
        arrm1.add(String(format: "%@", "25.068414, 55.136748"))
        arrm1.add(String(format: "%@", "25.064652, 55.136311"))
        arrm1.add(String(format: "%@", "25.060533, 55.137054"))
        dict1.setValue(arrm1, forKey: "coordinates")
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("Dubai Internet City", forKey: "name")
        let arrm2 = NSMutableArray()
        arrm2.add(String(format: "%@", "25.089044, 55.152976"))
        arrm2.add(String(format: "%@", "25.090310, 55.154730"))
        arrm2.add(String(format: "%@", "25.088804, 55.156203"))
        arrm2.add(String(format: "%@", "25.090896, 55.158728"))
        arrm2.add(String(format: "%@", "25.092057, 55.159706"))
        arrm2.add(String(format: "%@", "25.092333, 55.160226"))
        arrm2.add(String(format: "%@", "25.097117, 55.165989"))
        arrm2.add(String(format: "%@", "25.102277, 55.172210"))
        arrm2.add(String(format: "%@", "25.103539, 55.171471"))
        arrm2.add(String(format: "%@", "25.103927, 55.171719"))
        arrm2.add(String(format: "%@", "25.102512, 55.170457"))
        arrm2.add(String(format: "%@", "25.102154, 55.170484"))
        arrm2.add(String(format: "%@", "25.099925, 55.167756"))
        arrm2.add(String(format: "%@", "25.100210, 55.167142"))
        arrm2.add(String(format: "%@", "25.100752, 55.167032"))
        arrm2.add(String(format: "%@", "25.101764, 55.167378"))
        arrm2.add(String(format: "%@", "25.102691, 55.167174"))
        arrm2.add(String(format: "%@", "25.104602, 55.167332"))
        arrm2.add(String(format: "%@", "25.104209, 55.168576"))
        arrm2.add(String(format: "%@", "25.106007, 55.170437"))
        arrm2.add(String(format: "%@", "25.106809, 55.169573"))
        arrm2.add(String(format: "%@", "25.104688, 55.167153"))
        arrm2.add(String(format: "%@", "25.104874, 55.165944"))
        arrm2.add(String(format: "%@", "25.102765, 55.165609"))
        arrm2.add(String(format: "%@", "25.102505, 55.164689"))
        arrm2.add(String(format: "%@", "25.103144, 55.164247"))
        arrm2.add(String(format: "%@", "25.102267, 55.162742"))
        arrm2.add(String(format: "%@", "25.101575, 55.163578"))
        arrm2.add(String(format: "%@", "25.100586, 55.162966"))
        arrm2.add(String(format: "%@", "25.097416, 55.162147"))
        arrm2.add(String(format: "%@", "25.096885, 55.161819"))
        arrm2.add(String(format: "%@", "25.096255, 55.160881"))
        arrm2.add(String(format: "%@", "25.096000, 55.159060"))
        arrm2.add(String(format: "%@", "25.094896, 55.157238"))
        arrm2.add(String(format: "%@", "25.094284, 55.156551"))
        arrm2.add(String(format: "%@", "25.092515, 55.158430"))
        arrm2.add(String(format: "%@", "25.091927, 55.157633"))
        arrm2.add(String(format: "%@", "25.093538, 55.155932"))
        arrm2.add(String(format: "%@", "25.093316, 55.155518"))
        arrm2.add(String(format: "%@", "25.090705, 55.152697"))
        arrm2.add(String(format: "%@", "25.089887, 55.151953"))
        arrm2.add(String(format: "%@", "25.089429, 55.152449"))
        arrm2.add(String(format: "%@", "25.089024, 55.152970"))
        dict2.setValue(arrm2, forKey: "coordinates")
        
        
        let dict3 = NSMutableDictionary()
        dict3.setValue("Al Khawaneej", forKey: "name")
        let arrm3 = NSMutableArray()
        arrm3.add(String(format: "%@", "25.267297, 55.471900"))
        arrm3.add(String(format: "%@", "25.253270, 55.511848"))
        arrm3.add(String(format: "%@", "25.234973, 55.563339"))
        arrm3.add(String(format: "%@", "25.212336, 55.552654"))
        arrm3.add(String(format: "%@", "25.191936, 55.532475"))
        arrm3.add(String(format: "%@", "25.193568, 55.526613"))
        arrm3.add(String(format: "%@", "25.198362, 55.521766"))
        arrm3.add(String(format: "%@", "25.212336, 55.508689"))
        arrm3.add(String(format: "%@", "25.222844, 55.503526"))
        arrm3.add(String(format: "%@", "25.226087, 55.482496"))
        arrm3.add(String(format: "%@", "25.228755, 55.464619"))
        arrm3.add(String(format: "%@", "25.249593, 55.468673"))
        arrm3.add(String(format: "%@", "25.255094, 55.468673"))
        arrm3.add(String(format: "%@", "25.267283, 55.471931"))
        dict3.setValue(arrm3, forKey: "coordinates")
        
        arrmPolygonlist.add(dict1)
        arrmPolygonlist.add(dict2)
        arrmPolygonlist.add(dict3)
        
        print("arrmPolygonlist",arrmPolygonlist)
    }
    func createMultiPolygon()
    {
        for x in 0 ..< arrmPolygonlist.count
        {
            let dictemp = arrmPolygonlist.object(at: x)as? NSDictionary
            let strname = String(format: "%@", dictemp?.value(forKey: "name")as? String ?? "")
            let strid = String(format: "%@", dictemp?.value(forKey: "id")as! CVarArg)
            let stremirate = String(format: "%@", dictemp?.value(forKey: "emirate")as? String ?? "")
            print("strid %@ strname %@ stremirate %2",strid,strname,stremirate)
            
            let arrm = dictemp?.value(forKey: "coordinates")as? NSArray
            
            var polygon = MKPolygon()
            var coordinateArray: [CLLocationCoordinate2D] = []
            
            for xx in 0 ..< arrm!.count
            {
                let dic1 = arrm!.object(at: xx)as? NSDictionary
                let strlatitude = String(format: "%@", dic1?.value(forKey: "latitude")as! CVarArg)
                let strlongitude = String(format: "%@", dic1?.value(forKey: "longitude")as! CVarArg)
                
                //let strcoordinate = String(format: "%@", arrm?.object(at: xx)as? String ?? "")
                //let items = strcoordinate.components(separatedBy: ", ")
                //let str1 = items[0]
                //let str2 = items[1]
                
                let point = CLLocationCoordinate2DMake(Double(strlatitude)!,Double(strlongitude)!)
                coordinateArray.append(point)
            }
            polygon = MKPolygon(coordinates:&coordinateArray, count:arrm!.count)
            self.arrmpolygonobject.add(polygon)
            
        }
        print("arrmpolygonobject",arrmpolygonobject.count)
    }
    func checkpolygonPointMultiple(lat:Double,long:Double)
    {
        for xx in 0 ..< arrmpolygonobject.count
        {
            let polyobj = arrmpolygonobject.object(at: xx)as? MKPolygon
            let polygonRenderer = MKPolygonRenderer(polygon: polyobj!)
            let mapPoint: MKMapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: lat, longitude: long))
            let polygonViewPoint: CGPoint = polygonRenderer.point(for: mapPoint)
            
            if polygonRenderer.path.contains(polygonViewPoint)
            {
                print("Your location was inside your polygon1.")
                boolcheck = true
            }else{
                print("Your location was outside your polygon1.")
            }
        }
    }
    func alertViewFunction()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //ALERT VIEW CHECKING
        if boolcheck == true{
            
            DispatchQueue.main.async {
                
                /*let alert = UIAlertController(title: "Alert", message: "You are inside our delivery area!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    self.boolcheck = false
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)*/
                
                self.lblalertmessagelocationchecking.backgroundColor = UIColor(named: "lightgreencolor")!
                self.lblalertmessagelocationchecking.text = myAppDelegate.changeLanguage(key: "msg_language262")
                self.lblalertmessagelocationchecking.textColor = .black
                self.lblalertmessagelocationchecking.layer.cornerRadius = 0.0
                self.lblalertmessagelocationchecking.layer.masksToBounds = true
                self.boolcheck = false
                
                self.viewpopupSubscribeDaily.layer.borderWidth = 1.0
                self.viewpopupSubscribeDaily.layer.borderColor = UIColor(named: "greencolor")!.cgColor
                self.viewpopupSubscribeDaily.layer.cornerRadius = 8.0
                self.viewpopupSubscribeDaily.layer.masksToBounds = true
                
                self.viewpopupSubscribeWeekly.layer.borderWidth = 1.0
                self.viewpopupSubscribeWeekly.layer.borderColor = UIColor(named: "greencolor")!.cgColor
                self.viewpopupSubscribeWeekly.layer.cornerRadius = 8.0
                self.viewpopupSubscribeWeekly.layer.masksToBounds = true
                
                self.viewpopupSubscribeMothly.layer.borderWidth = 1.0
                self.viewpopupSubscribeMothly.layer.borderColor = UIColor(named: "greencolor")!.cgColor
                self.viewpopupSubscribeMothly.layer.cornerRadius = 8.0
                self.viewpopupSubscribeMothly.layer.masksToBounds = true
                
                self.btnBuyoncepopup.layer.borderWidth = 1.0
                self.btnBuyoncepopup.layer.borderColor = UIColor(named: "themecolor")!.cgColor
                self.btnBuyoncepopup.layer.cornerRadius = 20.0
                self.btnBuyoncepopup.layer.masksToBounds = true
                
                self.btnpopupSubscribeDaily.isUserInteractionEnabled = true
                self.btnBpopupSubscribeWeekly.isUserInteractionEnabled = true
                self.btnpopupSubscribeMothly.isUserInteractionEnabled = true
                self.btnBuyoncepopup.isUserInteractionEnabled = true
                
            }
        }
        else
        {
            DispatchQueue.main.async {
                
                /*let alert = UIAlertController(title: "Alert", message: "We do not deliver to this area!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    self.boolcheck = false
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)*/
                
                self.lblalertmessagelocationchecking.backgroundColor = UIColor(named: "lightred")!
                self.lblalertmessagelocationchecking.text = myAppDelegate.changeLanguage(key: "msg_language323")
                self.lblalertmessagelocationchecking.textColor = .black
                self.lblalertmessagelocationchecking.layer.cornerRadius = 0.0
                self.lblalertmessagelocationchecking.layer.masksToBounds = true
                self.boolcheck = false
                
                self.viewpopupSubscribeDaily.layer.borderWidth = 1.0
                self.viewpopupSubscribeDaily.layer.borderColor = UIColor(named: "darkmostredcolor")!.cgColor
                self.viewpopupSubscribeDaily.layer.cornerRadius = 8.0
                self.viewpopupSubscribeDaily.layer.masksToBounds = true
                
                self.viewpopupSubscribeWeekly.layer.borderWidth = 1.0
                self.viewpopupSubscribeWeekly.layer.borderColor = UIColor(named: "darkmostredcolor")!.cgColor
                self.viewpopupSubscribeWeekly.layer.cornerRadius = 8.0
                self.viewpopupSubscribeWeekly.layer.masksToBounds = true
                
                self.viewpopupSubscribeMothly.layer.borderWidth = 1.0
                self.viewpopupSubscribeMothly.layer.borderColor = UIColor(named: "darkmostredcolor")!.cgColor
                self.viewpopupSubscribeMothly.layer.cornerRadius = 8.0
                self.viewpopupSubscribeMothly.layer.masksToBounds = true
                
                self.btnBuyoncepopup.layer.borderWidth = 1.0
                self.btnBuyoncepopup.layer.borderColor = UIColor(named: "darkmostredcolor")!.cgColor
                self.btnBuyoncepopup.layer.cornerRadius = 20.0
                self.btnBuyoncepopup.layer.masksToBounds = true
                
                self.btnpopupSubscribeDaily.isUserInteractionEnabled = false
                self.btnBpopupSubscribeWeekly.isUserInteractionEnabled = false
                self.btnpopupSubscribeMothly.isUserInteractionEnabled = false
                self.btnBuyoncepopup.isUserInteractionEnabled = false
            }
        }
    }
    
    
    //MARK: - Create Subscription Buy Once POPUP FIRST TIME
    func createSubscribePopup()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewpopupSubscribe.layer.cornerRadius = 6.0
        self.viewpopupSubscribe.layer.masksToBounds = true
        
        viewlocationselect.layer.cornerRadius = 4.0
        viewlocationselect.layer.borderWidth = 1.0
        viewlocationselect.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewlocationselect.layer.masksToBounds = true
        
        viewpopupSubscribeDaily.layer.borderWidth = 1.0
        viewpopupSubscribeDaily.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        viewpopupSubscribeDaily.layer.cornerRadius = 8.0
        viewpopupSubscribeDaily.layer.masksToBounds = true
        
        viewpopupSubscribeWeekly.layer.borderWidth = 1.0
        viewpopupSubscribeWeekly.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        viewpopupSubscribeWeekly.layer.cornerRadius = 8.0
        viewpopupSubscribeWeekly.layer.masksToBounds = true
        
        viewpopupSubscribeMothly.layer.borderWidth = 1.0
        viewpopupSubscribeMothly.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        viewpopupSubscribeMothly.layer.cornerRadius = 8.0
        viewpopupSubscribeMothly.layer.masksToBounds = true
        
        btnBuyoncepopup.layer.borderWidth = 1.0
        btnBuyoncepopup.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnBuyoncepopup.layer.cornerRadius = 20.0
        btnBuyoncepopup.layer.masksToBounds = true
        
        btncrossSubscribeBuyoncePopup.isHidden = false
        
        self.txtlocationselect.isUserInteractionEnabled = true
        
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.txtlocationselect.placeholder = myAppDelegate.changeLanguage(key: "msg_language53")
        
        lblchoosesubscriptionplan.text = myAppDelegate.changeLanguage(key: "msg_language36")
        
        btnBuyoncepopup.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language44")), for: .normal)
        
        lbldaily1.text = myAppDelegate.changeLanguage(key: "msg_language37")
        lbldaily2.text = myAppDelegate.changeLanguage(key: "msg_language40")
        
        lblweekly1.text = myAppDelegate.changeLanguage(key: "msg_language38")
        lblweekly2.text = myAppDelegate.changeLanguage(key: "msg_language41")
        
        lblmonthly1.text = myAppDelegate.changeLanguage(key: "msg_language39")
        lblmonthly2.text = myAppDelegate.changeLanguage(key: "msg_language42")
        
        lblgetyourdelivery.text = myAppDelegate.changeLanguage(key: "msg_language43")
        

        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            
        }
        else
        {

        }
        
        viewPopupAddNewExistingBG123 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG123.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG123.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG123.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG123.addSubview(self.viewpopupSubscribe)
        self.viewpopupSubscribe.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG123)
        
        //self.getAvailbleLOCATIONSLISTAPIMethod()
    }
    @IBAction func presscrosssubscribe(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.tabBarController?.selectedIndex = 0
        }
        else
        {
            self.tabBarController?.selectedIndex = 4
        }
        
    }
    @IBAction func pressBuyoncepopup(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.tabBarController?.selectedIndex = 2
        }
        else
        {
            self.tabBarController?.selectedIndex = 2
        }
        
    }
    @IBAction func pressSubscriptionpopupDaily(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
        
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.tabBarController?.selectedIndex = 1
        }
        else
        {
            self.tabBarController?.selectedIndex = 3
        }
        
        let navVC = self.tabBarController!.viewControllers![1] as! UINavigationController
        let SV = navVC.topViewController as! subsriptionclass
        SV.strpreSelectedplanfromHome = "Daily"
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.strSelectedPLAN = "Daily"

    }
    @IBAction func pressSubscriptionpopupWeekly(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.tabBarController?.selectedIndex = 1
        }
        else
        {
            self.tabBarController?.selectedIndex = 3
        }
        
        let navVC = self.tabBarController!.viewControllers![1] as! UINavigationController
        let SV = navVC.topViewController as! subsriptionclass
        SV.strpreSelectedplanfromHome = "Weekly"
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.strSelectedPLAN = "Weekly"
        
    }
    @IBAction func pressSubscriptionpopupMonthly(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.tabBarController?.selectedIndex = 1
        }
        else
        {
            self.tabBarController?.selectedIndex = 3
        }
        
        let navVC = self.tabBarController!.viewControllers![1] as! UINavigationController
        let SV = navVC.topViewController as! subsriptionclass
        SV.strpreSelectedplanfromHome = "Monthly"
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.strSelectedPLAN = "Monthly"
       
    }
    
    @IBAction func presslocationselect(_ sender: Any)
    {
        //CLICK TO FETCH CURRENT LOCATION
        self.locationManager.startUpdatingLocation()
        
        UserDefaults.standard.set(2, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        
        let ctrl = editchoosemaplocation(nibName: "editchoosemaplocation", bundle: nil)
        ctrl.strFrompageMap = "popupsubscriptionorderonce"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    @IBAction func pressinfoSubscriptionBuyoncePopup(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Please enter allowab lelocation
        let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language287") , preferredStyle: UIAlertController.Style.alert)
        self.present(uiAlert, animated: true, completion: nil)
        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("Click of default button")
        }))
    }
    
    
    //MARK: - CLLocationManager did Update location changes delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
         print("Current Location Updating...")
        
         var latdouble = Double()
         var longdouble = Double()
         latdouble = (manager.location?.coordinate.latitude)!
         longdouble = (manager.location?.coordinate.longitude)!
        
        self.strcurrentlat = String(format: "%0.10f", latdouble)
        self.strcurrentlong = String(format: "%0.10f", longdouble)
        print("self.strcurrentlat",self.strcurrentlat)
        print("self.strcurrentlong",self.strcurrentlong)
        
        //GET ADDRESS STRING FROM CURRENT LATITUDE & LONGITUDE
        self.getAddressFromLatLong(latitude: latdouble, longitude: longdouble)
        
        //CHCEKING WITHIN MULTIPLE POLYGON ZONE AREA
        self.checkpolygonPointMultiple(lat: Double(self.strcurrentlat)!, long: Double(self.strcurrentlong)!)
        self.alertViewFunction()

    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            manager.startUpdatingLocation()
            break
        case .denied:
            //handle denied
            break
        case .notDetermined:
             manager.requestWhenInUseAuthorization()
           break
        default:
            break
        }
    }
    
    //MARK: - CLLocationManager Authorization Delegate method
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.authorizedAlways)
        {
            print("authorizedAlways")
            manager.startUpdatingLocation()
        }
        else if (status == CLAuthorizationStatus.authorizedWhenInUse)
        {
            print("authorizedWhenInUse")
            manager.startUpdatingLocation()
        }
        else
        {
            manager.requestWhenInUseAuthorization()
            print("denied")
        }
    }
    func locationManager(_ manager: CLLocationManager,didDetermineState state: CLRegionState,for region: CLRegion)
    {
        if state == CLRegionState.inside {
            print("inside")
        }
        else if state == CLRegionState.outside {
            print("outside")
        }
        else if state == CLRegionState.unknown {
            print("unknown")
        }
    }
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.isEqual(txtlocationselect)
        {
            txtlocationselect.resignFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField){
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField.isEqual(txtlocationselect)
        {
            self.view.endEditing(true)
            
            UserDefaults.standard.set(2, forKey: "subscribebyoncepopupshown")
            UserDefaults.standard.synchronize()
            
            let ctrl = editchoosemaplocation(nibName: "editchoosemaplocation", bundle: nil)
            ctrl.strFrompageMap = "popupsubscriptionorderonce"
            self.navigationController?.pushViewController(ctrl, animated: true)
            
            /*if isBoolDropdown == true {
                handleTap1()
            }else{
                //self.popupDropdown(arrFeed: arrMALLLOCATIONS, txtfld: txtlocationselect, tagTable: 100)
            }*/
            
            return false
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder();
        return true;
    }
    
    // MARK: - Location List dropdown Method
    func popupDropdown(arrFeed:NSMutableArray,txtfld:UITextField, tagTable:Int)
    {
        let point = (txtfld.superview?.convert(txtfld.frame.origin, to: self.view))! as CGPoint
        print(point.y)
        
        isBoolDropdown = true
        tblViewDropdownList = UITableView(frame: CGRect(x: self.viewlocationselect.frame.origin.x, y: point.y + self.viewlocationselect.frame.size.height, width: self.viewlocationselect.frame.size.width, height: 0))
        tblViewDropdownList?.delegate = self
        tblViewDropdownList?.dataSource = self
        tblViewDropdownList?.tag = tagTable
        tblViewDropdownList?.backgroundView = nil
        tblViewDropdownList?.backgroundColor = UIColor(named: "plate7")!
        tblViewDropdownList?.separatorColor = UIColor.clear
        tblViewDropdownList?.layer.borderWidth = 1.0
        tblViewDropdownList?.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        tblViewDropdownList?.layer.cornerRadius = 0.0
        tblViewDropdownList?.layer.masksToBounds = true
        
        self.view.addSubview(tblViewDropdownList!)
        
        arrMGlobalDropdownFeed = arrFeed
        
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewDropdownList?.frame)!
            frame.size.height =  140//UIScreen.main.bounds.size.height/2.0-64
            self.tblViewDropdownList?.frame = frame
            //print(self.tblViewDropdownList?.frame as Any)
        }, completion: nil)
    }
    func handleTap1()
    {
        isBoolDropdown = false
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewDropdownList?.frame)!
            frame.size.height = 0
            self.tblViewDropdownList?.frame = frame
        }, completion: { (nil) in
            self.tblViewDropdownList?.removeFromSuperview()
            self.tblViewDropdownList = nil
        })
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMGlobalDropdownFeed.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let title1 = UILabel(frame: CGRect(x: 15, y: 0, width:  (tblViewDropdownList?.frame.size.width)! - 15, height: 40))
        title1.textAlignment = .left
        title1.textColor = UIColor.black
        title1.backgroundColor = UIColor.clear
        title1.font = UIFont.systemFont(ofSize: 14)
        cell.contentView.addSubview(title1)
      
        let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
        //let strvalue = String(format: "%@", dictemp.value(forKey: "value")as! CVarArg)
        let strlabel = String(format: "%@", dictemp.value(forKey: "label")as? String ?? "")
       
        title1.text = strlabel
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 39, width: tableView.frame.size.width, height: 1))
        lblSeparator.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        cell.contentView.addSubview(lblSeparator)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
        let strvalue = String(format: "%@", dictemp.value(forKey: "value")as! CVarArg)
        let strlabel = String(format: "%@", dictemp.value(forKey: "label")as? String ?? "")
        
        self.txtlocationselect.tag = Int(strvalue)!
        self.txtlocationselect.text = strlabel
        
        UserDefaults.standard.set(strlabel, forKey: "loggedinusersavedlocationname")
        UserDefaults.standard.set(strvalue, forKey: "loggedinusersavedlocationid")
        UserDefaults.standard.synchronize()
        handleTap1()
    }
    
    
    
    // MARK: - create Banner Gallery method
    @objc func createBannerGallery(arrimages:NSMutableArray)
    {
        var imageSDWebImageSrc = [SDWebImageSource]()
        
        for x in 0 ..< arrimages.count
        {
            let dict = arrimages[x] as! NSDictionary
            let strimageurl = String(format: "%@", dict.value(forKey: "image") as? String ?? "")
            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
            
            let image = SDWebImageSource(urlString: strFinalurl)
            imageSDWebImageSrc.append(image!)
        }
        
        print("imageSDWebImageSrc",imageSDWebImageSrc)
        
        //let localSource = [BundleImageSource(imageString: "banner1.png"), BundleImageSource(imageString: "banner1.png"), BundleImageSource(imageString: "banner1.png"), BundleImageSource(imageString: "banner1.png"), BundleImageSource(imageString: "banner1.png")]
        
        //let afNetworkingSource = [AFURLSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        //let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        //let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        //let kingfisherSource = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.black
        //pageIndicator.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "customdot.png")!)
        //UIColor(named: "themecolor")!
        pageIndicator.pageIndicatorTintColor = UIColor.gray
        
        viewbanner.pageIndicator = pageIndicator
        viewbanner.slideshowInterval = 5.0
        viewbanner.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        viewbanner.contentScaleMode = UIViewContentMode.scaleToFill
        //slideshow.pageIndicator = UIPageControl.withSlideshowColors()
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        viewbanner.activityIndicator = DefaultActivityIndicator()
        viewbanner.delegate = self
        
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        viewbanner.setImageInputs(imageSDWebImageSrc)
        //viewbanner.setImageInputs(localSource)
        
        viewbanner.backgroundColor = .white
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        viewbanner.addGestureRecognizer(recognizer)
        
    }
    @objc func didTap() {
        let fullScreenController = viewbanner.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    //MARK: - create Explore Category method
    func createExploreCategory()
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
            floatDevider = 2.0
        }
        else
        {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            floatDevider = 3.0
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colcategory.frame.size.width / floatDevider, height: 144)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colcategory.collectionViewLayout = layout
        colcategory.register(UINib(nibName: "colcellcategory", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colcategory.showsHorizontalScrollIndicator = false
        colcategory.showsVerticalScrollIndicator=false
        colcategory.backgroundColor = .white
        self.colcategory.isScrollEnabled = false
    }
    
    //MARK: - create Explore TopDeals method
    func createExploreTopDeals()
    {
        btnviewalltopdeals.layer.cornerRadius = 14.0
        btnviewalltopdeals.layer.borderWidth = 1.0
        btnviewalltopdeals.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnviewalltopdeals.layer.masksToBounds = true
         
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: coltopdeals.frame.size.width / 2.3, height: 275)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        coltopdeals.collectionViewLayout = layout
        coltopdeals.register(UINib(nibName: "colcelltopdeals", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
        coltopdeals.showsHorizontalScrollIndicator = false
        coltopdeals.showsVerticalScrollIndicator=false
        coltopdeals.backgroundColor = .clear
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView ==  colcategory
        {
            return arrMcategory.count
        }
        print("arrMtopdeals.count",arrMtopdeals.count)
        return arrMtopdeals.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.colcategory
        {
            
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellcategory
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            let dict = arrMcategory.object(at: indexPath.row) as! NSDictionary
            
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            //let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            let strcategoryImage = String(format: "%@", dict.value(forKey: "categoryImage") as? String ?? "")
            let strFinalurl = strcategoryImage.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
            
            print("strtext",strtext)
            
            
            cellA.viewcell.layer.cornerRadius = 6.0
            cellA.viewcell.layer.masksToBounds = true
            
            
            if strtext.containsIgnoreCase("Dairy"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate1")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome1.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else if strtext.containsIgnoreCase("Juice"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate2")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome2.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else if strtext.containsIgnoreCase("Bakery"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate3")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome3.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else if strtext.containsIgnoreCase("Meat"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate4")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome4.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else if strtext.containsIgnoreCase("Gift"){
                cellA.contentView.isHidden = true
            }
            else
            {
                cellA.viewtop.backgroundColor = UIColor(named: "plate7")!
                cellA.imgvbg.isHidden = true

                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            
            cellA.lblname.bringSubviewToFront(cellA.viewtop)
            //cellA.lblname.attributedText = strtext.htmlToAttributedString
            cellA.lblname.text =  strtext
            
            cellA.viewtop.layer.cornerRadius = 6.0
            cellA.viewtop.layer.masksToBounds = true
            
            
            // Set up cell
            return cellA
        }
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! colcelltopdeals
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        cellA.viewcell.layer.cornerRadius = 4.0
        cellA.viewcell.layer.borderWidth = 1.0
        cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cellA.viewcell.layer.masksToBounds = true
        
       
        let dict = arrMtopdeals.object(at: indexPath.row) as! NSDictionary
        
        //let strproductid = String(format: "%@", dict.value(forKey: "productid") as! CVarArg)
        let strname = String(format: "%@", dict.value(forKey: "name") as? String ?? "")
        //let strsku = String(format: "%@", dict.value(forKey: "sku") as? String ?? "")
        let strprice = String(format: "%@", dict.value(forKey: "price") as? String ?? "")
        let strsize = String(format: "%@", dict.value(forKey: "size") as? String ?? "")
        let strbrand = String(format: "%@", dict.value(forKey: "brand") as? String ?? "")
        //let strstatus = String(format: "%@", dict.value(forKey: "status") as? String ?? "")
       
        let stris_addedwishlist = String(format: "%@", dict.value(forKey: "is_addedwishlist") as? String ?? "")
        print("stris_addedwishlist",stris_addedwishlist)
        
        
        let arrmedia = dict.value(forKey: "media")as? NSArray ?? []
        let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")
        let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
        print("strFinalurl",strFinalurl)
       
        cellA.imgv.contentMode = .scaleAspectFit
        cellA.imgv.imageFromURL(urlString: strFinalurl)
        
        cellA.lblname.text = strname
        cellA.lblbrand.text = strbrand
        cellA.lblqty.text = strsize
        
        let fltprice = Float(strprice)
        cellA.lblprice.text = String(format: "%.2f", fltprice!)
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        cellA.btnaddonce.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language47")), for: .normal)
        
        cellA.btnaddonce.layer.borderWidth = 1.0
        cellA.btnaddonce.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        cellA.btnaddonce.layer.cornerRadius = 16.0
        cellA.btnaddonce.layer.masksToBounds = true
        
        cellA.btnaddonce.tag = indexPath.row
        cellA.btnaddonce.addTarget(self, action: #selector(pressaddtocarttopdeals), for: .touchUpInside)
        
        cellA.btnright.isHidden = true
        
        if stris_addedwishlist == "True"
        {
            cellA.btnfav.isHidden = false
            cellA.btnfav.setImage(UIImage(named: "favselected"), for: .normal)
        }
        else{
            cellA.btnfav.isHidden = false
            cellA.btnfav.setImage(UIImage(named: "fav1"), for: .normal)
        }
        
        cellA.btnfav.tag = indexPath.row
        cellA.btnfav.addTarget(self, action: #selector(pressAddToWishlist), for: .touchUpInside)
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView ==  colcategory
        {
            return CGSize(width: colcategory.frame.size.width / 3, height: 144)
        }
        return CGSize(width: coltopdeals.frame.size.width / 2.3 , height: 316)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.colcategory
        {
            let dict = arrMcategory.object(at: indexPath.row) as! NSDictionary
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            
            let arrm1 = dict.value(forKey: "children") as? NSArray ?? []
            
            if strtext.containsIgnoreCase("new arrivals")
            {
                print("Go to New Arrival Page")
                let ctrl = newarrivalproduct(nibName: "newarrivalproduct", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else
            {
                let ctrl = productcatalogue(nibName: "productcatalogue", bundle: nil)
                ctrl.strpageidentifier = "1001"
                ctrl.strFromCategoryID = strid
                ctrl.strFromCategoryNAME = strtext
                ctrl.arrmsubcatlist = NSMutableArray(array: arrm1)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
        else if collectionView == self.coltopdeals
        {
            let dict = arrMtopdeals.object(at: indexPath.row) as! NSDictionary
            let strproductid = String(format: "%@", dict.value(forKey: "productid") as! CVarArg)
            
            let ctrl = porudctdetails(nibName: "porudctdetails", bundle: nil)
            ctrl.strSelectedProductID = strproductid
            ctrl.strFrompageIdentifier = "1001"
            self.navigationController?.pushViewController(ctrl, animated: true)
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
        
        let dict = arrMtopdeals.object(at: sender.tag) as! NSDictionary
        let strproductid = String(format: "%@", dict.value(forKey: "productid") as! CVarArg)
        
        let stris_addedwishlist = String(format: "%@", dict.value(forKey: "is_addedwishlist") as? String ?? "")
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
    
    //MARK: - press ADD TO CART TOP DEALS
    @objc func pressaddtocarttopdeals(sender:UIButton)
    {
        let dict = arrMtopdeals.object(at: sender.tag) as! NSDictionary
        let strproductid = String(format: "%@", dict.value(forKey: "productid") as! CVarArg)
        self.postAddToCartApiMethod(strqty: "1", strproductid: strproductid)
    }
    
    //MARK: - get home page banner API method
    func gethomepagebannermethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        //let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        //print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod7,"")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        //request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
                    self.postAllCategoryHomepageAPImethod()
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
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let arrMGallery = json.value(forKey: "bannerImage") as? NSArray ?? []
                            self.arrMbanner = NSMutableArray(array: arrMGallery)
                            print("arrMbanner --->",self.arrMbanner)
                            
                            self.createBannerGallery(arrimages: self.arrMbanner)
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.postAllCategoryHomepageAPImethod()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
                    self.postAllCategoryHomepageAPImethod()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
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
                          "categoryId": "none","pageFromId": "2","language": ""] as [String : Any]
        

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
                    self.btnviewalltopdeals.isHidden = true
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    
                    self.view.activityStopAnimating()
                    
                    self.postTopDelasHomepageAPImethod()
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
                            if self.arrMcategory.count > 0 {
                                self.arrMcategory.removeAllObjects()
                            }
                            let arrmcategorytree = dictemp.value(forKey: "categoryTree") as? NSArray ?? []
                            self.arrMcategory = NSMutableArray(array: arrmcategorytree)
                            print("arrMcategory --->",self.arrMcategory)
                            self.btnviewalltopdeals.isHidden = false

                        }
                        else{
                            
                            self.btnviewalltopdeals.isHidden = true
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        self.colcategory.reloadData()
                        
                        self.postTopDelasHomepageAPImethod()
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
                    self.btnviewalltopdeals.isHidden = true
                    self.postTopDelasHomepageAPImethod()
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Top Deals Products Home Page method
    func postTopDelasHomepageAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        

        let parameters = ["language": strLangCode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod8)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        print("strconnurl",strconnurl)
        
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
                    self.getOrderOnceCartCountAPIMethod()
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
                    print("dictemp topdeals--->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            if self.arrMtopdeals.count > 0 {
                                self.arrMtopdeals.removeAllObjects()
                            }
                            
                            let arrMtopdelas = dictemp.value(forKey: "productdetails") as? NSArray ?? []
                            self.arrMtopdeals = NSMutableArray(array: arrMtopdelas)
                            print("arrMtopdeals --->",self.arrMtopdeals)
                            
                            if self.arrMtopdeals.count > 0{
                                self.coltopdeals.reloadData()
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
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
                                
                                self.getOrderOnceCartCountAPIMethod()
                            }))
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
                    self.getBOTTOMBANNER1APIMethod()
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
                                    self.tabBarController!.tabBar.items![3].badgeValue = String(format: "%d", strcount)
                                    
                                }else{
                                    self.tabBarController!.tabBar.items![1].badgeValue = String(format: "%d", strcount)
                                }
                                
                                //self.setupRightBarCartBagDesignMethod(intcountOrder: strcount)
                            }
                            else{
                                print("Not found!")
                                
                                UserDefaults.standard.set("0", forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                
                                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                                if (strLangCode == "en")
                                {
                                    self.tabBarController!.tabBar.items![3].badgeValue = ""
                                }else{
                                    self.tabBarController!.tabBar.items![1].badgeValue = ""
                                }
                                //self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
                                
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getBOTTOMBANNER1APIMethod()
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
                    self.getBOTTOMBANNER1APIMethod()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - get Bottom Banner 1 API method
    func getBOTTOMBANNER1APIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl,Constants.methodname.apimethod98)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                    self.getBOTTOMBANNER2APIMethod()
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
                            //Banner 1 -- Non Clickable Now
                            let strimageurl = String(format: "%@", dictemp.value(forKey: "bannerImage") as? String ?? "")
                            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
                            print("strFinalurl",strFinalurl)
                            
                            self.strBottomBANNER1name = strmessage
                            self.strBottomBANNER1image = strFinalurl
                            self.imgvpromobox1.imageFromURL(urlString: self.strBottomBANNER1image)
                        }
                        else
                        {
                            /*let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))*/
                        }
                        
                        self.getBOTTOMBANNER2APIMethod()
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
                    self.getBOTTOMBANNER2APIMethod()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - get Bottom Banner 2 API method
    func getBOTTOMBANNER2APIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl,Constants.methodname.apimethod99)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                    self.getBOTTOMBANNER3APIMethod()
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
                            //Banner 2 - Juice Redirection
                            let strimageurl = String(format: "%@", dictemp.value(forKey: "bannerImage") as? String ?? "")
                            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
                            print("strFinalurl",strFinalurl)
                            
                            self.strBottomBANNER2name = strmessage
                            self.strBottomBANNER2image = strFinalurl
                            self.imgvpromobox2.imageFromURL(urlString: self.strBottomBANNER2image)
                        }
                        else{
                            /*let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))*/
                        }
                        self.getBOTTOMBANNER3APIMethod()
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
                    self.getBOTTOMBANNER3APIMethod()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - get Bottom Banner 3 API method
    func getBOTTOMBANNER3APIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl,Constants.methodname.apimethod100)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                            //Banner 3 - New Arrival Redirection
                            let strimageurl = String(format: "%@", dictemp.value(forKey: "bannerImage") as? String ?? "")
                            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
                            print("strFinalurl",strFinalurl)
                            
                            self.strBottomBANNER3name = strmessage
                            self.strBottomBANNER3image = strFinalurl
                            self.imgvpromobox3.imageFromURL(urlString: self.strBottomBANNER3image)
                        }
                        else{
                           /* let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))*/
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
    
    
    //MARK: - get Availble LOCATIONS LIST API method
    func getAvailbleLOCATIONSLISTAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod65)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                            if self.arrMALLLOCATIONS.count > 0{
                                self.arrMALLLOCATIONS.removeAllObjects()
                            }
                            let arrm = json.value(forKey: "location") as? NSArray ?? []
                            self.arrMALLLOCATIONS = NSMutableArray(array: arrm)
                            print("arrMALLLOCATIONS --->",self.arrMALLLOCATIONS)
                            
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

    //MARK: - GET Address by Lat Long - Google API
    func getAddressFromLatLong(latitude: Double, longitude : Double)
    {
        var strconnurl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(Constants.conn.GoogleAPIKey)"
        strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
        print("strconnurl",strconnurl)
        AF.request(strconnurl,method: .get,encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            
            switch response.result{
            case .success(let JSON):
                
                //print("Success with JSON: \(String(describing: JSON))")
                
                //let array = JSON as? NSArray
                //print("array",array)
                
                let dic = JSON as? NSDictionary
                print("dic",dic as Any)
                
                let strstatus = String(format: "%@", dic?.value(forKey: "status")as? String ?? "")
                if strstatus == "OK"
                {
                    print("success")
                    
                    DispatchQueue.main.async {
                        
                        let arrmresults = dic?.value(forKey: "results")as? NSArray ?? []
                        print("arrmresults",arrmresults)
                        
                        let dic = arrmresults.object(at: 0)as? NSDictionary
                        
                        //FIXME_____ FETCH CITY AND LOCATION NAME ______//
                        /*let arraddress_components = dic?.value(forKey: "address_components")as! NSArray
                        for xx in 0 ..< arraddress_components.count
                        {
                            let dicaddress = arraddress_components.object(at: xx)as! NSDictionary
                            let strlong_name = String(format: "%@", dicaddress.value(forKey: "long_name")as? String ?? "")
                            
                            let arrmtypes = dicaddress.value(forKey: "types")as! NSArray
                            for yy in 0 ..< arrmtypes.count
                            {
                                let strtype = String(format: "%@", arrmtypes.object(at: yy)as? String ?? "")
                                if strtype == "sublocality" || strtype == "neighborhood" || strtype == "sublocality_level_1"
                                {
                                    //THEN FETCH LOCATION NAME
                                    self.strlocationname = strlong_name
                                }
                                
                                if strtype == "locality"
                                {
                                    //THEN FETCH CITY NAME
                                    self.strcityname = strlong_name
                                }
                            }
                        }*/
                        
                       
                        let strformattedaddress = String(format: "%@", dic?.value(forKey: "formatted_address")as? String ?? "")
                        print("strformattedaddress",strformattedaddress)
                        if self.txtlocationselect.text!.count > 0{
                            self.txtlocationselect.text = ""
                        }
                        self.txtlocationselect.text = strformattedaddress
                    }
                }
                else{
                    print("failure")
                }
                
                break
            case .failure:
                print("failure")
            }
        }
        
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
                        
                        self.postTopDelasHomepageAPImethod()
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
                            self.postTopDelasHomepageAPImethod()
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
    
    //MARK: - get Polugon API List method
    func getPolygonApiList()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod109)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        //request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
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
                            if self.arrmPolygonlist.count > 0{
                                self.arrmPolygonlist.removeAllObjects()
                            }
                            
                            let arrmlocation = dictemp.value(forKey: "location") as? NSArray ?? []
                            self.arrmPolygonlist = NSMutableArray(array: arrmlocation)
                            print("arrmPolygonlist --->",self.arrmPolygonlist)
                            
                            self.createMultiPolygon()
                            
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
    
}
extension UIView{
    
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor)
    {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        let circle = UIView ()
        circle.backgroundColor = activityColor
        circle.alpha = 1.0
        let size = 48
        let size1 = 48
        var frame = circle.frame
        frame.size.width = CGFloat(size)
        frame.size.height = CGFloat(size1)
        frame.origin.x = backgroundView.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = backgroundView.frame.size.height / 2 - frame.size.height / 2;
        circle.frame = frame
        circle.center = backgroundView.center
        circle.layer.cornerRadius = 24.0
        circle.layer.borderWidth = 1.0
        circle.layer.borderColor=UIColor.clear.cgColor
        circle.layer.masksToBounds = true
        
        let  animatedImageView =  UIImageView(frame: circle.bounds)
        animatedImageView.animationImages = NSArray(objects:UIImage(named: "loader1.png")!,
                                                    UIImage(named: "loader2.png")!,
                                                    UIImage(named: "loader3.png")!,
                                                    UIImage(named: "loader4.png")!,
                                                    UIImage(named: "loader5.png")!,
                                                    UIImage(named: "loader6.png")!,
                                                    UIImage(named: "loader7.png")!,
                                                    UIImage(named: "loader8.png")!,
                                                    UIImage(named: "loader9.png")!,
                                                    UIImage(named: "loader10.png")!,
                                                    UIImage(named: "loader11.png")!,
                                                    UIImage(named: "loader12.png")!,
                                                    UIImage(named: "loader13.png")!,
                                                    UIImage(named: "loader14.png")!,
                                                    UIImage(named: "loader15.png")!,
                                                    UIImage(named: "loader16.png")!,
                                                    UIImage(named: "loader17.png")!,
                                                    UIImage(named: "loader18.png")!,
                                                    UIImage(named: "loader19.png")!,
                                                    UIImage(named: "loader20.png")!,
                                                    UIImage(named: "loader21.png")!,
                                                    UIImage(named: "loader22.png")!,
                                                    UIImage(named: "loader23.png")!,
                                                    UIImage(named: "loader24.png")!,
                                                    UIImage(named: "loader25.png")!,
                                                    UIImage(named: "loader26.png")!,
                                                    UIImage(named: "loader27.png")!,
                                                    UIImage(named: "loader28.png")!,
                                                    UIImage(named: "loader29.png")!,
                                                    UIImage(named: "loader30.png")!) as? [UIImage]
        
        animatedImageView.contentMode = .scaleToFill
        animatedImageView.animationDuration = 13
        animatedImageView.animationRepeatCount = 0
        animatedImageView.startAnimating()
        circle.addSubview(animatedImageView)
        circle.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2 - 60)
        
        backgroundView.addSubview(circle)
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    
}
extension UIImageView
{
    public func imageFromURL(urlString: String) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.color =  UIColor(red: 78.0/255, green: 129.0/255, blue: 237.0/255, alpha: 1.0)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        //if self.image == nil{
        //self.addSubview(activityIndicator)
        //}
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
extension String {
    func containsIgnoreCase(_ string: String) -> Bool {
        return self.lowercased().contains(string.lowercased())
    }
}
