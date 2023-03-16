//
//  renewsubscriptiondetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/11/22.
//

import UIKit

class renewsubscriptiondetails: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var imgvplan: UIImageView!
    
    @IBOutlet weak var viewstartdate: UIView!
    @IBOutlet weak var txtstartdate: UITextField!
    @IBOutlet weak var imgvstartcal: UIImageView!
    
    @IBOutlet weak var viewenddate: UIView!
    @IBOutlet weak var txtenddate: UITextField!
    @IBOutlet weak var imgvendcal: UIImageView!
    
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblsubtotalvalue: UILabel!
    @IBOutlet weak var lblshipping: UILabel!
    @IBOutlet weak var lblshippingvalue: UILabel!
    @IBOutlet weak var lbltaxtotal: UILabel!
    @IBOutlet weak var lbltaxtotalvalue: UILabel!
    @IBOutlet weak var lblgrandtotal: UILabel!
    @IBOutlet weak var lblgrandtotalvalue: UILabel!
    
    @IBOutlet weak var viewcoupon: UIView!
    @IBOutlet weak var txtcouponcode: UITextField!
    @IBOutlet weak var btnapplycouponcode: UIButton!
    @IBOutlet weak var btnremovecouponcode: UIButton!
    @IBOutlet weak var btnviewcouponcode: UIButton!
    
    
    @IBOutlet weak var lblautorenew: UILabel!
    @IBOutlet weak var btnautorenew: UIButton!
    
    
    @IBOutlet weak var tabvorderlist: UITableView!
    var reuseIdentifier1 = "celltabvsubscriptionorderview"
    var msg = ""
    
    @IBOutlet weak var viewpaymentcondition: UIView!
    @IBOutlet weak var lblfullpayment: UILabel!
    @IBOutlet weak var lblfirst3payment: UILabel!
    @IBOutlet weak var btnfullpayment: UIButton!
    @IBOutlet weak var btnfirst3payment: UIButton!
    
    @IBOutlet weak var btncheckout: UIButton!
    
    
    //POPUP EDIT PENCIL ITEMS DATE SPECIFIC
    @IBOutlet var viewpopupedititems: UIView!
    @IBOutlet weak var lbleditpopupDateDay: UILabel!
    @IBOutlet weak var btncrosseditpopup: UIButton!
    @IBOutlet weak var lbleditpopupnotes: UILabel!
    @IBOutlet weak var lblsubtotaleditpopup: UILabel!
    @IBOutlet weak var lblsubtotaleditpopupvalue: UILabel!
    @IBOutlet weak var tabveditpopupitems: UITableView!
    var reuseIdentifier2 = "celltabvprodustitemsedit"
    var viewPopupAddNewExistingBG2 = UIView()
    
    
    var dicMRenewData = NSDictionary()
    var arrMOrderList = NSMutableArray()
    var strSelectedpaymentoption = ""
    var arrMProductItemsEdit = NSMutableArray()
    
    var strsubscriptionid = ""
    
    var strSUBTOTAL = ""
    var strSHIPPING = ""
    var strTAX = ""
    var strGRANDTOTAL = ""
    
    var strDISCOUNTCODE = ""
    var strDISCOUNTAMOUNT = ""
    
    var strISAUTORENEW = "0"
    
    //Coupon View POPUP LIST
    @IBOutlet var viewcouponlist: UIView!
    @IBOutlet weak var viewcouponlistheader1: UIView!
    @IBOutlet weak var lblcouponlistpopupheader: UILabel!
    @IBOutlet weak var btncrosscouponlistpopup: UIButton!
    @IBOutlet weak var tabvcouponlistpopup: UITableView!
    var reuseIdentifier3 = "cellcoupon"
    var viewPopupAddNewExistingBG3 = UIView()
    var msg1 = ""
    var arrMCoupons = NSMutableArray()
    
    
    var myAppDelegate = UIApplication.shared.delegate as! AppDelegate

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

        
        let strplan_id = String(format: "%@", dicMRenewData.value(forKey: "plan_id")as? String ?? "")
        let strsubscription_start_date = String(format: "%@", dicMRenewData.value(forKey: "subscription_start_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_end_date = String(format: "%@", dicMRenewData.value(forKey: "subscription_end_date")as? String ?? "DD/MM/YYYY")
    
        print("strplan_id",strplan_id)
        if strplan_id == "1"{
            self.imgvplan.image = UIImage(named: "ribbonlinedaily")
        }
        else if strplan_id == "2"{
            self.imgvplan.image = UIImage(named: "ribbonlineweekly")
        }
        else if strplan_id == "3"{
            self.imgvplan.image = UIImage(named: "ribbonlinemonthly")
        }
        txtstartdate.text = strsubscription_start_date
        txtenddate.text = strsubscription_end_date
        
        let arrm = dicMRenewData.value(forKey: "subscription_order_details") as? NSArray ?? []
        self.arrMOrderList = NSMutableArray(array: arrm)
        print("arrMOrderList --->",self.arrMOrderList)
        self.tabvorderlist.reloadData()
        
        
        self.btnautorenew.isSelected = false
        self.strISAUTORENEW = "0"
        
        //BY DAFULT FULL PAY
        self.strSelectedpaymentoption = "FULL"
        self.btnfullpayment.isSelected = true
        self.btnfirst3payment.isSelected = false
        
        calculateFullPAY()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = myAppDelegate.changeLanguage(key: "msg_language428")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        setupRTLLTR()
        
        viewstartdate.layer.cornerRadius = 3.0
        viewstartdate.layer.masksToBounds = true
        viewenddate.layer.cornerRadius = 3.0
        viewenddate.layer.masksToBounds = true
      
        tabvorderlist.register(UINib(nibName: "celltabvsubscriptionorderview", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvorderlist.separatorStyle = .none
        tabvorderlist.backgroundView=nil
        tabvorderlist.backgroundColor=UIColor.clear
        tabvorderlist.separatorColor=UIColor.clear
        tabvorderlist.showsVerticalScrollIndicator = false
        
        viewcoupon.layer.borderWidth = 1.0
        viewcoupon.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcoupon.layer.cornerRadius = 6.0
        viewcoupon.layer.masksToBounds = true
        
        txtcouponcode.setLeftPaddingPoints(10)
        txtcouponcode.layer.borderWidth = 0.0
        txtcouponcode.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtcouponcode.layer.cornerRadius = 0.0
        txtcouponcode.layer.masksToBounds = true
        
        btnapplycouponcode.layer.cornerRadius = 0.0
        btnapplycouponcode.layer.masksToBounds = true
        
        if self.btnapplycouponcode.isUserInteractionEnabled == false{
            btnremovecouponcode.isHidden = false
        }else{
            btnremovecouponcode.isHidden = true
        }
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        txtstartdate.placeholder = myAppDelegate.changeLanguage(key: "msg_language208")
        txtenddate.placeholder = myAppDelegate.changeLanguage(key: "msg_language299")
        lblsubtotal.text = myAppDelegate.changeLanguage(key: "msg_language311")
        lblshipping.text = myAppDelegate.changeLanguage(key: "msg_language441")
        //lbltaxtotal.text = myAppDelegate.changeLanguage(key: "")
        lblgrandtotal.text = myAppDelegate.changeLanguage(key: "msg_language86")
        lblautorenew.text = myAppDelegate.changeLanguage(key: "msg_language63")
        
        lblfullpayment.text = myAppDelegate.changeLanguage(key: "msg_language336")
        lblfirst3payment.text = myAppDelegate.changeLanguage(key: "msg_language337")
        btncheckout.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language482")), for: .normal)
        
        txtcouponcode.placeholder = myAppDelegate.changeLanguage(key: "msg_language229")
        btnapplycouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language234")), for: .normal)
        btnremovecouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language49")), for: .normal)
        btnviewcouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language113")), for: .normal)
        
         let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
         if (strLangCode == "en")
         {
        
         }
         else
         {

         }
    }
    
    //MARK: - press auto renew method
    @IBAction func pressautorenewclick(_ sender: Any)
    {
        if btnautorenew.isSelected == true{
            self.btnautorenew.isSelected = false
            self.strISAUTORENEW = "0"
        }
        else{
            self.btnautorenew.isSelected = true
            self.strISAUTORENEW = "1"
        }
    }
    
    
    //MARK: - pressCheckout Method
    @IBAction func pressCheckout(_ sender: Any)
    {
        
        if strSelectedpaymentoption.count == 0
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language442"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            let ctrl = renewaddresstimeslot(nibName: "renewaddresstimeslot", bundle: nil)
            ctrl.strSubscriptionID = strsubscriptionid
            ctrl.strautorenew = strISAUTORENEW
            ctrl.strsubtotalamount = strSUBTOTAL
            ctrl.strshippingchargesamount = strSHIPPING
            ctrl.strgrandtotalamount = strGRANDTOTAL
            ctrl.strdiscountamount = strDISCOUNTAMOUNT
            ctrl.strcouponcode = strDISCOUNTCODE
            ctrl.strpaymentype = strSelectedpaymentoption
            ctrl.strplanid = String(format: "%@", dicMRenewData.value(forKey: "plan_id")as? String ?? "")
            ctrl.dicDetails = dicMRenewData
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    
    //MARK: - press FULL PAYMENT // FIRST 3 PAYMENT Method
    @IBAction func pressFullPayment(_ sender: Any)
    {
        strSelectedpaymentoption = "FULL"
        self.btnfullpayment.isSelected = true
        self.btnfirst3payment.isSelected = false
        
        calculateFullPAY()
    }
    @IBAction func pressFirst3Payment(_ sender: Any)
    {
        strSelectedpaymentoption = "THREE"
        self.btnfullpayment.isSelected = false
        self.btnfirst3payment.isSelected = true
        
        calculate3DAYSPAY()
    }
    func calculateFullPAY()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var flttotalSUBTOTAL = Float()
        var flttotalSHIPPING = Float()
        var flttotalTAX = Float()
        var flttotalGRANDTOTAL = Float()
        for x in 0 ..< self.arrMOrderList.count
        {
            let dict = self.arrMOrderList.object(at: x)as? NSDictionary
            let strshipping_amount = String(format: "%@", dict!.value(forKey: "shipping_amount")as! CVarArg)
            let strorder_subtotal = String(format: "%@", dict!.value(forKey: "order_subtotal")as! CVarArg)
            
            let strtax = String(format: "%@", dict!.value(forKey: "tax")as! CVarArg)
            
            let fltsubtotal = (strorder_subtotal as NSString).floatValue
            let fltshipping = (strshipping_amount as NSString).floatValue
            let flttax = (strtax as NSString).floatValue
            
            flttotalSUBTOTAL = flttotalSUBTOTAL + fltsubtotal
            flttotalSHIPPING = flttotalSHIPPING + fltshipping
            flttotalTAX = flttotalTAX + flttax
        }
        print("flttotalSUBTOTAL",flttotalSUBTOTAL)
        print("flttotalSHIPPING",flttotalSHIPPING)
        print("flttotalTAX",flttotalTAX)
        flttotalGRANDTOTAL = flttotalSUBTOTAL + flttotalSHIPPING
        print("flttotalGRANDTOTAL",flttotalGRANDTOTAL)
        
        strSUBTOTAL = String(format: "%0.2f", flttotalSUBTOTAL)
        strSHIPPING = String(format: "%0.2f", flttotalSHIPPING)
        strTAX = String(format: "%0.2f", flttotalTAX)
        strGRANDTOTAL = String(format: "%0.2f", flttotalGRANDTOTAL)
        
        //CHCEKING IF DISCOUNT EXIST OR NOT
        if strDISCOUNTAMOUNT != "" || strDISCOUNTAMOUNT == "0.00"
        {
            var fltupdated = 0.00
            let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
            let fltamount11  = (self.strDISCOUNTAMOUNT as NSString).floatValue
            
            fltupdated = Double(fltamount1 - fltamount11)
            print("fltupdated",fltupdated)
            
            self.strGRANDTOTAL = String(format: "%0.2f", fltupdated)
        }
        
        self.lblsubtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") ,strSUBTOTAL)
        self.lblshippingvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") , strSHIPPING)
        self.lbltaxtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") , strTAX)
        self.lblgrandtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") , strGRANDTOTAL)
    }
    func calculate3DAYSPAY()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        //var intcount = 0
        
        var flttotalSUBTOTAL = Float()
        var flttotalSHIPPING = Float()
        var flttotalTAX = Float()
        var flttotalGRANDTOTAL = Float()
        
        for x in 0 ..< 3
        {
            let dict = self.arrMOrderList.object(at: x)as? NSDictionary
            let strshipping_amount = String(format: "%@", dict!.value(forKey: "shipping_amount")as! CVarArg)
            let strorder_subtotal = String(format: "%@", dict!.value(forKey: "order_subtotal")as! CVarArg)
            
            let strtax = String(format: "%@", dict!.value(forKey: "tax")as! CVarArg)
            
            let fltsubtotal = (strorder_subtotal as NSString).floatValue
            let fltshipping = (strshipping_amount as NSString).floatValue
            let flttax = (strtax as NSString).floatValue
            
            flttotalSUBTOTAL = flttotalSUBTOTAL + fltsubtotal
            flttotalSHIPPING = flttotalSHIPPING + fltshipping
            flttotalTAX = flttotalTAX + flttax
        }
        print("flttotalSUBTOTAL",flttotalSUBTOTAL)
        print("flttotalSHIPPING",flttotalSHIPPING)
        print("flttotalTAX",flttotalTAX)
        flttotalGRANDTOTAL = flttotalSUBTOTAL + flttotalSHIPPING
        print("flttotalGRANDTOTAL",flttotalGRANDTOTAL)
        
        strSUBTOTAL = String(format: "%0.2f", flttotalSUBTOTAL)
        strSHIPPING = String(format: "%0.2f", flttotalSHIPPING)
        strTAX = String(format: "%0.2f", flttotalTAX)
        strGRANDTOTAL = String(format: "%0.2f", flttotalGRANDTOTAL)
        
        //CHCEKING IF DISCOUNT EXIST OR NOT
        if strDISCOUNTAMOUNT != "" || strDISCOUNTAMOUNT == "0.00"
        {
            var fltupdated = 0.00
            let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
            let fltamount11  = (self.strDISCOUNTAMOUNT as NSString).floatValue
            
            fltupdated = Double(fltamount1 - fltamount11)
            print("fltupdated",fltupdated)
            
            self.strGRANDTOTAL = String(format: "%0.2f", fltupdated)
        }
        
        self.lblsubtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strSUBTOTAL)
        self.lblshippingvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strSHIPPING)
        self.lbltaxtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strTAX)
        self.lblgrandtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strGRANDTOTAL)
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        else if tableView == tabvcouponlistpopup{
            return 1
        }
        
        if arrMOrderList.count == 0 {
            self.tabvorderlist.setEmptyMessage(msg)
        } else {
            self.tabvorderlist.restore()
        }
        return arrMOrderList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tabveditpopupitems
        {
            return self.arrMProductItemsEdit.count
        }
        else if tableView == tabvcouponlistpopup{
            if arrMCoupons.count == 0 {
                self.tabvcouponlistpopup.setEmptyMessage(msg)
            } else {
                self.tabvcouponlistpopup.restore()
            }
            return arrMCoupons.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tabveditpopupitems
        {
            return 155
        }
        else if tableView == tabvcouponlistpopup{
            return 70
        }
        return 125
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tabveditpopupitems
        {
            return 1
        }
        else if tableView == tabvcouponlistpopup{
            return 1
        }
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == tabveditpopupitems
        {
            return 1
        }
        else if tableView == tabvcouponlistpopup{
            return 1
        }
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == tabveditpopupitems
        {
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        else if tableView == tabvcouponlistpopup{
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if tableView == tabveditpopupitems
        {
            let footerView = UIView()
            footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            footerView.backgroundColor = UIColor.clear
            return footerView
        }
        else if tableView == tabvcouponlistpopup{
            let footerView = UIView()
            footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            footerView.backgroundColor = UIColor.clear
            return footerView
        }
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if tableView == tabveditpopupitems
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as! celltabvprodustitemsedit
            
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor = .clear
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            let dictm = self.arrMProductItemsEdit.object(at: indexPath.row)as! NSDictionary
            
            let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
            let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
            let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
            
            let strqtyonce = String(format: "%@", dictm.value(forKey: "qty")as? String ?? "")
            let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
            print("strqtyonce",strqtyonce)
            print("strqtyall",strqtyall)
            
            cell.imgvproduct.isHidden = true
            
            cell.lblname.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblname.frame.origin.y, width: cell.lblname.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblname.frame.size.height)
            cell.lblspec.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblspec.frame.origin.y, width: cell.lblspec.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblspec.frame.size.height)
            cell.lblunitprice.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblunitprice.frame.origin.y, width: cell.lblunitprice.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblunitprice.frame.size.height)
            
            cell.lblname.text = strproduct_name
            cell.lblspec.isHidden = true
            
            let fltamount  = (strproduct_price as NSString).floatValue
            cell.lblunitprice.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltamount)
            
            cell.btnremove.isHidden = true
            
            cell.btnaddonce.layer.cornerRadius = 14.0
            cell.btnaddonce.layer.masksToBounds = true
            
            cell.btnaddtoall.setTitleColor(UIColor(named: "orangecolor")!, for: .normal)
            cell.btnaddtoall.layer.cornerRadius = 14.0
            cell.btnaddtoall.layer.borderWidth = 1.0
            cell.btnaddtoall.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
            cell.btnaddtoall.layer.masksToBounds = true
            
            
            //CELL PLUS MINUS
            cell.viewplusminus.layer.cornerRadius = 14.0
            cell.viewplusminus.layer.borderWidth = 1.0
            cell.viewplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cell.viewplusminus.layer.masksToBounds = true
            
            cell.txtplusminus.layer.cornerRadius = 1.0
            cell.txtplusminus.layer.borderWidth = 1.0
            cell.txtplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cell.txtplusminus.layer.masksToBounds = true
           
            //CELL PLUS MINUS ALL
            cell.viewplusminusATA.layer.cornerRadius = 14.0
            cell.viewplusminusATA.layer.borderWidth = 1.0
            cell.viewplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
            cell.viewplusminusATA.layer.masksToBounds = true
            
            cell.txtplusminusATA.layer.cornerRadius = 1.0
            cell.txtplusminusATA.layer.borderWidth = 1.0
            cell.txtplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
            cell.txtplusminusATA.layer.masksToBounds = true
            
            cell.btnaddonce.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language71")), for: .normal)
            cell.btnaddtoall.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language70")), for: .normal)
            cell.lbladdonce.text = myAppDelegate.changeLanguage(key: "msg_language71")
            cell.lbladdtoall.text = myAppDelegate.changeLanguage(key: "msg_language70")
            
            
            //--- ADD ONCE --- //
            if strqtyonce != "0"
            {
                cell.btnaddonce.isHidden = true
                cell.viewplusminus.isHidden = false
                cell.txtplusminus.text = strqtyonce
            }
            else
            {
                cell.btnaddonce.isHidden = false
                cell.viewplusminus.isHidden = true
            }
            
            //--- ADD TO ALL --- //
            if strqtyall != "0"
            {
                cell.btnaddtoall.isHidden = true
                cell.viewplusminusATA.isHidden = false
                cell.txtplusminusATA.text = strqtyall
            }
            else
            {
                cell.btnaddtoall.isHidden = false
                cell.viewplusminusATA.isHidden = true
            }
            
            /*let lblSeparator = UILabel(frame: CGRect(x: 0, y: fltpointy, width: tableView.frame.size.width, height: 0.5))
             lblSeparator.backgroundColor = UIColor(named: "graybordercolor")!
             cell.contentView.addSubview(lblSeparator)*/
            
            return cell;
        }
        else if tableView == tabvcouponlistpopup
        {
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3, for: indexPath) as! cellcoupon
            
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor = .clear
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            let dic = self.arrMCoupons.object(at: indexPath.row)as! NSDictionary
            
            let strcouponcode = String(format: "%@", dic.value(forKey: "code")as? String ?? "")
            let strexpdate = String(format: "%@", dic.value(forKey: "expiration_date")as? String ?? "DD/MM/YYYY")
            
            cell.lblselectcopy.layer.cornerRadius = 6.0
            cell.lblselectcopy.layer.masksToBounds = true
            
            cell.lblcouponcode.text = String(format: "%@ %@", myAppDelegate.changeLanguage(key: "msg_language230"),strcouponcode)
            cell.lblexpdate.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language231"),strexpdate)
         
            //cell.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
            cell.viewcell.backgroundColor = .white
            
            let lblSeparator = UILabel(frame: CGRect(x: 0, y: 69.5, width: tableView.frame.size.width, height: 0.5))
            lblSeparator.backgroundColor = UIColor.lightGray
            cell.contentView.addSubview(lblSeparator)
            
            return cell;
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvsubscriptionorderview
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMOrderList.object(at: indexPath.section)as! NSDictionary
    
        let strorder_date = String(format: "%@", dic.value(forKey: "order_date")as? String ?? "")
        let strday = String(format: "%@", dic.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dic.value(forKey: "day_name")as? String ?? "")
        
        var strcurrency_code = String(format: "%@", dic.value(forKey: "currency_code")as? String ?? "")
        strcurrency_code = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
        
        let strshipping_amount = String(format: "%@", dic.value(forKey: "shipping_amount")as! CVarArg)
        let strorder_subtotal = String(format: "%@", dic.value(forKey: "order_subtotal")as! CVarArg)
        let strpayment_status = String(format: "%@", dic.value(forKey: "payment_status")as! CVarArg)
        let arrmorder_product = dic.value(forKey: "order_product")as? NSArray ?? []
        
        cell.lbldateday.text = String(format: "%@", strorder_date)
        cell.lbltotal.text = String(format: "%@: %@ %@",myAppDelegate.changeLanguage(key: "msg_language304"),strcurrency_code,strorder_subtotal)
         
        if strshipping_amount != ""
        {
            let fltshipping = Float(strshipping_amount)
            if fltshipping! == 0.00
            {
                cell.lblwarningmessage.textColor = UIColor(named: "darkgreencolor")!
                cell.lblwarningmessage.text = myAppDelegate.changeLanguage(key: "msg_language435")
                cell.viewshippingwarning.isHidden = false
            }
            else{
                cell.lblwarningmessage.textColor = UIColor(named: "darkmostredcolor")!
                cell.lblwarningmessage.text = String(format: "%@ %0.2f %@", myAppDelegate.changeLanguage(key: "msg_language335"),Constants.conn.CutOffSubscriptionOrderTotal,myAppDelegate.changeLanguage(key: "msg_language447"))
                cell.viewshippingwarning.isHidden = false
            }
        }
        else{
            cell.viewshippingwarning.isHidden = true
        }


        cell.imgvstatus.isHidden = true
        cell.lblstatus.isHidden = true
        cell.btnedit.isHidden = true
        cell.btndetail.isHidden = true
        cell.btnAddMore.isHidden = true
        cell.viewupdatetimeslot.isHidden = true
        
        cell.viewcell.layer.borderWidth  = 1.0
        cell.viewcell.layer.borderColor  = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.cornerRadius = 8.0
        cell.viewcell.layer.masksToBounds = true
        
        
        cell.btndetail.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language91")), for: .normal)
        cell.btndetail.layer.cornerRadius = 16.0
        cell.btndetail.layer.masksToBounds = true
        
        
        //IF NO PRODUCT ADDED ON DATE
        if arrmorder_product.count == 0{
            cell.lblwarningmessage.textColor = UIColor(named: "darkgreencolor")!
            cell.lblwarningmessage.text = "+ Add Products"
            cell.viewshippingwarning.isHidden = false
        }
        else{
            cell.btndetail.isHidden = false
        }
        
        cell.btndetail.tag = indexPath.section
        cell.btndetail.addTarget(self, action: #selector(pressDetail), for: .touchUpInside)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tabveditpopupitems
        {
        }
        else if tableView == tabvcouponlistpopup
        {
            let dic = self.arrMCoupons.object(at: indexPath.row)as! NSDictionary
            let strcouponcode = String(format: "%@", dic.value(forKey: "code")as? String ?? "")
            //let strexpdate = String(format: "%@", dic.value(forKey: "expiration_date")as? String ?? "DD/MM/YYYY")
            print("strcouponcode",strcouponcode)
            
            self.txtcouponcode.text = strcouponcode
            
            viewPopupAddNewExistingBG3.removeFromSuperview()
        }
        else
        {
            
        }
    }
    
    //MARK: - press Details Method
    @objc func pressDetail(sender:UIButton)
    {
        let dic = self.arrMOrderList.object(at: sender.tag)as! NSDictionary
        let strorder_date = String(format: "%@", dic.value(forKey: "order_date")as? String ?? "")
        let strday = String(format: "%@", dic.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dic.value(forKey: "day_name")as? String ?? "")
        
        var strcurrency_code = String(format: "%@", dic.value(forKey: "currency_code")as? String ?? "")
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        strcurrency_code = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
        
        let strshipping_amount = String(format: "%@", dic.value(forKey: "shipping_amount")as! CVarArg)
        let strorder_subtotal = String(format: "%@", dic.value(forKey: "order_subtotal")as! CVarArg)
        let strpayment_status = String(format: "%@", dic.value(forKey: "payment_status")as! CVarArg)
        let arrmorder_product = dic.value(forKey: "order_product")as? NSArray ?? []
    
        
        if arrMProductItemsEdit.count > 0{
            arrMProductItemsEdit.removeAllObjects()
        }
        self.arrMProductItemsEdit = NSMutableArray(array: arrmorder_product)
        print("arrMProductItemsEdit --->",self.arrMProductItemsEdit)
        self.createEditpopupDatewiseItems(selecteddateindex: sender.tag, strdate: strorder_date, strday: strdayname, strcurrency: strcurrency_code, strsubtotal: strorder_subtotal, strshippingtotal: strshipping_amount)
    }
    
    //MARK: - create POPUP EDIT ITEMS DATE WISE method
    func createEditpopupDatewiseItems(selecteddateindex:Int,strdate:String,strday:String,strcurrency:String,strsubtotal:String,strshippingtotal:String)
    {
        
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewpopupedititems.layer.cornerRadius = 6.0
        self.viewpopupedititems.layer.masksToBounds = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        lbleditpopupnotes.text = myAppDelegate.changeLanguage(key: "msg_language69")
        lblsubtotaleditpopup.text = myAppDelegate.changeLanguage(key: "msg_language108")
        
     
        self.lbleditpopupDateDay.text = String(format: "%@ (%@)", strdate,strday)
        self.lblsubtotaleditpopupvalue.text = String(format: "%@ %@", strcurrency,strsubtotal)
        
        tabveditpopupitems.register(UINib(nibName: "celltabvprodustitemsedit", bundle: nil), forCellReuseIdentifier: reuseIdentifier2)
        tabveditpopupitems.separatorStyle = .none
        tabveditpopupitems.backgroundView = nil
        tabveditpopupitems.tag = selecteddateindex
        tabveditpopupitems.backgroundColor=UIColor.clear
        tabveditpopupitems.separatorColor=UIColor.clear
        tabveditpopupitems.showsVerticalScrollIndicator = false
        tabveditpopupitems.reloadData()
        
        viewPopupAddNewExistingBG2 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG2.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG2.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG2.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG2.addSubview(self.viewpopupedititems)
        self.viewpopupedititems.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG2)
        
        self.tabveditpopupitems.reloadData()
    }
    @IBAction func presscrosseditpopup(_ sender: Any)
    {
        self.viewpopupedititems.removeFromSuperview()
        viewPopupAddNewExistingBG2.removeFromSuperview()
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
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    //MARK: - press VIEW / APPLY / REMOVE - Coupon Method
    @IBAction func pressViewcouponcode(_ sender: Any)
    {
        self.getallCoupons()
    }
    @IBAction func pressApplycouponcode(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtcouponcode.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language346"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            print("strSUBTOTAL",strSUBTOTAL)
            print("strSHIPPING",strSHIPPING)
            print("strGRANDTOTAL",strGRANDTOTAL)
            
            self.postApplyCouponMethod(strcode: txtcouponcode.text!, strsubtotal: strGRANDTOTAL)
        }
    }
    @IBAction func pressRemovecouponcode(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        print("self.strGRANDTOTAL",self.strGRANDTOTAL)
        print("self.strDISCOUNTAMOUNT",self.strDISCOUNTAMOUNT)
        print("self.strSUBTOTAL",self.strSUBTOTAL)
        print("self.strSHIPPING",self.strSHIPPING)
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language347"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            
            print("Handle Continue Logic here")
            
            var fltupdated = 0.00
            let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
            let fltamount11  = (self.strDISCOUNTAMOUNT as NSString).floatValue
            
            fltupdated = Double(fltamount1 + fltamount11)
            print("fltupdated",fltupdated)
            
            self.strGRANDTOTAL = String(format: "%0.2f",fltupdated)
            
            self.lblgrandtotal.text = String(format: "%@:", myAppDelegate.changeLanguage(key: "msg_language86"))
            self.lblgrandtotalvalue.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltupdated)
            
            //RESET UI DESIGN COUPON VIEW
            self.strDISCOUNTAMOUNT = ""
            self.strDISCOUNTCODE = ""
            
            self.txtcouponcode.isUserInteractionEnabled = true
            self.txtcouponcode.text = ""
            self.btnapplycouponcode.isUserInteractionEnabled = true
            self.btnapplycouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language234")), for: .normal)
            self.btnremovecouponcode.isHidden = true
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    //MARK: - create POPUP COUPON LIST method
    func createCOUPONLIST()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewcouponlist.layer.cornerRadius = 6.0
        self.viewcouponlist.layer.masksToBounds = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        self.lblcouponlistpopupheader.text = appDel.changeLanguage(key: "msg_language228")
        
        tabvcouponlistpopup.register(UINib(nibName: "cellcoupon", bundle: nil), forCellReuseIdentifier: reuseIdentifier3)
        tabvcouponlistpopup.separatorStyle = .none
        tabvcouponlistpopup.backgroundView=nil
        tabvcouponlistpopup.tag = 1111
        tabvcouponlistpopup.backgroundColor=UIColor.clear
        tabvcouponlistpopup.separatorColor=UIColor.clear
        tabvcouponlistpopup.showsVerticalScrollIndicator = false
        
        viewPopupAddNewExistingBG3 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG3.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG3.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG3.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG3.addSubview(self.viewcouponlist)
        self.viewcouponlist.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG3)
        
        self.tabvcouponlistpopup.reloadData()
    }
    @IBAction func presscrosscouponpopup(_ sender: Any)
    {
        viewPopupAddNewExistingBG3.removeFromSuperview()
    }
    
    //MARK: - get All Coupons API method
    func getallCoupons()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod22,"")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
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
                    
                    //print("json --->",json)
                    
                    let dictemp = json as NSDictionary
                    
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            if self.arrMCoupons.count > 0{
                                self.arrMCoupons.removeAllObjects()
                            }
                            
                            let arrmcoupon = json.value(forKey: "list") as? NSArray ?? []
                            self.arrMCoupons = NSMutableArray(array: arrmcoupon)
                            //print("arrMCoupons --->",self.arrMCoupons)
                            
                            if self.arrMCoupons.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language206")
                            }
                            
                            self.createCOUPONLIST()
                        }
                        else
                        {
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
    
    //MARK: - post Apply Coupon code Method
    func postApplyCouponMethod(strcode:String,strsubtotal:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["couponCode": strcode,"subTotal":strsubtotal] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod51)
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
                    
                    DispatchQueue.main.async { [self] in
                        
                        if strsuccess == true
                        {
                            let strsubtotal = String(format: "%@", dictemp.value(forKey: "subtotal")as? String ?? "")
                            let strdiscount_amount = String(format: "%@", dictemp.value(forKey: "discount_amount")as! CVarArg)
                            let strcoupon_code = String(format: "%@", dictemp.value(forKey: "coupon_code")as? String ?? "")
                            
                            self.strDISCOUNTAMOUNT = strdiscount_amount
                            self.strDISCOUNTCODE = strcoupon_code
                            
                            self.lblgrandtotal.text = String(format: "%@: (%@ %@ %@)",myAppDelegate.changeLanguage(key: "msg_language86"),myAppDelegate.changeLanguage(key: "msg_language443"),myAppDelegate.changeLanguage(key: "msg_language481"), self.strDISCOUNTAMOUNT)
                            
                            
                            self.txtcouponcode.isUserInteractionEnabled = false
                            self.btnapplycouponcode.isUserInteractionEnabled = false
                            self.btnapplycouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language361")), for: .normal)
                            self.btnremovecouponcode.isHidden = false

                            var fltTotal3 = 0.00
                            let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
                            let fltamount2  = (self.strDISCOUNTAMOUNT as NSString).floatValue
                            fltTotal3 = Double(fltamount1 - fltamount2)
                            
                            self.strGRANDTOTAL = String(format: "%0.2f",fltTotal3)
                            self.lblgrandtotalvalue.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltTotal3)
                            
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language232"), preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        else
                        {
                            self.btnremovecouponcode.isHidden = true
                            
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
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
