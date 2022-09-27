//
//  subscriptionorderreview.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/07/22.
//

import UIKit

class subscriptionorderreview: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var lblmessageminimumorder: UILabel!
    @IBOutlet weak var imgvribbonsubscriptionplan: UIImageView!
    
    @IBOutlet weak var tabvordereview: UITableView!
    var reuseIdentifier1 = "celltabvsubscriptionOR"
    
    @IBOutlet weak var btnproceed: UIButton!

    @IBOutlet weak var lblminimumwarningshippingcost: UILabel!
    
    //POPUP EDIT PENCIL ITEMS DATE SPECIFIC
    @IBOutlet var viewpopupedititems: UIView!
    @IBOutlet weak var lbleditpopupDateDay: UILabel!
    @IBOutlet weak var btncrosseditpopup: UIButton!
    @IBOutlet weak var tabveditpopupitems: UITableView!
    @IBOutlet weak var lblsubtotaleditpopup: UILabel!
    var reuseIdentifier2 = "celltabvprodustitemsedit"
    var viewPopupAddNewExistingBG2 = UIView()
    
    //DELIVERY SLOTS DATE
    @IBOutlet var viewdateslotsdeliverypopup: UIView!
    @IBOutlet weak var scrollviewdeliveryslotpopup: UIScrollView!
    @IBOutlet weak var txtsubsriptionplanpopup2: UITextField!
    @IBOutlet weak var txtsubscriptionstartdatepopup2: UITextField!
    @IBOutlet weak var txtsubscriptionenddatepopup2: UITextField!
    @IBOutlet weak var viewsubsriptionshippingchargepopup2: UIView!
    @IBOutlet weak var btnmorningslot: UIButton!
    @IBOutlet weak var btnafternoonslot: UIButton!
    @IBOutlet weak var btneveningslot: UIButton!
    @IBOutlet weak var btnshippingchargesamount: UIButton!
    @IBOutlet weak var lblshippingchargesamount: UILabel!
    @IBOutlet weak var btncrossdateslotspopup: UIButton!
    @IBOutlet weak var btnsavedateslotspopup: UIButton!
    var viewPopupAddNewExistingBG3 = UIView()
    
    var arrMordereview = NSMutableArray()
     
    var strpageidentifier = ""
    var strpageidentifierplanname = ""
    
    var strFulladdress = ""
    var strFulladdressLocationname = ""
    var strFulladdressCityname = ""
    
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
        
        if self.strFulladdress != ""{
            //Fetch from MAP ADDRESS
            self.tabvordereview.reloadData()
        }
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Review Your Order"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        tabvordereview.register(UINib(nibName: "celltabvsubscriptionOR", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvordereview.separatorStyle = .none
        tabvordereview.backgroundView=nil
        tabvordereview.backgroundColor=UIColor.clear
        tabvordereview.separatorColor=UIColor.clear
        tabvordereview.showsVerticalScrollIndicator = false
        
        btnproceed.layer.borderWidth = 1.0
        btnproceed.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnproceed.layer.cornerRadius = 18.0
        btnproceed.layer.masksToBounds = true
      
        if strpageidentifier == "100"{
            lblmessageminimumorder.text = "You have to select 'Minimum 10 days orders OR more orders' for Daily subscription plan."
            self.imgvribbonsubscriptionplan.image = UIImage(named: "ribbon_daily.png")
        }
        else if strpageidentifier == "200"{
            lblmessageminimumorder.text = "You have to select 'Minimum 3 orders a week OR full week i.e. 7 days' for Weekly subscription plan."
            self.imgvribbonsubscriptionplan.image = UIImage(named: "ribbon_weekly.png")
        }
        else if strpageidentifier == "300"{
            lblmessageminimumorder.text = "You have to select 'Minimum 8 orders a month OR full month i.e. no. of days in a month' for Monthly subscription plan."
            self.imgvribbonsubscriptionplan.image = UIImage(named: "ribbon_monthly.png")
        }
        
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -  press proceed method
    @IBAction func pressproceed(_ sender: Any)
    {
        UserDefaults.standard.set("2", forKey: "payfromOrderonce")
        UserDefaults.standard.synchronize()
        
        let ctrl = paymentmethod(nibName: "paymentmethod", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tabveditpopupitems
        {
            if strpageidentifier == "100"
            {
                //Daily
                return 5
            }
            else if strpageidentifier == "200"
            {
                //Weekly
                return 5
            }
            //Monthly
            return 5
        }
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tabveditpopupitems{
            return 94
        }
        return 150
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tabvordereview{
            return 144
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == tabvordereview{
            return 120
        }
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == tabvordereview
        {
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 144)
            headerView.backgroundColor = UIColor.clear
            
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width - 140, height: 64))
            title1.textAlignment = .left
            title1.textColor = UIColor(named: "themecolor")!
            title1.backgroundColor = .clear
            title1.numberOfLines = 10
            title1.font = UIFont (name: "NunitoSans-Bold", size: 14.5)
            if self.strFulladdress != ""{
                title1.text = self.strFulladdress
            }else{
                title1.text = "Choose Your precise location"
            }
            
            headerView.addSubview(title1)
            
            let btnUpdateAddress = UIButton(frame: CGRect(x: headerView.frame.self.width - 130 , y: title1.frame.midY - 15, width: 130, height: 30))
            btnUpdateAddress.backgroundColor = UIColor(named: "themecolor")!
            btnUpdateAddress.setTitle("Current Location", for: .normal)
            btnUpdateAddress.titleLabel?.font = UIFont (name: "NunitoSans-Regular", size: 14)
            btnUpdateAddress.setTitleColor(UIColor.white, for: .normal)
            btnUpdateAddress.addTarget(self, action: #selector(pressUpdateAddress), for: .touchUpInside)
            btnUpdateAddress.layer.cornerRadius = 8.0
            btnUpdateAddress.layer.masksToBounds = true
            headerView.addSubview(btnUpdateAddress)
            
           
            //CHOOSE DELIEVRY SLOTS DATE TIME DESIGN
            let viewslot = UIView(frame: CGRect(x: 0, y: 64, width:headerView.frame.self.width, height: 40))
            viewslot.backgroundColor = UIColor(named: "greenlighter")!
            viewslot.layer.cornerRadius = 6.0
            viewslot.layer.borderWidth = 1.0
            viewslot.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            viewslot.layer.masksToBounds = true
            headerView.addSubview(viewslot)
            
            let title2 = UILabel(frame: CGRect(x: 0, y: 64, width:headerView.frame.self.width - 44, height: 40))
            title2.textAlignment = .center
            title2.textColor = UIColor.black
            title2.backgroundColor = .clear
            title2.numberOfLines = 10
            title2.font = UIFont (name: "NunitoSans-Bold", size: 13)
            title2.text = "Choose your preferred Delivery slots Date & Time"
            headerView.addSubview(title2)
            
            let imgvarrow = UIImageView(frame: CGRect(x: viewslot.frame.self.width - 44, y: 72, width:32, height: 32))
            imgvarrow.image = UIImage(named: "circlearrow")
            headerView.addSubview(imgvarrow)
            
            let btnChooseDelievryslotsdatetime = UIButton(frame: CGRect(x: 0 , y: 64 , width: viewslot.frame.size.width, height: 40))
            btnChooseDelievryslotsdatetime.backgroundColor = UIColor.clear
            btnChooseDelievryslotsdatetime.addTarget(self, action: #selector(pressChooseDelievryslotsdatetime), for: .touchUpInside)
            headerView.addSubview(btnChooseDelievryslotsdatetime)
            
            return headerView
        }
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if tableView == tabvordereview
        {
            let footerView = UIView()
            footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 120)
            footerView.backgroundColor = UIColor(named: "greenlighter")!
            
            //SUBTOTAL
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:footerView.frame.self.width / 2, height: 30))
            title1.textAlignment = .left
            title1.textColor = UIColor.black
            title1.backgroundColor = .clear
            title1.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title1.text = "  Cart Subtotal"
            footerView.addSubview(title1)
            
            let title1value = UILabel(frame: CGRect(x: title1.frame.maxX, y: 0, width:footerView.frame.self.width / 2, height: 30))
            title1value.textAlignment = .right
            title1value.textColor = UIColor.black
            title1value.backgroundColor = .clear
            title1value.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title1value.text = "AED 93.00"
            footerView.addSubview(title1value)
            
            //SHIPPING
            let title2 = UILabel(frame: CGRect(x: 0, y: title1.frame.maxY, width:footerView.frame.self.width / 2, height: 50))
            title2.textAlignment = .left
            title2.textColor = UIColor.black
            title2.backgroundColor = .clear
            title2.numberOfLines = 3
            title2.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title2.text = "  Shipping \n Flat Rate - Fixed"
            footerView.addSubview(title2)
            
            let title2value = UILabel(frame: CGRect(x: title2.frame.maxX, y: title1.frame.maxY, width:footerView.frame.self.width / 2, height: 50))
            title2value.textAlignment = .right
            title2value.textColor = UIColor.black
            title2value.backgroundColor = .clear
            title2value.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title2value.text = "AED 10.00"
            footerView.addSubview(title2value)
            
            //GRANDTOTAL
            let title3 = UILabel(frame: CGRect(x: 0, y: title2.frame.maxY, width:footerView.frame.self.width / 2, height: 30))
            title3.textAlignment = .left
            title3.textColor = UIColor.black
            title3.backgroundColor = .clear
            title3.numberOfLines = 3
            title3.font = UIFont (name: "NunitoSans-Bold", size: 16)
            title3.text = "  Grand Total"
            footerView.addSubview(title3)
            
            let title3value = UILabel(frame: CGRect(x: title3.frame.maxX, y: title2.frame.maxY, width:footerView.frame.self.width / 2, height: 30))
            title3value.textAlignment = .right
            title3value.textColor = UIColor.black
            title3value.backgroundColor = .clear
            title3value.font = UIFont (name: "NunitoSans-Bold", size: 16)
            title3value.text = "AED 103.00"
            footerView.addSubview(title3value)
            
            return footerView
        }
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView == tabveditpopupitems
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as! celltabvprodustitemsedit
            
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor = .clear
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            let appDel = UIApplication.shared.delegate as! AppDelegate
            
            var dict = NSMutableDictionary()
            
            if strpageidentifier == "100"
            {
                dict = (appDel.arrMDATEWISEPRODUCTPLAN.object(at: tabveditpopupitems.tag)as? NSMutableDictionary)!
            }
            else if strpageidentifier == "200"
            {
                dict = (appDel.arrMDATEWISEPRODUCTPLANWEEKLY.object(at: tabveditpopupitems.tag)as? NSMutableDictionary)!
            }
            else{
                dict = (appDel.arrMDATEWISEPRODUCTPLANMONTHLY.object(at: tabveditpopupitems.tag)as? NSMutableDictionary)!
            }
            
            let arrm = dict.value(forKey: "items")as! NSMutableArray
            let dictm = arrm.object(at: indexPath.row)as! NSMutableDictionary
            let strid = String(format: "%@", dictm.value(forKey: "id")as? String ?? "")
            let strname = String(format: "%@", dictm.value(forKey: "name")as? String ?? "")
            let strqty = String(format: "%@", dictm.value(forKey: "qty")as? String ?? "")
            let strprice = String(format: "%@", dictm.value(forKey: "price")as? String ?? "")
            
            cell.lblname.text = strname
            cell.lblspec.text = "1.5 ltr"
            cell.lblunitprice.text = String(format: "AED %@", strprice)
            
            cell.txtplusminus.text = strqty
            
            cell.viewplusminus.layer.cornerRadius = 14.0
            cell.viewplusminus.layer.borderWidth = 1.0
            cell.viewplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cell.viewplusminus.layer.masksToBounds = true
            
            cell.txtplusminus.layer.cornerRadius = 1.0
            cell.txtplusminus.layer.borderWidth = 1.0
            cell.txtplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cell.txtplusminus.layer.masksToBounds = true
            
            cell.btnplus.tag = indexPath.row
            cell.btnminus.tag = indexPath.row
            cell.btnplus.addTarget(self, action: #selector(pressEditPopupPlus), for: .touchUpInside)
            cell.btnminus.addTarget(self, action: #selector(pressEditPopupMinus), for: .touchUpInside)
            
            cell.btnremove.layer.cornerRadius = 12.0
            cell.btnremove.layer.masksToBounds = true
            cell.btnremove.tag = indexPath.row
            cell.btnremove.addTarget(self, action: #selector(pressEditPopupRemove), for: .touchUpInside)
            
            let lblSeparator = UILabel(frame: CGRect(x: 0, y: 93.5, width: tableView.frame.size.width, height: 0.5))
            lblSeparator.backgroundColor = UIColor(named: "graybordercolor")!
            cell.contentView.addSubview(lblSeparator)
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvsubscriptionOR
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        if indexPath.row == 1{
            
            cell.viewoverall.backgroundColor = UIColor(named: "lightred")!
            cell.viewleft.backgroundColor = UIColor(named: "lightred")!
            cell.btnwarning.isHidden = false
        }else{
            cell.viewoverall.backgroundColor = .white
            cell.viewleft.backgroundColor = .white
            cell.btnwarning.isHidden = true
            
        }
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        print("appDel.arrMDATEWISEPRODUCTPLAN",appDel.arrMDATEWISEPRODUCTPLAN)
        
        cell.viewoverall.layer.borderWidth = 1.0
        cell.viewoverall.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewoverall.layer.cornerRadius = 2.0
        cell.viewoverall.layer.masksToBounds = true
        
        cell.btndetail.layer.cornerRadius = 6.0
        cell.btndetail.layer.masksToBounds = true
        
        cell.btndetail.tag = indexPath.row
        cell.btndetail.addTarget(self, action: #selector(pressDetail), for: .touchUpInside)
        
        if strpageidentifier == "100"
        {
            if appDel.arrMDATEWISEPRODUCTPLAN.count > 0{
                cell.btndetail.isHidden = false
            }else{
                cell.btndetail.isHidden = true
            }
        }
        else if strpageidentifier == "200"
        {
            if appDel.arrMDATEWISEPRODUCTPLANWEEKLY.count > 0{
                cell.btndetail.isHidden = false
            }else{
                cell.btndetail.isHidden = true
            }
        }
        else{
            if appDel.arrMDATEWISEPRODUCTPLANMONTHLY.count > 0{
                cell.btndetail.isHidden = false
            }else{
                cell.btndetail.isHidden = true
            }
        }
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 119.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor(named: "graybordercolor")!
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    //MARK: - press Detail View Method
    @objc func pressDetail(sender:UIButton)
    {
        self.createEditpopupDatewiseItems(selecteddateindex: sender.tag)
    }
    
    
    //MARK: - press Update Address Method
    @objc func pressUpdateAddress(sender:UIButton)
    {
        let ctrl = mapaddress(nibName: "mapaddress", bundle: nil)
        ctrl.strFrompageMap = "subscriptionorderreview"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press ChooseDelievryslotsdatetime Method
    @objc func pressChooseDelievryslotsdatetime(sender:UIButton)
    {
        self.createDateslotsPopup()
    }
    
    
    //MARK: - create POPUP EDIT ITEMS DATE WISE method
    func createEditpopupDatewiseItems(selecteddateindex:Int)
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        var dict = NSMutableDictionary()
        
        if strpageidentifier == "100"
        {
            dict = (appDel.arrMDATEWISEPRODUCTPLAN.object(at: selecteddateindex)as? NSMutableDictionary)!
        }
        else if strpageidentifier == "200"
        {
            dict = (appDel.arrMDATEWISEPRODUCTPLANWEEKLY.object(at: selecteddateindex)as? NSMutableDictionary)!
        }
        else{
            dict = (appDel.arrMDATEWISEPRODUCTPLANMONTHLY.object(at: selecteddateindex)as? NSMutableDictionary)!
        }
        let strdate = String(format: "%@", dict.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dict.value(forKey: "day")as? String ?? "")
        
        let arrm = dict.value(forKey: "items")as! NSMutableArray
        
        var intvalueTotal = 0
        for x in 0 ..< arrm.count
        {
            let dict = arrm.object(at: x)as? NSMutableDictionary
            let strunitprice = String(format: "%@", dict?.value(forKey: "price")as? String ?? "")
            let intvalue = Int(strunitprice)
            intvalueTotal = intvalueTotal + intvalue!
            
        }
        let strtotalprice = String(format: "%d", intvalueTotal)
        print("Sub-Total Price",strtotalprice)
         
        self.lbleditpopupDateDay.text = String(format: "%@ (%@)", strdate,strday)
        self.lblsubtotaleditpopup.text = String(format: "AED %@", strtotalprice)
        
        
        self.viewpopupedititems.layer.cornerRadius = 6.0
        self.viewpopupedititems.layer.masksToBounds = true
        
        tabveditpopupitems.register(UINib(nibName: "celltabvprodustitemsedit", bundle: nil), forCellReuseIdentifier: reuseIdentifier2)
        tabveditpopupitems.separatorStyle = .none
        tabveditpopupitems.backgroundView=nil
        tabveditpopupitems.tag = selecteddateindex
        tabveditpopupitems.backgroundColor=UIColor.clear
        tabveditpopupitems.separatorColor=UIColor.clear
        tabveditpopupitems.showsVerticalScrollIndicator = false
       
        viewPopupAddNewExistingBG2 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG2.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG2.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG2.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG2.addSubview(self.viewpopupedititems)
        self.viewpopupedititems.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG2)
    }
    @IBAction func presscrosseditpopup(_ sender: Any) {
        self.viewpopupedititems.removeFromSuperview()
        viewPopupAddNewExistingBG2.removeFromSuperview()
    }
    @objc func pressEditPopupPlus(sender:UIButton)
    {
    }
    @objc func pressEditPopupMinus(sender:UIButton)
    {
    }
    @objc func pressEditPopupRemove(sender:UIButton)
    {
    }
    
    //MARK: - create POPUP EDIT DELIVERY DATE & SLOTS TIME method
    func createDateslotsPopup()
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewdateslotsdeliverypopup.layer.cornerRadius = 6.0
        self.viewdateslotsdeliverypopup.layer.masksToBounds = true
        
        self.scrollviewdeliveryslotpopup.backgroundColor = .clear
        self.scrollviewdeliveryslotpopup.showsVerticalScrollIndicator = false
        self.scrollviewdeliveryslotpopup.contentSize=CGSize(width: self.viewdateslotsdeliverypopup.frame.size.width, height: self.viewdateslotsdeliverypopup.frame.size.height)
        
        self.txtsubsriptionplanpopup2.setBottomBorder()
        self.txtsubscriptionstartdatepopup2.setBottomBorder()
        self.txtsubscriptionenddatepopup2.setBottomBorder()
        
        self.txtsubsriptionplanpopup2.setLeftPaddingPoints(10)
        self.txtsubscriptionstartdatepopup2.setLeftPaddingPoints(10)
        self.txtsubscriptionenddatepopup2.setLeftPaddingPoints(10)
        
        self.viewsubsriptionshippingchargepopup2.layer.cornerRadius = 6.0
        self.viewsubsriptionshippingchargepopup2.layer.masksToBounds = true
        
        print("appDel.strSelectedPLAN",appDel.strSelectedPLAN)
        self.txtsubsriptionplanpopup2.text = appDel.strSelectedPLAN
        
        viewPopupAddNewExistingBG3 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG3.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG3.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG3.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG3.addSubview(self.viewdateslotsdeliverypopup)
        self.viewdateslotsdeliverypopup.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG3)
    }
    @IBAction func presscrossdateslotspopup(_ sender: Any) {
        
        self.viewdateslotsdeliverypopup.removeFromSuperview()
        viewPopupAddNewExistingBG3.removeFromSuperview()
    }
    @IBAction func presssavedeliveryslot(_ sender: Any) {
    }
    @IBAction func pressmorninglot(_ sender: Any) {
    }
    @IBAction func pressafternoonslot(_ sender: Any) {
    }
    @IBAction func presseveningslot(_ sender: Any) {
    }
    @IBAction func pressshippingchargesamount(_ sender: Any) {
    }
}
