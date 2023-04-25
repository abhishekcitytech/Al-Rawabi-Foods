//
//  subscriptionproductdetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 02/11/22.
//

import UIKit
import ImageSlideshow
import SDWebImage
import Alamofire
import Cosmos
import CoreData
import WebKit

class subscriptionproductdetails: BaseViewController,UIScrollViewDelegate,ImageSlideshowDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource, UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var viewbanner: UIView!
    @IBOutlet weak var slidebanner: ImageSlideshow!
    
    @IBOutlet weak var viewsize: UIView!
    @IBOutlet weak var lblselectsize: UILabel!
    @IBOutlet weak var colselectsize: UICollectionView!
    var reuseIdentifier1 = "colcellselectsize"
    
    @IBOutlet weak var viewevent: UIView!
    
    @IBOutlet weak var btnaddonce: UIButton!
    @IBOutlet weak var btnaddtoall: UIButton!
    
    @IBOutlet weak var viewplusminus: UIView!
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var txtplusminus: UITextField!
    @IBOutlet weak var lbladdonce: UILabel!
    @IBOutlet weak var lblproductnametitle: UILabel!
    
    @IBOutlet weak var viewplusminusATA: UIView!
    @IBOutlet weak var btnminusATA: UIButton!
    @IBOutlet weak var btnplusATA: UIButton!
    @IBOutlet weak var txtplusminusATA: UITextField!
    @IBOutlet weak var lbladdtoall: UILabel!
    
    
    @IBOutlet weak var lblor: UILabel!
    @IBOutlet weak var lblsep1: UILabel!
    @IBOutlet weak var lblsep2: UILabel!
    
    @IBOutlet weak var btnaddtowishlisticon: UIButton!
    @IBOutlet weak var btnshareoption: UIButton!
    
    @IBOutlet weak var viewshortdescription: UIView!
    @IBOutlet weak var lblshortdescriptionHeader: UILabel!
    @IBOutlet weak var txtvshortdescription: UITextView!
    @IBOutlet weak var btnSeemoreshortdescription: UIButton!
    
    @IBOutlet weak var viewbenifits: UIView!
    @IBOutlet weak var lblbenifitsHeader: UILabel!
    @IBOutlet weak var txtvbenifits: UITextView!
    @IBOutlet weak var btnSeemorebenifits: UIButton!
    
    @IBOutlet weak var viewnutritionfacts: UIView!
    @IBOutlet weak var lblnutritionfactsHeader: UILabel!
    @IBOutlet weak var txtvnutritionfacts: UITextView!
    @IBOutlet weak var btnSeemorenutritionfacts: UIButton!
    
    
    @IBOutlet weak var viewreviewratings: UIView!
    @IBOutlet weak var viewratingstar: CosmosView!
    @IBOutlet weak var lbltotalratingcount: UILabel!
    @IBOutlet weak var lbltotalcountglobal: UILabel!
    @IBOutlet weak var lbl5star: UILabel!
    @IBOutlet weak var progress5star: UIProgressView!
    @IBOutlet weak var lbl4star: UILabel!
    @IBOutlet weak var progress4star: UIProgressView!
    @IBOutlet weak var lbl3star: UILabel!
    @IBOutlet weak var progress3star: UIProgressView!
    @IBOutlet weak var lbl2star: UILabel!
    @IBOutlet weak var progress2star: UIProgressView!
    @IBOutlet weak var lbl1star: UILabel!
    @IBOutlet weak var progress1star: UIProgressView!
    
    @IBOutlet weak var lblhowareratings: UILabel!
    @IBOutlet weak var lblshareyourthoughts: UILabel!
    
    @IBOutlet weak var btnhowcalculaterating: UIButton!
    @IBAction func presscalculaterating(_ sender: Any) {
    }
    @IBOutlet weak var btnwriteyourreview: UIButton!
    
    @IBOutlet weak var tabvreviewlist: UITableView!
    var reuseIdentifier3 = "tabvcellreview"
    @IBOutlet weak var btnviewallreveiw: UIButton!
    var msgreview = ""
    
    
    @IBOutlet weak var viewrelatedproducts: UIView!
    @IBOutlet weak var lblrelatedproducts: UILabel!
    @IBOutlet weak var colrelatedProducts: UICollectionView!
    var reuseIdentifier5 = "colcellrelatedproduct"
    var msg = ""
    
    var arrMBanners = NSMutableArray()
    var arrMsize = NSMutableArray()
    var arrmreviews = NSMutableArray()
    
    var strSelectedProductID = ""
    
    var dicMProductDetails = NSMutableDictionary()
    var arrMRelatedProducts = NSMutableArray()
    
    var strpageidentifier = ""
    var strselecteddateindex = ""
    var strselecteddateindexdate = ""
    var strselecteddateindexday = ""
    
    var strprdnamefromlist = ""
    var strprdimagefromlist = ""
    var strprdsizefromlist = ""
    var strprdpricefromlist = ""
    
    
    var arrmorderon = NSMutableArray()
    
    
    
    var strShareableProductUrl = ""
    
    
    @IBOutlet weak var lbloutofstock: UILabel!
    
    var strstock = ""
    var strstock_status = ""
    
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
        
        print("strpageidentifier",strpageidentifier)
        print("strselecteddateindex",strselecteddateindex)
        print("strselecteddateindexdate",strselecteddateindexdate)
        print("strselecteddateindexday",strselecteddateindexday)
        
        
        self.getProductDetailsAPIMethod()
        
        self.fetchqtyonceqtyallvalue()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language151")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.viewoverall.isHidden = true
        
        self.setupADDONCEADDTOALLSECTION()
        
        self.scrolloverall.contentSize = CGSize(width: self.viewoverall.bounds.size.width, height: self.viewoverall.bounds.size.height)
        self.scrolloverall.showsVerticalScrollIndicator = false
        
        self.createBannerGallery(arrimages: [])
        self.createselectsize()
        
        
        self.lbloutofstock.layer.borderWidth = 1.0
        self.lbloutofstock.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        self.lbloutofstock.layer.cornerRadius = 16.0
        self.lbloutofstock.layer.masksToBounds = true
        
        btnSeemoreshortdescription.layer.cornerRadius = 14.0
        btnSeemoreshortdescription.layer.borderWidth = 1.0
        btnSeemoreshortdescription.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnSeemoreshortdescription.layer.masksToBounds = true
        
        btnSeemorebenifits.layer.cornerRadius = 14.0
        btnSeemorebenifits.layer.borderWidth = 1.0
        btnSeemorebenifits.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnSeemorebenifits.layer.masksToBounds = true
        
        btnSeemorenutritionfacts.layer.cornerRadius = 14.0
        btnSeemorenutritionfacts.layer.borderWidth = 1.0
        btnSeemorenutritionfacts.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnSeemorenutritionfacts.layer.masksToBounds = true
        
        self.createreviewrating()
        self.createrelatedProducts()
        
        self.fetchDatamodelTable()
        
    }
    
    // MARK: - viewDidLayoutSubviews Method
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
    
    
    //MARK: - press Share Social Share Method
    @IBAction func pressShareOption(_ sender: Any)
    {
        print("dicMProductDetails --->",self.dicMProductDetails)
        let strname = String(format: "%@", self.dicMProductDetails.value(forKey: "productName")as? String ?? "")
        let arrmbanners = self.dicMProductDetails.value(forKey: "media") as? NSArray ?? []
        let strimage1 = String(format: "%@", arrmbanners.object(at: 0) as? String ?? "")
        print("strname",strname)
        print("strimage1",strimage1)
        
        self.createSocialShare(strimagelink: strimage1, strproductname: strname)
    }
    
    func createSocialShare(strimagelink:String,strproductname:String)
    {
        // Setting description
        let firstActivityItem = "Rawabi Foods"
        
        // Setting url
        let secondActivityItem : NSURL = NSURL(string: self.strShareableProductUrl)!
        
        // If you want to use an image
        //let image : UIImage = UIImage(named: strproductname)!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (btnshareoption!)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblselectsize.text = myAppDelegate.changeLanguage(key: "msg_language157")
        
        btnaddonce.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language71")), for: .normal)
        btnaddtoall.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language70")), for: .normal)
        lbladdonce.text = myAppDelegate.changeLanguage(key: "msg_language71")
        lbladdtoall.text = myAppDelegate.changeLanguage(key: "msg_language70")
         
        lblshortdescriptionHeader.text = myAppDelegate.changeLanguage(key: "msg_language158")
        btnSeemoreshortdescription.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language161")), for: .normal)
        
        lblbenifitsHeader.text = myAppDelegate.changeLanguage(key: "msg_language159")
        btnSeemorebenifits.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language161")), for: .normal)
        
        lblnutritionfactsHeader.text = myAppDelegate.changeLanguage(key: "msg_language160")
        btnSeemorenutritionfacts.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language161")), for: .normal)
        
        lblhowareratings.text = myAppDelegate.changeLanguage(key: "msg_language162")
        
        lblshareyourthoughts.text = myAppDelegate.changeLanguage(key: "msg_language163")
        
        btnwriteyourreview.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language165")), for: .normal)
        btnviewallreveiw.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language164")), for: .normal)
        
        lblrelatedproducts.text = myAppDelegate.changeLanguage(key: "msg_language166")
        
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            lblselectsize.textAlignment = .left
            lblshortdescriptionHeader.textAlignment = .left
            lblbenifitsHeader.textAlignment = .left
            lblnutritionfactsHeader.textAlignment = .left
            lblrelatedproducts.textAlignment = .left
            
            btnSeemoreshortdescription.frame = CGRect(x: viewshortdescription.frame.maxX - btnSeemoreshortdescription.frame.size.width - 10, y: btnSeemoreshortdescription.frame.origin.y, width: btnSeemoreshortdescription.frame.size.width, height: btnSeemoreshortdescription.frame.size.height)
            btnSeemorebenifits.frame = CGRect(x: viewbenifits.frame.maxX - btnSeemorebenifits.frame.size.width - 10, y: btnSeemorebenifits.frame.origin.y, width: btnSeemorebenifits.frame.size.width, height: btnSeemorebenifits.frame.size.height)
            btnSeemorenutritionfacts.frame = CGRect(x: viewnutritionfacts.frame.maxX - btnSeemorenutritionfacts.frame.size.width - 10, y: btnSeemorenutritionfacts.frame.origin.y, width: btnSeemorenutritionfacts.frame.size.width, height: btnSeemorenutritionfacts.frame.size.height)
        }
        else
        {
            lblselectsize.textAlignment = .right
            lblshortdescriptionHeader.textAlignment = .right
            lblbenifitsHeader.textAlignment = .right
            lblnutritionfactsHeader.textAlignment = .right
            lblrelatedproducts.textAlignment = .right
            
            btnSeemoreshortdescription.frame = CGRect(x: 10, y: btnSeemoreshortdescription.frame.origin.y, width: btnSeemoreshortdescription.frame.size.width, height: btnSeemoreshortdescription.frame.size.height)
            btnSeemorebenifits.frame = CGRect(x: 10, y: btnSeemorebenifits.frame.origin.y, width: btnSeemorebenifits.frame.size.width, height: btnSeemorebenifits.frame.size.height)
            btnSeemorenutritionfacts.frame = CGRect(x: 10, y: btnSeemorenutritionfacts.frame.origin.y, width: btnSeemorenutritionfacts.frame.size.width, height: btnSeemorenutritionfacts.frame.size.height)
        }
    }
    
    
    //MARK: -  press Add To Wishlist  method
    @IBAction func pressAddtoWishlist(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if btnaddtowishlisticon.tag == 200
        {
            //Add To Wishlist
            /*let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language149"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.postAddtoWishlistAPIMethod()
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)*/
            self.postAddtoWishlistAPIMethod()
        }
        else{
            //Remove From Wishlist
            /*let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language152"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.postRemoveFromWishlistAPIMethod(strSelectedProductID: strSelectedProductID)
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)*/
            
            self.postRemoveFromWishlistAPIMethod(strSelectedProductID: strSelectedProductID)
        }
        
    }
    
    //MARK: - press Write your review method
    @IBAction func presswriteyourreview(_ sender: Any) {
        let ctrl = addreviewpage(nibName: "addreviewpage", bundle: nil)
        ctrl.strproductid = strSelectedProductID
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    @IBAction func pressviewallreview(_ sender: Any) {
        let ctrl = viewallreviews(nibName: "viewallreviews", bundle: nil)
        ctrl.strproductid = strSelectedProductID
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    // MARK: - create Banner Gallery method
    @objc func createBannerGallery(arrimages:NSMutableArray)
    {
        var imageSDWebImageSrc = [SDWebImageSource]()
        
        for x in 0 ..< arrimages.count
        {
            let strimageurl = String(format: "%@", arrimages.object(at: x) as? String ?? "")
            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
            
            let image = SDWebImageSource(urlString: strFinalurl)
            imageSDWebImageSrc.append(image!)
        }
        
        print("imageSDWebImageSrc",imageSDWebImageSrc)
        
        //let localSource = [BundleImageSource(imageString: "productdetail.png"), BundleImageSource(imageString: "productdetail.png"), BundleImageSource(imageString: "productdetail.png"), BundleImageSource(imageString: "productdetail.png"), BundleImageSource(imageString: "productdetail.png")]
        
        //let afNetworkingSource = [AFURLSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        //let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        //let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        //let kingfisherSource = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor(named: "themecolor")!
        pageIndicator.pageIndicatorTintColor = UIColor.gray
        
        slidebanner.pageIndicator = pageIndicator
        slidebanner.slideshowInterval = 5.0
        slidebanner.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slidebanner.contentScaleMode = UIViewContentMode.scaleToFill
        //slideshow.pageIndicator = UIPageControl.withSlideshowColors()
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slidebanner.activityIndicator = DefaultActivityIndicator()
        slidebanner.delegate = self
        
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slidebanner.setImageInputs(imageSDWebImageSrc)
        //slidebanner.setImageInputs(localSource)
        
        slidebanner.backgroundColor = .white
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        viewbanner.addGestureRecognizer(recognizer)
        
    }
    @objc func didTap() {
        let fullScreenController = slidebanner.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    //MARK: - create select size method
    func createselectsize()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colselectsize.frame.size.width / 3.5, height: 80)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colselectsize.collectionViewLayout = layout
        colselectsize.register(UINib(nibName: "colcellselectsize", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colselectsize.showsHorizontalScrollIndicator = false
        colselectsize.showsVerticalScrollIndicator=false
        colselectsize.backgroundColor = .clear
    }
    
    //MARK: -  craete viewreview method
    func createreviewrating()
    {
        btnwriteyourreview.layer.cornerRadius = 20.0
        btnwriteyourreview.layer.borderWidth = 1.0
        btnwriteyourreview.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        btnwriteyourreview.layer.masksToBounds = true
        
        tabvreviewlist.register(UINib(nibName: "tabvcellreview", bundle: nil), forCellReuseIdentifier: reuseIdentifier3)
        tabvreviewlist.separatorStyle = .none
        tabvreviewlist.backgroundView=nil
        tabvreviewlist.backgroundColor=UIColor.clear
        tabvreviewlist.separatorColor=UIColor.clear
        tabvreviewlist.showsVerticalScrollIndicator = false
        
        btnviewallreveiw.layer.cornerRadius = 20.0
        btnviewallreveiw.layer.borderWidth = 1.0
        btnviewallreveiw.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnviewallreveiw.layer.masksToBounds = true
    }
    
    //MARK: - create Related Products method
    func createrelatedProducts()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colrelatedProducts.frame.size.width / 2, height: 316 - 44)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colrelatedProducts.collectionViewLayout = layout
        colrelatedProducts.register(UINib(nibName: "colcellrelatedproduct", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier5)
        colrelatedProducts.showsHorizontalScrollIndicator = false
        colrelatedProducts.showsVerticalScrollIndicator=false
        colrelatedProducts.backgroundColor = .clear
    }
    
    //MARK: - press SEE MORE SHORTDESCRIPTION && BENIFITS && NUTRITIONFACTS  METHOD
    @IBAction func pressSeeMoreShortDescription(_ sender: Any)
    {
    }
    @IBAction func pressSeeMoreBenifits(_ sender: Any)
    {
    }
    @IBAction func pressSeeMoreNutritionFacts(_ sender: Any)
    {
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        _ = UIApplication.shared.delegate as! AppDelegate
        if collectionView == colrelatedProducts
        {
            if arrMRelatedProducts.count == 0 {
                self.colrelatedProducts.setEmptyMessage(msg)
            } else {
                self.colrelatedProducts.restore()
            }
            return arrMRelatedProducts.count
        }
        return arrMsize.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if collectionView == colrelatedProducts
        {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier5, for: indexPath as IndexPath) as! colcellrelatedproduct
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 1.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
            
            let dict = arrMRelatedProducts.object(at: indexPath.row) as! NSDictionary
            
            //let strproductid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            let strname = String(format: "%@", dict.value(forKey: "name") as? String ?? "")
            //let strsku = String(format: "%@", dict.value(forKey: "sku") as? String ?? "")
            let strprice = String(format: "%@", dict.value(forKey: "price") as? String ?? "")
            let strsize = String(format: "%@", dict.value(forKey: "size") as? String ?? "")
            let strbrand = String(format: "%@", dict.value(forKey: "brand") as? String ?? "")
            
            
            /*let arrmedia = dict.value(forKey: "media")as? NSArray ?? []
             let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")*/
            
            let strimageurl = String(format: "%@", dict.value(forKey: "media") as? String ?? "")
            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
            cellA.imgv.contentMode = .scaleAspectFit
            cellA.imgv.imageFromURL(urlString: strFinalurl)
            
            //cellA.imgv.image = UIImage(named: "productplaceholder")
            
            cellA.lblname.text = strname
            cellA.lblbrand.text = strbrand
            
            // if you need to Left to right flow //FIXMESIZE
            let addLTR = "\u{200E}\(strsize)"
            cellA.lblqty.text = addLTR
            
            //let fltprice = Float(strprice)
            //cellA.lblprice.text = String(format: "%@ %.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltprice!)
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
            
            cellA.btnaddonce.isHidden = true
            cellA.btnaddonce.tag = indexPath.row
            cellA.btnaddonce.addTarget(self, action: #selector(pressAddonceRelatedProduct), for: .touchUpInside)
            
            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
            if strbearertoken == ""
            {
                cellA.btnfav.isHidden = true
            }
            else
            {
                let stris_addedwishlist = String(format: "%@", dict.value(forKey: "is_addedwishlist") as? String ?? "")
                print("stris_addedwishlist",stris_addedwishlist)
                if stris_addedwishlist == "True"
                {
                    cellA.btnfav.setImage(UIImage(named: "favselected"), for: .normal)
                }
                else{
                    cellA.btnfav.setImage(UIImage(named: "fav1"), for: .normal)
                }
                cellA.btnfav.isHidden = false
            }
            
            // Set up cell
            return cellA
        }
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellselectsize
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let dictemp = arrMsize.object(at: indexPath.row)as? NSDictionary
        //let strid  = String(format: "%@", dictemp?.value(forKey: "id")as? String ?? "")
        let strsize  = String(format: "%@", dictemp?.value(forKey: "size")as? String ?? "")
        let strprice  = String(format: "%@", dictemp?.value(forKey: "price")as? String ?? "")
        //let strselected  = String(format: "%@", dictemp?.value(forKey: "selected")as? String ?? "")
        
        cellA.lblsize.text = strsize
        
        let fltprice = Float(strprice)
        cellA.lblrpcie.text = String(format: "%@ %.2f\n%@", myAppDelegate.changeLanguage(key: "msg_language481"),fltprice!,myAppDelegate.changeLanguage(key: "msg_language474"))
        cellA.lblrpcie.textColor = UIColor(named: "darkgreencolor")!
        
        cellA.viewcell.layer.cornerRadius = 6.0
        cellA.viewcell.layer.borderWidth = 2.0
        cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cellA.viewcell.layer.masksToBounds = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == colrelatedProducts
        {
            return CGSize(width: colrelatedProducts.frame.size.width / 2.3 , height: 316 - 44)
        }
        
        return CGSize(width: colselectsize.frame.size.width / 3.5 , height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if collectionView == colrelatedProducts
        {
            return UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        }
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == colrelatedProducts
        {
            let dict = arrMRelatedProducts.object(at: indexPath.row) as! NSDictionary
            let strproductid = String(format: "%@", dict.value(forKey: "id") as! CVarArg)
            self.strSelectedProductID = strproductid
            
            self.getProductDetailsAPIMethod()
            
            self.fetchqtyonceqtyallvalue()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
    //MARK: - press ADD TO CART RELATED PROCUCT GRID
    @objc func pressAddonceRelatedProduct(sender:UIButton)
    {
        
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrmreviews.count == 0 {
            self.tabvreviewlist.setEmptyMessage(msgreview)
        } else {
            self.tabvreviewlist.restore()
        }
        return arrmreviews.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3, for: indexPath) as! tabvcellreview
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dictmep = arrmreviews.object(at: indexPath.section)as! NSDictionary
        let strnickname = String(format: "%@", dictmep.value(forKey: "nickname")as? String ?? "")
        let strtitle = String(format: "%@", dictmep.value(forKey: "title")as? String ?? "")
        let strdetail = String(format: "%@", dictmep.value(forKey: "detail")as? String ?? "")
        let strrating = String(format: "%@", dictmep.value(forKey: "rating")as! CVarArg)
        
        if strrating == "null" || strrating == ""
        {
            cell.viewrating.isHidden = true
        }else{
            cell.viewrating.isHidden = false
        }
        
        cell.imgvuser.image = UIImage(named: "graycircle")
        cell.lblname.text = strnickname
        cell.lbltime.text = strtitle
        if strrating.contains("20"){
            cell.viewrating.rating = 1
        }
        else if strrating.contains("40"){
            cell.viewrating.rating = 2
        }
        else if strrating.contains("60"){
            cell.viewrating.rating = 3
        }
        else if strrating.contains("80"){
            cell.viewrating.rating = 4
        }
        else if strrating.contains("100"){
            cell.viewrating.rating = 5
        }
        cell.txtvdesc.text = strdetail
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    
    //MARK: - get Product Details API method
    func getProductDetailsAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?productId=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod11,strSelectedProductID,strLangCode)
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
                    self.viewoverall.isHidden = false
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.viewoverall.isHidden = false
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
                            let dicproductdata = json.value(forKey: "productData") as? NSDictionary
                            self.dicMProductDetails = dicproductdata!.mutableCopy() as! NSMutableDictionary
                            print("dicMProductDetails --->",self.dicMProductDetails)
                            
                            
                            
                            //FIXMESTOCK
                            self.strstock = String(format: "%@", self.dicMProductDetails.value(forKey: "stock") as! CVarArg)
                            self.strstock_status = String(format: "%@", self.dicMProductDetails.value(forKey: "stock_status") as? String ?? "")
                            print("self.strstock",self.strstock)
                            print("self.strstock_status",self.strstock_status)
                            
                            
                            //SET PRODUCT NAME TITLE
                            self.title = String(format: "%@", self.dicMProductDetails.value(forKey: "productName")as? String ?? "")
                            self.lblproductnametitle.text = String(format: "%@", self.dicMProductDetails.value(forKey: "productName")as? String ?? "")
                            
                            //SET PRODUCT CAROUSAL BANNER IMAGE GALLERY
                            let arrmbanners = self.dicMProductDetails.value(forKey: "media") as? NSArray ?? []
                            self.arrMBanners = NSMutableArray(array: arrmbanners)
                            
                            if self.arrMBanners.count > 0 {
                                self.createBannerGallery(arrimages: self.arrMBanners)
                            }
                            
                            //SET PRODUCT TYPE SIZE VARIANTS
                            let strproducttype = String(format: "%@", self.dicMProductDetails.value(forKey: "productType")as? String ?? "")
                            if strproducttype == "configurable"
                            {
                                let arrmlinkedproducts = self.dicMProductDetails.value(forKey: "linkedProducts") as? NSArray ?? []
                                
                                for x in 0 ..< arrmlinkedproducts.count
                                {
                                    let dic = arrmlinkedproducts.object(at: x)as? NSDictionary
                                    let strid = String(format: "%@", dic?.value(forKey: "id")as! CVarArg)
                                    let strsize = String(format: "%@", dic?.value(forKey: "size")as? String ?? "")
                                    let strprice = String(format: "%@", dic?.value(forKey: "price")as? String ?? "")
                                    
                                    let dictemp = NSMutableDictionary()
                                    dictemp.setValue(strid, forKey: "id")
                                    dictemp.setValue(strsize, forKey: "size")
                                    dictemp.setValue(strprice, forKey: "price")
                                    dictemp.setValue("0", forKey: "selected")
                                    self.arrMsize.add(dictemp)
                                }
                                //self.colselectsize.reloadData()
                            }
                            else
                            {
                                let strid = String(format: "%@", self.dicMProductDetails.value(forKey: "productId")as! CVarArg)
                                let strsize = String(format: "%@", self.dicMProductDetails.value(forKey: "size")as? String ?? "")
                                let strprice = String(format: "%@", self.dicMProductDetails.value(forKey: "price")as? String ?? "")
                                
                                let dictemp = NSMutableDictionary()
                                dictemp.setValue(strid, forKey: "id")
                                dictemp.setValue(strsize, forKey: "size")
                                dictemp.setValue(strprice, forKey: "price")
                                dictemp.setValue("0", forKey: "selected")
                                self.arrMsize.add(dictemp)
                                
                                //self.colselectsize.reloadData()
                            }
                            
                            //SET ADD OR ALREADY ADDED INTO WISHLIST
                            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                            if strbearertoken != ""{
                                let stris_addedwishlist = String(format: "%@", self.dicMProductDetails.value(forKey: "is_addedwishlist") as? String ?? "")
                                
                                print("stris_addedwishlist",stris_addedwishlist)
                                if stris_addedwishlist == "True"
                                {
                                    self.btnaddtowishlisticon.tag = 100
                                    self.btnaddtowishlisticon.setImage(UIImage(named: "favselected"), for: .normal)
                                    
                                }
                                else{
                                    self.btnaddtowishlisticon.tag = 200
                                    self.btnaddtowishlisticon.setImage(UIImage(named: "fav1"), for: .normal)
                                    
                                }
                            }else{
                                self.btnaddtowishlisticon.tag = 200
                                self.btnaddtowishlisticon.setImage(UIImage(named: "fav1"), for: .normal)
                                
                            }
                            
                            //SET Remivew LIST
                            let arrmreviewlist = self.dicMProductDetails.value(forKey: "reviews") as? NSArray ?? []
                            self.arrmreviews = NSMutableArray(array: arrmreviewlist)
                            if self.arrmreviews.count == 0{
                                self.msgreview = myAppDelegate.changeLanguage(key: "msg_language155")
                                self.btnviewallreveiw.isHidden = true
                            }
                            self.tabvreviewlist.reloadData()
                            
                            //GET REVIEW COUNTS SECTION
                            let strTotalVotesCount = self.dicMProductDetails.value(forKey: "total_votes") as! CVarArg
                            let dicvotecounts = self.dicMProductDetails.value(forKey: "count_rating")as! NSDictionary
                            let strZEROCOUNT = dicvotecounts.value(forKey: "zero") as! CVarArg
                            let strONECOUNT = dicvotecounts.value(forKey: "one") as! CVarArg
                            let strTWOCOUNT = dicvotecounts.value(forKey: "two") as! CVarArg
                            let strTHREECOUNT = dicvotecounts.value(forKey: "three") as! CVarArg
                            let strFOURCOUNT = dicvotecounts.value(forKey: "four") as! CVarArg
                            let strFIVECOUNT = dicvotecounts.value(forKey: "five") as! CVarArg
                            
                            print("strTotalVotesCount",strTotalVotesCount)
                            
                            print("strZEROCOUNT",strZEROCOUNT)
                            print("strONECOUNT",strONECOUNT)
                            print("strTWOCOUNT",strTWOCOUNT)
                            print("strTHREECOUNT",strTHREECOUNT)
                            print("strFOURCOUNT",strFOURCOUNT)
                            print("strFIVECOUNT",strFIVECOUNT)
                            
                            var fltgivenreviewcount = 0.0
                            let fltfullcount = Float(String(format: "%@", strTotalVotesCount))
                            print("fltfullcount",fltfullcount)
                            
                            let flt0star = Float(String(format: "%@", strZEROCOUNT))
                            let flt1star = Float(String(format: "%@", strONECOUNT))
                            let flt2star = Float(String(format: "%@", strTWOCOUNT))
                            let flt3star = Float(String(format: "%@", strTHREECOUNT))
                            let flt4star = Float(String(format: "%@", strFOURCOUNT))
                            let flt5star = Float(String(format: "%@", strFIVECOUNT))
                            
                            if flt1star! > 0{
                                fltgivenreviewcount = fltgivenreviewcount + 1
                            }
                            if flt2star! > 0{
                                fltgivenreviewcount = fltgivenreviewcount + 1
                            }
                            if flt3star! > 0{
                                fltgivenreviewcount = fltgivenreviewcount + 1
                            }
                            if flt4star! > 0{
                                fltgivenreviewcount = fltgivenreviewcount + 1
                            }
                            if flt5star! > 0{
                                fltgivenreviewcount = fltgivenreviewcount + 1
                            }
                            
                            print("fltgivenreviewcount",fltgivenreviewcount)
                            
                            
                            let fltmeanscore0 = flt0star! / 5 * 100
                            let fltmeanscore1 = flt1star! / 5 * 100
                            let fltmeanscore2 = flt2star! / 5 * 100
                            let fltmeanscore3 = flt3star! / 5 * 100
                            let fltmeanscore4 = flt4star! / 5 * 100
                            let fltmeanscore5 = flt5star! / 5 * 100
                            
                            let fltTotalmeanscore = Float(fltmeanscore1 + fltmeanscore2 + fltmeanscore3 + fltmeanscore4 + fltmeanscore5)
                            print("fltTotalmeanscore",fltTotalmeanscore)
                            
                            let fltavgratingpercentage = fltTotalmeanscore / Float(fltgivenreviewcount)
                            let fltavgratingpercentageTwodecimal = fltavgratingpercentage / 10
                            print("fltavgratingpercentageTwodecimal",fltavgratingpercentageTwodecimal)
                            
                            if fltTotalmeanscore != 0.0{
                                let doubleratingvalue = Double(fltavgratingpercentageTwodecimal)
                                print("doubleratingvalue",doubleratingvalue)
                                
                                self.viewratingstar.rating = doubleratingvalue
                                self.lbltotalratingcount.text = String(format: "%.1f %@ 5", doubleratingvalue,myAppDelegate.changeLanguage(key: "msg_language329"))
                                self.lbltotalcountglobal.text = String(format: "%@ %@", strTotalVotesCount,myAppDelegate.changeLanguage(key: "msg_language156"))
                                
                                self.progress1star.progress = flt1star! / 100
                                self.progress2star.progress = flt2star! / 100
                                self.progress3star.progress = flt3star! / 100
                                self.progress4star.progress = flt4star! / 100
                                self.progress5star.progress = flt5star! / 100
                            }
                            else{
                                self.viewratingstar.rating = 0.0
                                self.lbltotalratingcount.text = String(format: "%.1f %@ 5", 0.0,myAppDelegate.changeLanguage(key: "msg_language329"))
                                self.lbltotalcountglobal.text = String(format: "%@ %@", strTotalVotesCount,myAppDelegate.changeLanguage(key: "msg_language156"))
                                
                                self.progress1star.progress = 0
                                self.progress2star.progress = 0
                                self.progress3star.progress = 0
                                self.progress4star.progress = 0
                                self.progress5star.progress = 0
                            }
                            
                            
                            
                            //SET RELATED PRODUCTS
                            let arrmrelatedprod = self.dicMProductDetails.value(forKey: "relatedProducts") as? NSArray ?? []
                            self.arrMRelatedProducts = NSMutableArray(array: arrmrelatedprod)
                            if self.arrMRelatedProducts.count == 0{
                                self.msg = "No products found!"
                            }
                            self.colrelatedProducts.reloadData()
                            
                            
                            //SET SHORT DESCRIPTION
                            let strshortdesc = String(format: "%@", self.dicMProductDetails.value(forKey: "shortDescription")as? String ?? "")
                            //self.lblshortdescription.attributedText = strshortdesc.htmlToAttributedString
                             
                            
                            //SET BENIFITES DESCRIPTION
                            let strbenefits = String(format: "%@", self.dicMProductDetails.value(forKey: "benefits")as? String ?? "")
                            //self.txtvbenifits.attributedText = strbenefits.htmlToAttributedString
                             
                            //SET NUTRITION FACTS DESCRIPTION
                            let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                            
                            var webV = WKWebView()
                            if webV.tag == 1001{
                                webV.tag = 0
                                webV.removeFromSuperview()
                            }
                            
                            if (strLangCode == "en")
                            {
                                self.txtvshortdescription.attributedText = strshortdesc.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "left")
                                
                                self.txtvbenifits.attributedText = strbenefits.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "left")
                                
                                let str11 = "<p font size='15' color= 'black' dir=\"ltr\">"
                                print("str11",str11)
                                let str22 = "</p>"

                                let strnutrition_facts = String(format: "%@%@%@", str11,self.dicMProductDetails.value(forKey: "nutrition_facts")as? String ?? "",str22)
                                print("strnutrition_facts",strnutrition_facts)
                                
                                //self.txtvnutritionfacts.attributedText = strnutrition_facts.htmlToAttributedString
                                //self.txtvnutritionfacts.attributedText = strnutrition_facts.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "center")
                                
                                self.txtvnutritionfacts.backgroundColor = .clear
                                webV = WKWebView(frame: CGRectMake(0, 0, self.txtvnutritionfacts.bounds.width, self.txtvnutritionfacts.bounds.height))
                                webV.loadHTMLString(strnutrition_facts, baseURL: nil)
                                webV.uiDelegate = self;
                                webV.isOpaque = false
                                webV.backgroundColor = .clear
                                webV.scrollView.isScrollEnabled = true
                                webV.scrollView.bounces = false
                                webV.allowsBackForwardNavigationGestures = false
                                webV.contentMode = .scaleToFill
                                webV.tag = 1001
                                webV.navigationDelegate = self
                                webV.bringSubviewToFront(self.viewnutritionfacts)
                                self.txtvnutritionfacts.addSubview(webV)
                            }
                            else
                            {
                                self.txtvshortdescription.attributedText = strshortdesc.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "right")
                                
                                self.txtvbenifits.attributedText = strbenefits.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "right")
                                
                                let str11 = "<p dir=\"rtl\">"
                                print("str11",str11)
                                let str22 = "</p>"
                                
                                let strnutrition_facts = String(format: "%@%@%@",str11, self.dicMProductDetails.value(forKey: "nutrition_facts")as? String ?? "",str22)
                                print("strnutrition_facts",strnutrition_facts)
                                
                                //self.txtvnutritionfacts.attributedText = strnutrition_facts.htmlToAttributedString
                                //self.txtvnutritionfacts.attributedText = strnutrition_facts.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "center")
                                
                                self.txtvnutritionfacts.backgroundColor = .clear
                                webV = WKWebView(frame: CGRectMake(0, 0, self.txtvnutritionfacts.bounds.width, self.txtvnutritionfacts.bounds.height))
                                webV.loadHTMLString(strnutrition_facts, baseURL: nil)
                                webV.uiDelegate = self;
                                webV.isOpaque = false
                                webV.backgroundColor = .clear
                                webV.scrollView.isScrollEnabled = true
                                webV.scrollView.bounces = false
                                webV.allowsBackForwardNavigationGestures = false
                                webV.contentMode = .scaleToFill
                                webV.tag = 1001
                                webV.navigationDelegate = self
                                webV.bringSubviewToFront(self.viewnutritionfacts)
                                self.txtvnutritionfacts.addSubview(webV)
                            }
                            
                            
                            //SET FULL DESCRIPTION DESCRIPTION
                            let strdescription = String(format: "%@", self.dicMProductDetails.value(forKey: "description")as? String ?? "")
                            print("strdescription>>>>>>>>>>",strdescription)
                            
                            
                            print("strbenefits>>>>>>>>>>",strbenefits)
                            if strbenefits.count == 0
                            {
                                //BENIFIT SECTION WILL HIDE
                                self.viewbenifits.isHidden = true
                                self.viewnutritionfacts.frame = CGRect(x: self.viewnutritionfacts.frame.origin.x, y: self.viewbenifits.frame.origin.y, width: self.viewnutritionfacts.frame.size.width, height: self.viewnutritionfacts.frame.size.height)
                                self.viewreviewratings.frame = CGRect(x: self.viewreviewratings.frame.origin.x, y: self.viewnutritionfacts.frame.maxY, width: self.viewreviewratings.frame.size.width, height: self.viewreviewratings.frame.size.height)
                                self.viewrelatedproducts.frame = CGRect(x: self.viewrelatedproducts.frame.origin.x, y: self.viewreviewratings.frame.maxY, width: self.viewrelatedproducts.frame.size.width, height: self.viewrelatedproducts.frame.size.height)
                               
                            }
                            else
                            {
                                //BENIFIT SECTION WILL SHOW
                                self.viewbenifits.isHidden = false
                                self.viewbenifits.frame = CGRect(x: self.viewbenifits.frame.origin.x, y: self.viewshortdescription.frame.maxY, width: self.viewbenifits.frame.size.width, height: self.viewbenifits.frame.size.height)
                                self.viewnutritionfacts.frame = CGRect(x: self.viewnutritionfacts.frame.origin.x, y: self.viewbenifits.frame.maxY, width: self.viewnutritionfacts.frame.size.width, height: self.viewnutritionfacts.frame.size.height)
                                self.viewreviewratings.frame = CGRect(x: self.viewreviewratings.frame.origin.x, y: self.viewnutritionfacts.frame.maxY, width: self.viewreviewratings.frame.size.width, height: self.viewreviewratings.frame.size.height)
                                self.viewrelatedproducts.frame = CGRect(x: self.viewrelatedproducts.frame.origin.x, y: self.viewreviewratings.frame.maxY, width: self.viewrelatedproducts.frame.size.width, height: self.viewrelatedproducts.frame.size.height)
                                
                            }
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        self.fetchqtyonceqtyallvalue()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.viewoverall.isHidden = false
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Add to Wishlist Product Details API method
    func postAddtoWishlistAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["productid": strSelectedProductID
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
                        
                        self.getProductDetailsAPIMethod()
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
                        
                        if strsuccess == true
                        {
                            self.getProductDetailsAPIMethod()
                            
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
    
    //MARK: - setup ADDONCE AND ADDTOALL SECTION BUTTONS
    func setupADDONCEADDTOALLSECTION()
    {
        btnaddonce.layer.cornerRadius = 14.0
        btnaddonce.layer.masksToBounds = true
        
        btnaddtoall.setTitleColor(UIColor(named: "orangecolor")!, for: .normal)
        btnaddtoall.layer.cornerRadius = 14.0
        btnaddtoall.layer.borderWidth = 1.0
        btnaddtoall.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        btnaddtoall.layer.masksToBounds = true
        
        
        //CELL PLUS MINUS
        viewplusminus.layer.cornerRadius = 14.0
        viewplusminus.layer.borderWidth = 1.0
        viewplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        viewplusminus.layer.masksToBounds = true
        
        txtplusminus.layer.cornerRadius = 1.0
        txtplusminus.layer.borderWidth = 1.0
        txtplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        txtplusminus.layer.masksToBounds = true
        
        
        //CELL PLUS MINUS ALL
        viewplusminusATA.layer.cornerRadius = 14.0
        viewplusminusATA.layer.borderWidth = 1.0
        viewplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        viewplusminusATA.layer.masksToBounds = true
        
        txtplusminusATA.layer.cornerRadius = 1.0
        txtplusminusATA.layer.borderWidth = 1.0
        txtplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
        txtplusminusATA.layer.masksToBounds = true
        
    }
    
    //MARK: - fetch qtyonce and qtyall value from DAILY / WEEKLY / MONTHLY Product Table
    func fetchqtyonceqtyallvalue()
    {
        if strpageidentifier == "100"
        {
            //DAILY
            
            //-----Fetch qtyonce && qtyall for each product id from Dailyproduct Table ----//
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
            fetchData.predicate = NSPredicate(format: "date == %@ && productid == %@",self.strselecteddateindexdate,strSelectedProductID)
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
                            btnaddonce.isHidden = true
                            viewplusminus.isHidden = false
                            txtplusminus.text = qtyoo as! String
                        }else{
                            btnaddonce.isHidden = false
                            viewplusminus.isHidden = true
                        }
                        
                        if qtyaa as! String != "0"{
                            btnaddtoall.isHidden = true
                            viewplusminusATA.isHidden = false
                            txtplusminusATA.text = qtyaa as! String
                        }else{
                            btnaddtoall.isHidden = false
                            viewplusminusATA.isHidden = true
                        }
                    }
                }
                else{
                    btnaddonce.isHidden = false
                    btnaddtoall.isHidden = false
                    viewplusminus.isHidden = true
                    viewplusminusATA.isHidden = true
                }
            }catch {
                print("err")
            }
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            
            //-----Fetch qtyonce && qtyall for each product id from Weeklyproduct Table ----//
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData.predicate = NSPredicate(format: "date == %@ && productid == %@",self.strselecteddateindexdate,strSelectedProductID)
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
                            btnaddonce.isHidden = true
                            viewplusminus.isHidden = false
                            txtplusminus.text = qtyoo as! String
                        }else{
                            btnaddonce.isHidden = false
                            viewplusminus.isHidden = true
                        }
                        
                        if qtyaa as! String != "0"{
                            btnaddtoall.isHidden = true
                            viewplusminusATA.isHidden = false
                            txtplusminusATA.text = qtyaa as! String
                        }else{
                            btnaddtoall.isHidden = false
                            viewplusminusATA.isHidden = true
                        }
                    }
                }
                else{
                    btnaddonce.isHidden = false
                    btnaddtoall.isHidden = false
                    viewplusminus.isHidden = true
                    viewplusminusATA.isHidden = true
                }
            }catch {
                print("err")
            }
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            
            //-----Fetch qtyonce && qtyall for each product id from Monthlyproduct Table ----//
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
            fetchData.predicate = NSPredicate(format: "date == %@ && productid == %@",self.strselecteddateindexdate,strSelectedProductID)
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
                            btnaddonce.isHidden = true
                            viewplusminus.isHidden = false
                            txtplusminus.text = qtyoo as! String
                        }else{
                            btnaddonce.isHidden = false
                            viewplusminus.isHidden = true
                        }
                        
                        if qtyaa as! String != "0"{
                            btnaddtoall.isHidden = true
                            viewplusminusATA.isHidden = false
                            txtplusminusATA.text = qtyaa as! String
                        }else{
                            btnaddtoall.isHidden = false
                            viewplusminusATA.isHidden = true
                        }
                    }
                }
                else{
                    btnaddonce.isHidden = false
                    btnaddtoall.isHidden = false
                    viewplusminus.isHidden = true
                    viewplusminusATA.isHidden = true
                }
            }catch {
                print("err")
            }
        }
        
        
        //FIXMESANDIPAN
        //btnaddonce.isHidden = true
        //btnaddtoall.isHidden = true
        //viewplusminus.isHidden = true
        //viewplusminusATA.isHidden = true
        
        print("strstock",strstock)
        
        if strstock != ""
        {
            if strstock == "0"{
                //Out of stock
                self.lbloutofstock.isHidden = false
                self.lbloutofstock.text = strstock_status
                
                btnaddonce.isHidden = true
                btnaddtoall.isHidden = true
                viewplusminus.isHidden = true
                viewplusminusATA.isHidden = true
                
            }else{
                //in stock
                self.lbloutofstock.isHidden = true
            }
        }
        
        
    }
    
    //MARK: - press ADDONCE method
    @IBAction func pressaddonce(_ sender: Any)
    {
        print("strSelectedProductID",strSelectedProductID)
        print("strprdnamefromlist",strprdnamefromlist)
        print("strprdimagefromlist",strprdimagefromlist)
        print("strprdsizefromlist",strprdsizefromlist)
        print("strprdpricefromlist",strprdpricefromlist)
        
        if strpageidentifier == "100"
        {
            //DAILY
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                                
                                var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
                                print("fltsubtotalprice",fltsubtotalprice as Any)
                                data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                            }
                            else
                            {
                                //qtyall not available add new  add once qty
                                
                                var intsubtotalprice = Float(strprdpricefromlist)! * 1
                                print("intsubtotalprice",intsubtotalprice)
                                
                                //------------------- INSERT INTO Dailyproduct TABLE ---------------- //
                                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                                let manageContent = appDelegate.persistentContainer.viewContext
                                let userEntity = NSEntityDescription.entity(forEntityName: "Dailyproduct", in: manageContent)!
                                let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                                users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                                users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                                users.setValue(strSelectedProductID, forKeyPath: "productid")
                                users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                                users.setValue(strprdnamefromlist, forKeyPath: "productname")
                                users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                                users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
                    
                    var intsubtotalprice = Float(strprdpricefromlist)! * 1
                    print("intsubtotalprice",intsubtotalprice)
                    
                    //------------------- INSERT INTO Dailyproduct TABLE ---------------- //
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent = appDelegate.persistentContainer.viewContext
                    let userEntity = NSEntityDescription.entity(forEntityName: "Dailyproduct", in: manageContent)!
                    let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                    users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                    users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                    users.setValue(strSelectedProductID, forKeyPath: "productid")
                    users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                    users.setValue(strprdnamefromlist, forKeyPath: "productname")
                    users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                    users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                                
                                var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
                                print("fltsubtotalprice",fltsubtotalprice as Any)
                                data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                            }
                            else
                            {
                                //qtyall not available add new  add once qty
                                
                                var intsubtotalprice = Float(strprdpricefromlist)! * 1
                                print("intsubtotalprice",intsubtotalprice)
                                
                                //------------------- INSERT INTO Weeklyproduct TABLE ---------------- //
                                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                                let manageContent = appDelegate.persistentContainer.viewContext
                                let userEntity = NSEntityDescription.entity(forEntityName: "Weeklyproduct", in: manageContent)!
                                let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                                users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                                users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                                users.setValue(strSelectedProductID, forKeyPath: "productid")
                                users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                                users.setValue(strprdnamefromlist, forKeyPath: "productname")
                                users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                                users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
                    
                    var intsubtotalprice = Float(strprdpricefromlist)! * 1
                    print("intsubtotalprice",intsubtotalprice)
                    
                    //------------------- INSERT INTO Weeklyproduct TABLE ---------------- //
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent = appDelegate.persistentContainer.viewContext
                    let userEntity = NSEntityDescription.entity(forEntityName: "Weeklyproduct", in: manageContent)!
                    let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                    users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                    users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                    users.setValue(strSelectedProductID, forKeyPath: "productid")
                    users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                    users.setValue(strprdnamefromlist, forKeyPath: "productname")
                    users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                    users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                                
                                var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
                                print("fltsubtotalprice",fltsubtotalprice as Any)
                                data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                            }
                            else
                            {
                                //qtyall not available add new  add once qty
                                
                                var intsubtotalprice = Float(strprdpricefromlist)! * 1
                                print("intsubtotalprice",intsubtotalprice)
                                
                                //------------------- INSERT INTO Monthlyproduct TABLE ---------------- //
                                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                                let manageContent = appDelegate.persistentContainer.viewContext
                                let userEntity = NSEntityDescription.entity(forEntityName: "Monthlyproduct", in: manageContent)!
                                let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                                users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                                users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                                users.setValue(strSelectedProductID, forKeyPath: "productid")
                                users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                                users.setValue(strprdnamefromlist, forKeyPath: "productname")
                                users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                                users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
                    
                    var intsubtotalprice = Float(strprdpricefromlist)! * 1
                    print("intsubtotalprice",intsubtotalprice)
                    
                    //------------------- INSERT INTO Monthlyproduct TABLE ---------------- //
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent = appDelegate.persistentContainer.viewContext
                    let userEntity = NSEntityDescription.entity(forEntityName: "Monthlyproduct", in: manageContent)!
                    let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                    users.setValue(self.strselecteddateindexdate, forKeyPath: "date")
                    users.setValue(self.strselecteddateindexday, forKeyPath: "day")
                    users.setValue(strSelectedProductID, forKeyPath: "productid")
                    users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                    users.setValue(strprdnamefromlist, forKeyPath: "productname")
                    users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                    users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
        }
        
        self.fetchqtyonceqtyallvalue()
    }
    //MARK: - press ADDTOALL method
    @IBAction func pressaddtoall(_ sender: Any)
    {
        print("strSelectedProductID",strSelectedProductID)
        print("strprdnamefromlist",strprdnamefromlist)
        print("strprdimagefromlist",strprdimagefromlist)
        print("strprdsizefromlist",strprdsizefromlist)
        print("strprdpricefromlist",strprdpricefromlist)
        
        if strpageidentifier == "100"
        {
            //DAILY
            
            var intsubtotalprice = Float(strprdpricefromlist)! * 1
            print("intsubtotalprice",intsubtotalprice)
            
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICI DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                
                                var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
                        
                        //------------------- INSERT INTO Dailyproduct TABLE ---------------- //
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                        let manageContent = appDelegate.persistentContainer.viewContext
                        let userEntity = NSEntityDescription.entity(forEntityName: "Dailyproduct", in: manageContent)!
                        let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                        users.setValue(strdate, forKeyPath: "date")
                        users.setValue(strday, forKeyPath: "day")
                        users.setValue(strSelectedProductID, forKeyPath: "productid")
                        users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                        users.setValue(strprdnamefromlist, forKeyPath: "productname")
                        users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                        users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            
            var intsubtotalprice = Float(strprdpricefromlist)! * 1
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
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                
                                var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
                        users.setValue(strSelectedProductID, forKeyPath: "productid")
                        users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                        users.setValue(strprdnamefromlist, forKeyPath: "productname")
                        users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                        users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            
            var intsubtotalprice = Float(strprdpricefromlist)! * 1
            print("intsubtotalprice",intsubtotalprice)
            
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICI DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                
                                var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
                        
                        //------------------- INSERT INTO Monthlyproduct TABLE ---------------- //
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                        let manageContent = appDelegate.persistentContainer.viewContext
                        let userEntity = NSEntityDescription.entity(forEntityName: "Monthlyproduct", in: manageContent)!
                        let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                        users.setValue(strdate, forKeyPath: "date")
                        users.setValue(strday, forKeyPath: "day")
                        users.setValue(strSelectedProductID, forKeyPath: "productid")
                        users.setValue(strprdimagefromlist, forKeyPath: "productimage")
                        users.setValue(strprdnamefromlist, forKeyPath: "productname")
                        users.setValue(strprdpricefromlist, forKeyPath: "productprice")
                        users.setValue(strprdsizefromlist, forKeyPath: "productsize")
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
        }
        self.fetchqtyonceqtyallvalue()
    }
    
    //MARK: - press ADDONCE PLUS && MINUS method
    @IBAction func pressplus(_ sender: Any)
    {
        print("strSelectedProductID",strSelectedProductID)
        print("strprdnamefromlist",strprdnamefromlist)
        print("strprdimagefromlist",strprdimagefromlist)
        print("strprdsizefromlist",strprdsizefromlist)
        print("strprdpricefromlist",strprdpricefromlist)
        
        if strpageidentifier == "100"
        {
            //DAILY
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                            
                            var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                            
                            var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                            
                            var fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        self.fetchqtyonceqtyallvalue()
    }
    @IBAction func pressminus(_ sender: Any)
    {
        print("strSelectedProductID",strSelectedProductID)
        print("strprdnamefromlist",strprdnamefromlist)
        print("strprdimagefromlist",strprdimagefromlist)
        print("strprdsizefromlist",strprdsizefromlist)
        print("strprdpricefromlist",strprdpricefromlist)
        
        if strpageidentifier == "100"
        {
            //DAILY
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                                
                                let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        else if strpageidentifier == "200"
        {
            //WEEKLY
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                                
                                let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        else if strpageidentifier == "300"
        {
            //MONTHLY
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
            fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,self.strselecteddateindexdate)
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
                                
                                let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        self.fetchqtyonceqtyallvalue()
    }
    
    //MARK: - press ADDTOALL PLUS && MINUS method
    @IBAction func pressplusATA(_ sender: Any)
    {
        print("strSelectedProductID",strSelectedProductID)
        print("strprdnamefromlist",strprdnamefromlist)
        print("strprdimagefromlist",strprdimagefromlist)
        print("strprdsizefromlist",strprdsizefromlist)
        print("strprdpricefromlist",strprdpricefromlist)
        
        if strpageidentifier == "100"
        {
            //DAILY
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                
                                let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                
                                let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                
                                let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        self.fetchqtyonceqtyallvalue()
    }
    @IBAction func pressminusATA(_ sender: Any)
    {
        print("strSelectedProductID",strSelectedProductID)
        print("strprdnamefromlist",strprdnamefromlist)
        print("strprdimagefromlist",strprdimagefromlist)
        print("strprdsizefromlist",strprdsizefromlist)
        print("strprdpricefromlist",strprdpricefromlist)
        
        if strpageidentifier == "100"
        {
            //DAILY
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                    
                                    let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                    
                                    let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            for x in 0 ..< arrmorderon.count
            {
                let dict = self.arrmorderon.object(at: x)as? NSMutableDictionary
                let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
                let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
                
                //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
                fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strSelectedProductID,strdate)
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
                                
                                let updatedqtyall = intqtyall! - 1
                                
                                if updatedqtyall <= 0
                                {
                                    if intqtyonce! <= 0{
                                        //Will remove that product from dailyproduct TABLE
                                        manageContent1.delete(data1)
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
                                    
                                    let fltsubtotalprice = Float(strprdpricefromlist)! * Float(inttotalqty)
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
        }
        self.fetchqtyonceqtyallvalue()
    }
    
    
    
    //MARK: - Fetch Model data exist or not
    func fetchDatamodelTable()
    {
        if self.arrmorderon.count > 0 {
            self.arrmorderon.removeAllObjects()
        }
        
        if strpageidentifier == "100"
        {
            //DAILY
            
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
            fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"1")
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
            print("self.arrmorderon",self.arrmorderon)
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            
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
            print("self.arrmorderon",self.arrmorderon)
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
            fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && selected == %@", strcustomerid,"3","1")
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
            print("self.arrmorderon",self.arrmorderon)
        }
    }
    
    
    //MARK: - WWEBVIEW DELEGATE FOR NUTRITIONFACTS
    let isAllowZoom: Bool = false
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if isAllowZoom {
                let javascript = "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=10.0, user-scalable=yes');document.getElementsByTagName('head')[0].appendChild(meta);"
                webView.evaluateJavaScript(javascript, completionHandler: nil)
            } else {
                let javascript = "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);"
                webView.evaluateJavaScript(javascript, completionHandler: nil)
            }
        }
}
