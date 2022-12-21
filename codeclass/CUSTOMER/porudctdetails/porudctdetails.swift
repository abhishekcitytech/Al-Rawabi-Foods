//
//  porudctdetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/06/22.
//

import UIKit
import ImageSlideshow
import SDWebImage
import Alamofire
import Cosmos

class porudctdetails: BaseViewController,UIScrollViewDelegate,ImageSlideshowDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource
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
    @IBOutlet weak var btnMINUS: UIButton!
    @IBOutlet weak var btnPLUS: UIButton!
    @IBOutlet weak var txtqty: UITextField!
    @IBOutlet weak var btnaddonce: UIButton!
    
    @IBOutlet weak var lblor: UILabel!
    @IBOutlet weak var lblsep1: UILabel!
    @IBOutlet weak var lblsep2: UILabel!
    
    @IBOutlet weak var viewwishlist: UIView!
    @IBOutlet weak var btnaddtowishlist: UIButton!
    @IBOutlet weak var btnaddtowishlisticon: UIButton!
    
    
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
    
    var strFrompageIdentifier = ""
    
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
        
        self.getProductDetailsAPIMethod()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Product Details"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.viewoverall.isHidden = true
        
        self.scrolloverall.contentSize = CGSize(width: self.viewoverall.bounds.size.width, height: self.viewoverall.bounds.size.height)
        self.scrolloverall.showsVerticalScrollIndicator = false
        
        self.createBannerGallery(arrimages: [])
        self.createselectsize()
        
        btnaddonce.layer.cornerRadius = 18.0
        btnaddonce.layer.masksToBounds = true
      
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
        
    }
    
    // MARK: - viewDidLayoutSubviews Method
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -  press Add To Wishlist  method
    @IBAction func pressAddtoWishlist(_ sender: Any)
    {
        if btnaddtowishlist.tag == 200
        {
            //Add To Wishlist
            let refreshAlert = UIAlertController(title: "", message: "Do you want to Add to Wishlist?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.postAddtoWishlistAPIMethod()
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        else{
            //Remove From Wishlist
            let refreshAlert = UIAlertController(title: "", message: "Do you want to remove from Wishlist?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.postRemoveFromWishlistAPIMethod(strSelectedProductID: strSelectedProductID)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        
    }
    
    
    //MARK: -  press minus plus method
    @IBAction func pressminus(_ sender: Any)
    {
        if strFrompageIdentifier == "1001"
        {
            //FROM CATEGORY BUY ONCE LOGIN
            
            var intqty = Int(self.txtqty.text!)
            if intqty! >= 0{
                intqty = intqty! - 1
            }
            else{
                //cart item 0
            }
            print("intqty",intqty as Any)
            self.txtqty.text = String(format: "%d", intqty!)
        }
    }
    @IBAction func pressplus(_ sender: Any)
    {
        if strFrompageIdentifier == "1001"
        {
            //FROM CATEGORY BUY ONCE LOGIN
            
            var intqty = Int(self.txtqty.text!)
            if intqty! >= 0{
                intqty = intqty! + 1
            }
            else{
                //cart item 0
            }
            print("intqty",intqty as Any)
            self.txtqty.text = String(format: "%d", intqty!)
        }
    }
    
    //MARK: -  press Addonce  method
    @IBAction func pressaddonce(_ sender: Any) {
        
        if strFrompageIdentifier == "1001"
        {
            //FROM CATEGORY PAGE BUY ONCE CASE
            self.postAddToCartApiMethod(strqty: self.txtqty.text!, strproductid: strSelectedProductID)
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
        layout.itemSize = CGSize(width: colrelatedProducts.frame.size.width / 2, height: 316)
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
        if collectionView == colrelatedProducts{
            
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
            cellA.lblqty.text = strsize
            
            let fltprice = Float(strprice)
            cellA.lblprice.text = String(format: "%.2f", fltprice!)
            
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
        cellA.lblrpcie.text = String(format: "%.2f", fltprice!)

        
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
            return CGSize(width: colrelatedProducts.frame.size.width / 2.3 , height: 316)
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
        
        cell.imgvuser.image = UIImage(named: "graycircle.png")
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
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?productId=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod11,strSelectedProductID)
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
                            let dicproductdata = json.value(forKey: "productData") as? NSDictionary
                            self.dicMProductDetails = dicproductdata!.mutableCopy() as! NSMutableDictionary
                            print("dicMProductDetails --->",self.dicMProductDetails)
                            
                            
                            //SET PRODUCT NAME TITLE
                            self.title = String(format: "%@", self.dicMProductDetails.value(forKey: "productName")as? String ?? "")
                            
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
                                self.colselectsize.reloadData()
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
                                
                                self.colselectsize.reloadData()
                            }
                            
                            //SET ADD OR ALREADY ADDED INTO WISHLIST
                            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                            if strbearertoken != ""{
                                let stris_addedwishlist = String(format: "%@", self.dicMProductDetails.value(forKey: "is_addedwishlist") as? String ?? "")
                                
                                print("stris_addedwishlist",stris_addedwishlist)
                                if stris_addedwishlist == "True"
                                {
                                    self.btnaddtowishlist.tag = 100
                                    self.btnaddtowishlisticon.setImage(UIImage(named: "favselected"), for: .normal)
                                    self.btnaddtowishlist.setTitle("Remove from WishList", for: .normal)
                                }
                                else{
                                    self.btnaddtowishlist.tag = 200
                                    self.btnaddtowishlisticon.setImage(UIImage(named: "fav1"), for: .normal)
                                    self.btnaddtowishlist.setTitle("Add to Wishlist", for: .normal)
                                }
                            }else{
                                self.btnaddtowishlist.tag = 200
                                self.btnaddtowishlisticon.setImage(UIImage(named: "fav1"), for: .normal)
                                self.btnaddtowishlist.setTitle("Add to Wishlist", for: .normal)
                            }
                            
                            //SET Remivew LIST
                            let arrmreviewlist = self.dicMProductDetails.value(forKey: "reviews") as? NSArray ?? []
                            self.arrmreviews = NSMutableArray(array: arrmreviewlist)
                            if self.arrmreviews.count == 0{
                                self.msgreview = "No reviews available!"
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
                            print("fltfullcount",fltfullcount as Any)
                            
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
                                self.lbltotalratingcount.text = String(format: "%.1f ou of 5", doubleratingvalue)
                                self.lbltotalcountglobal.text = String(format: "%@ global ratings", strTotalVotesCount)
                                
                                self.progress1star.progress = flt1star! / 100
                                self.progress2star.progress = flt2star! / 100
                                self.progress3star.progress = flt3star! / 100
                                self.progress4star.progress = flt4star! / 100
                                self.progress5star.progress = flt5star! / 100
                            }
                            else{
                                self.viewratingstar.rating = 0.0
                                self.lbltotalratingcount.text = String(format: "%.1f ou of 5", 0.0)
                                self.lbltotalcountglobal.text = String(format: "%@ global ratings", strTotalVotesCount)
                                
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
                            self.txtvshortdescription.attributedText = strshortdesc.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 12), csscolor: "black", lineheight: 2, csstextalign: "left")

                            
                            //SET BENIFITES DESCRIPTION
                            let strbenefits = String(format: "%@", self.dicMProductDetails.value(forKey: "benefits")as? String ?? "")
                            //self.txtvbenifits.attributedText = strbenefits.htmlToAttributedString
                            self.txtvbenifits.attributedText = strbenefits.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "left")
                            
                            //SET NUTRITION FACTS DESCRIPTION
                            let strnutrition_facts = String(format: "%@", self.dicMProductDetails.value(forKey: "nutrition_facts")as? String ?? "")
                            //self.txtvnutritionfacts.attributedText = strnutrition_facts.htmlToAttributedString
                            self.txtvnutritionfacts.attributedText = strnutrition_facts.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "NunitoSans-Regular", size: 13), csscolor: "black", lineheight: 2, csstextalign: "center")
                            
                            //SET FULL DESCRIPTION DESCRIPTION
                            let strdescription = String(format: "%@", self.dicMProductDetails.value(forKey: "description")as? String ?? "")
                            print("strdescription",strdescription)
                            
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language269") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.getProductDetailsAPIMethod()

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
extension String {
    public var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }

    public func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return convertHtmlToNSAttributedString
        }
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}
