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

class homeclass: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,ImageSlideshowDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
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
    
    
    var arrMbanner = NSMutableArray()
    var arrMcategory = NSMutableArray()
    var arrMtopdeals = NSMutableArray()
    
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        
        let subscribebyoncepopupshown = UserDefaults.standard.integer(forKey: "subscribebyoncepopupshown")
        if subscribebyoncepopupshown == 0{
            //POPUP SHOW FIRST TIME
            print("subscribebyoncepopupshown",subscribebyoncepopupshown)
            self.createSubscribePopup()
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
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
        if appDel.strSelectedPLAN.count > 0 && appDel.arrMDATEWISEPRODUCTPLAN.count > 0
        {
            self.createOrderonPopup()
            
        }
        
        self.gethomepagebannermethod()
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillDisappear(_ animated: Bool)
    {
        self.tabBarController?.tabBar.isHidden = true
        super.viewWillDisappear(true)
    }
    
    // MARK: - viewDidLayoutSubviews Method
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()

        DispatchQueue.main.async {
            
            let appDel = UIApplication.shared.delegate as! AppDelegate
            print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
            if appDel.strSelectedPLAN.count > 0 && appDel.arrMDATEWISEPRODUCTPLAN.count > 0
            {
                var contentRect = CGRect.zero
                for view in self.scrolloverall.subviews {
                   contentRect = contentRect.union(view.frame)
                }
                print("contentRect.size",contentRect.size)
                self.scrolloverall.contentSize = CGSize(width: contentRect.size.width, height: contentRect.size.height + 155)
            }
        }
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        setupNavLogo()
        
        let searchicon = UIImage(named: "search")
        let search = UIBarButtonItem(image: searchicon, style: .plain, target: self, action: #selector(pressSearch))
        search.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = search
        
        print("self.viewoverall.bounds.size.height",self.viewoverall.bounds.size.height)
        self.scrolloverall.contentSize = CGSize(width: self.viewoverall.bounds.size.width, height: self.viewoverall.bounds.size.height)
        self.scrolloverall.showsVerticalScrollIndicator = false
        
        self.btnviewalltopdeals.isHidden = true
        
        self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
        
        self.createExploreCategory()
        self.createExploreTopDeals()
        

    }
    
    //MARK: - press Search method
    @objc func pressSearch()
    {
        let ctrl = searchproductlist(nibName: "searchproductlist", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press View All Top Deals Method
    @IBAction func pressviewalltopdeals(_ sender: Any)
    {
        print("self.arrMcategory",self.arrMcategory)
        var strcatid = ""
        var strcatname = ""
        for x in 0 ..< self.arrMcategory.count
        {
            let dictemp = self.arrMcategory.object(at: x)as! NSDictionary
            let strname = String(format: "%@", dictemp.value(forKey: "text")as? String ?? "")
            if strname.containsIgnoreCase("offers")
            {
                let strid = String(format: "%@", dictemp.value(forKey: "id") as! CVarArg)
                strcatid = strid
                strcatname = strname
            }
        }
        
        if strcatid == "" || strcatname == ""
        {
            let uiAlert = UIAlertController(title: "", message: "No more offers available on Top Deals!", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            let ctrl = productcatalogue(nibName: "productcatalogue", bundle: nil)
            ctrl.strpageidentifier = "1001"
            ctrl.strFromCategoryID = strcatid
            ctrl.strFromCategoryNAME = strcatname
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
        
        navigationItem.rightBarButtonItems = [rightBarButtomItem]
    }
    
    //MARK: - press Cartbag method
    @objc func presscartbag()
    {
        let ctrl = cartlistorderonce(nibName: "cartlistorderonce", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Bottom Promotion Box Method
    @IBAction func presspromobox1(_ sender: Any) {
    }
    @IBAction func presspromobox2(_ sender: Any) {
    }
    @IBAction func presspromobox3(_ sender: Any) {
        let ctrl = newarrivalproduct(nibName: "newarrivalproduct", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    //MARK: - POPUP SUBSCRIPTION BUY ONCE
    @IBOutlet var viewpopupSubscribe: UIView!
    @IBOutlet weak var imgvlogosubscribe: UIImageView!
    @IBOutlet weak var lblchoosesubscriptionplan: UILabel!
    @IBOutlet weak var btnBuyoncepopup: UIButton!
    @IBOutlet var viewpopupSubscribeDaily: UIView!
    @IBOutlet var viewpopupSubscribeWeekly: UIView!
    @IBOutlet var viewpopupSubscribeMothly: UIView!
    @IBOutlet weak var lblgetyourdelivery: UILabel!
    var viewPopupAddNewExistingBG123 = UIView()
    
    func createSubscribePopup()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewpopupSubscribe.layer.cornerRadius = 6.0
        self.viewpopupSubscribe.layer.masksToBounds = true
        
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
        
        viewPopupAddNewExistingBG123 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG123.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG123.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG123.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG123.addSubview(self.viewpopupSubscribe)
        self.viewpopupSubscribe.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG123)
    }
  
    //MARK: - press Cross Subscribe Popup method
    @IBAction func presscrosssubscribe(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
        
        self.tabBarController?.selectedIndex = 0
    }
    //MARK: - press Buyonce Subscribe Popup method
    @IBAction func pressBuyoncepopup(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
    }
    //MARK: - press Subscription Subscribe Popup DAILY / WEEKLY / MONTHLY method
    @IBAction func pressSubscriptionpopupDaily(_ sender: Any)
    {
        UserDefaults.standard.set(1, forKey: "subscribebyoncepopupshown")
        UserDefaults.standard.synchronize()
        self.viewpopupSubscribe.removeFromSuperview()
        viewPopupAddNewExistingBG123.removeFromSuperview()
        
        self.tabBarController?.selectedIndex = 1
        
        
        
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
        
        self.tabBarController?.selectedIndex = 1
        
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
        
        self.tabBarController?.selectedIndex = 1
        
        let navVC = self.tabBarController!.viewControllers![1] as! UINavigationController
        let SV = navVC.topViewController as! subsriptionclass
        SV.strpreSelectedplanfromHome = "Monthly"
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.strSelectedPLAN = "Monthly"
       
    }
    
    
    //MARK: - POPUP ORDER ON METHOD
    @IBOutlet var viewpopupOrderon: UIView!
    @IBOutlet var viewpopuplblOrderon: UILabel!
    @IBOutlet var viewpopupcolorderon: UICollectionView!
    var reuseIdentifier3 = "cellcolordernow"
    var viewPopupAddNewExistingBG1234 = UIView()
    
    func createOrderonPopup()
    {
        if self.viewpopupOrderon != nil{
            self.viewpopupOrderon.removeFromSuperview()
            viewPopupAddNewExistingBG1234.removeFromSuperview()
        }
        
        let heightTabbar = self.tabBarController?.tabBar.frame.height ?? 49.0
        print("heightTabbar",heightTabbar)
        
        self.viewpopupOrderon.layer.cornerRadius = 0.0
        self.viewpopupOrderon.layer.masksToBounds = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: viewpopupcolorderon.frame.size.width / 3 - 10, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        viewpopupcolorderon.collectionViewLayout = layout
        viewpopupcolorderon.register(UINib(nibName: "cellcolordernow", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier3)
        viewpopupcolorderon.showsHorizontalScrollIndicator = false
        viewpopupcolorderon.showsVerticalScrollIndicator=false
        viewpopupcolorderon.backgroundColor = .clear
        
        viewPopupAddNewExistingBG1234 = UIView(frame: CGRect(x: 0, y: self.viewoverall.frame.maxY - 135, width: self.view.frame.size.width, height:self.viewpopupOrderon.frame.size.height))
        viewPopupAddNewExistingBG1234.backgroundColor = .yellow
        self.viewpopupOrderon.frame = CGRect(x: 0, y: 0, width: viewPopupAddNewExistingBG1234.frame.size.width, height: viewPopupAddNewExistingBG1234.frame.size.height)
        
        viewPopupAddNewExistingBG1234.addSubview(self.viewpopupOrderon)
        self.view.addSubview(viewPopupAddNewExistingBG1234)
    }
    //MARK: - press Cross OrderOn Popup method
    @IBAction func presscrossorderon(_ sender: Any)
    {
        self.viewpopupOrderon.removeFromSuperview()
        viewPopupAddNewExistingBG1234.removeFromSuperview()
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
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colcategory.frame.size.width / 3, height: 150)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colcategory.collectionViewLayout = layout
        colcategory.register(UINib(nibName: "colcellcategory", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colcategory.showsHorizontalScrollIndicator = false
        colcategory.showsVerticalScrollIndicator=false
        colcategory.backgroundColor = .white
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
        layout.itemSize = CGSize(width: coltopdeals.frame.size.width / 2.3, height: 316)
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
        else if collectionView == viewpopupcolorderon
        {
            let appDel = UIApplication.shared.delegate as! AppDelegate
            return appDel.arrMDATEWISEPRODUCTPLAN.count
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
            
            
            cellA.viewcell.layer.cornerRadius = 6.0
            cellA.viewcell.layer.masksToBounds = true
            
            
            if strtext.contains("Dairy"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate1")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome1.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else if strtext.contains("Juice"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate2")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome2.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else if strtext.contains("Bakery"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate3")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome3.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else if strtext.contains("Meat & Poultry"){
                cellA.viewtop.backgroundColor = UIColor(named: "plate4")!
                cellA.imgvbg.isHidden = true
                //cellA.imgv.image = UIImage(named: "cathome4.png")
                cellA.imgv.imageFromURL(urlString: strFinalurl)
            }
            else
            {
                cellA.viewtop.backgroundColor = .white
                cellA.viewtop.layer.cornerRadius = 8
                cellA.viewtop.layer.borderWidth = 1.0
                cellA.viewtop.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
                cellA.viewtop.layer.masksToBounds = true
                
                cellA.imgvbg.isHidden = false
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
        else if collectionView == viewpopupcolorderon
        {
            let appDel = UIApplication.shared.delegate as! AppDelegate
            
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! cellcolordernow
            cellA.contentView.backgroundColor = .clear
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 1.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
            
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

                var intvalue = Float()
                intvalue = Float(strunitqty)! * Float(strunitprice)!
                intvalueTotal = intvalueTotal + Int(intvalue)
                
            }
            let strtotalprice = String(format: "%d", intvalueTotal)
            
            cellA.lbldate.text = strdate
            cellA.lblday.text = strday
            
            if strtotalprice == "0"{
                cellA.lbltotalprice.textColor = UIColor(named: "orangecolor")!
                cellA.lbltotalprice.text = "+ Add More"
            }
            else{
                cellA.lbltotalprice.textColor = UIColor.darkGray
                cellA.lbltotalprice.text = String(format: "AED %@", strtotalprice)
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
                cellA.viewcell.layer.cornerRadius = 4.0
                cellA.viewcell.layer.borderWidth = 1.0
                cellA.viewcell.layer.borderColor = UIColor(named: "darkredcolor")!.cgColor
                cellA.viewcell.layer.masksToBounds = true
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
                cellA.viewcell.layer.cornerRadius = 4.0
                cellA.viewcell.layer.borderWidth = 1.0
                cellA.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
                cellA.viewcell.layer.masksToBounds = true
                
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
                
                cellA.viewcell.backgroundColor = UIColor(named: "darkredcolor")!
                cellA.viewcell.layer.cornerRadius = 4.0
                cellA.viewcell.layer.borderWidth = 1.0
                cellA.viewcell.layer.borderColor = UIColor(named: "darkredcolor")!.cgColor
                cellA.viewcell.layer.masksToBounds = true
                
            }
            
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
        
        let strproductid = String(format: "%@", dict.value(forKey: "productid") as! CVarArg)
        let strname = String(format: "%@", dict.value(forKey: "name") as? String ?? "")
        let strsku = String(format: "%@", dict.value(forKey: "sku") as? String ?? "")
        let strprice = String(format: "%@", dict.value(forKey: "price") as? String ?? "")
        let strsize = String(format: "%@", dict.value(forKey: "size") as? String ?? "")
        let strbrand = String(format: "%@", dict.value(forKey: "brand") as? String ?? "")
        let strstatus = String(format: "%@", dict.value(forKey: "status") as? String ?? "")
        
        
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
        
        cellA.btnaddonce.backgroundColor = .white
        cellA.btnaddonce.setTitle("ADD TO CART", for: .normal)
        cellA.btnaddonce.setTitleColor(UIColor(named: "themecolor")!, for: .normal)
        cellA.btnaddonce.titleLabel?.font = UIFont (name: "NunitoSans-Bold", size: 16)
        
        cellA.btnaddonce.isHidden = false
        cellA.btnaddtoall.isHidden = true
        cellA.viewplusminus.isHidden = true
        cellA.viewplusminusATA.isHidden = true
        
        cellA.btnaddonce.frame = CGRect(x: cellA.btnaddonce.frame.origin.x, y: cellA.btnaddonce.frame.origin.y + 10, width: cellA.btnaddonce.frame.size.width, height: cellA.btnaddonce.frame.size.height)

        cellA.btnaddonce.tag = indexPath.row
        cellA.btnaddonce.addTarget(self, action: #selector(pressaddtocarttopdeals), for: .touchUpInside)
        
        cellA.btnright.isHidden = true
        cellA.btnfav.isHidden = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView ==  colcategory
        {
            return CGSize(width: colcategory.frame.size.width / 3, height: 150)
        }
        else if collectionView == viewpopupcolorderon
        {
            return CGSize(width: colcategory.frame.size.width / 3 - 10, height: 100)
        }
        return CGSize(width: coltopdeals.frame.size.width / 2.3 , height: 316)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if collectionView == viewpopupcolorderon
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.colcategory
        {
            let dict = arrMcategory.object(at: indexPath.row) as! NSDictionary
            let strtext = String(format: "%@", dict.value(forKey: "text") as? String ?? "")
            let strid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            
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
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
        else if collectionView == viewpopupcolorderon
        {
            
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
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod7)
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
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            let arrMGallery = json.value(forKey: "bannerImage") as? NSArray ?? []
                            self.arrMbanner = NSMutableArray(array: arrMGallery)
                            print("arrMbanner --->",self.arrMbanner)
                            
                            self.createBannerGallery(arrimages: self.arrMbanner)
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                    self.btnviewalltopdeals.isHidden = true
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_networkerror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
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
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        

        /*let parameters = ["emailId": txtusername.text!,
                          "password":txtpassword.text!,
                          "deviceId":struniquedeviceid,
                          "deviceToken":strfcmToken,
                          "deviceType":"I",] as [String : Any]*/
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod8)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /*let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data*/
        
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
                            let arrMtopdelas = dictemp.value(forKey: "productdetails") as? NSArray ?? []
                            self.arrMtopdeals = NSMutableArray(array: arrMtopdelas)
                            print("arrMtopdeals --->",self.arrMtopdeals)
                            
                            if self.arrMtopdeals.count > 0{
                                self.coltopdeals.reloadData()
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                                
                                self.getOrderOnceCartCountAPIMethod()
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
        let size = 60
        let size1 = 60
        var frame = circle.frame
        frame.size.width = CGFloat(size)
        frame.size.height = CGFloat(size1)
        frame.origin.x = backgroundView.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = backgroundView.frame.size.height / 2 - frame.size.height / 2;
        circle.frame = frame
        circle.center = backgroundView.center
        circle.layer.cornerRadius = 30.0
        circle.layer.borderWidth = 1.0
        circle.layer.borderColor=UIColor.white.cgColor
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
extension UIImageView {
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
