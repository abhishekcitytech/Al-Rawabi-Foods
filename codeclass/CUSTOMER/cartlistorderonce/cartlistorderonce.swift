//
//  cartlistorderonce.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/09/22.
//

import UIKit
import DatePickerDialog

class cartlistorderonce: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    
    
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lbldeliveryslotdate: UILabel!
    @IBOutlet weak var txtchoosedeliverydate: UITextField!
    @IBOutlet weak var imgccalendarchoosedeliverydate: UIImageView!
    @IBOutlet weak var btnmorning: UIButton!
    @IBOutlet weak var btnafternoon: UIButton!
    @IBOutlet weak var btnevening: UIButton!
    @IBOutlet weak var btnupdatelocation: UIButton!
    
    @IBOutlet weak var btnclearall: UIButton!
    
    @IBOutlet weak var lbltime1: UILabel!
    @IBOutlet weak var lbltime2: UILabel!
    @IBOutlet weak var lbltime3: UILabel!
    
    @IBOutlet weak var lbltime111: UILabel!
    @IBOutlet weak var lbltime222: UILabel!
    @IBOutlet weak var lbltime333: UILabel!
    
    
    @IBOutlet weak var tabvcart: UITableView!
    var reuseIdentifier1 = "tabvcellcartorderonce"
    var msg = ""
    
    var arrMcartItems = NSMutableArray()
    
    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblsubtotalvalue: UILabel!
    @IBOutlet weak var lblshippingcharges: UILabel!
    @IBOutlet weak var lblshippingchargesvalue: UILabel!
    @IBOutlet weak var lbldiscount: UILabel!
    @IBOutlet weak var lbldiscountvalue: UILabel!
    @IBOutlet weak var lbltax: UILabel!
    @IBOutlet weak var lbltaxvalue: UILabel!
    @IBOutlet weak var lblordertotal: UILabel!
    @IBOutlet weak var lblordertotalvalue: UILabel!
    @IBOutlet weak var lblearnrewardpointsvalue: UILabel!
    
    @IBOutlet weak var btnremovecoupon: UIButton!
    @IBOutlet weak var btnapplydiscount: UIButton!
    
    let datePicker = DatePickerDialog()
    
    @IBOutlet weak var btnpaycheckout: UIButton!
    @IBOutlet weak var btnkeepshopping: UIButton!
    
    
    var strfromCouponpage = ""
    var strfromCouponpageCouponCode = ""
    
    var arrMAvailbleTimeSlots = NSMutableArray()
    
    var strSelectedTimeSlotID = ""
    var strSelectedTimeSlotNAME = ""
    
    var strcart_id = ""
    
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
        
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let strpaymentcompleted = UserDefaults.standard.value(forKey: "paymentcompleted")as? String ?? ""
        print("strpaymentcompleted",strpaymentcompleted)
        if strpaymentcompleted == "1"{
            UserDefaults.standard.removeObject(forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
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
        
        self.viewoverall.isHidden = true
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        if strbearertoken != ""{
            self.postCartlistOrderonceAPIMethod()
        }else{
            //FIXMELOGINCHECK
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
        
    }
    
    //MARK: - viewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        
        // Do any additional setup after loading the view.
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language114")
        
        self.txtchoosedeliverydate.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language96"))
        
        lblsubtotal.text = myAppDelegate.changeLanguage(key: "msg_language311")
        lblshippingcharges.text = myAppDelegate.changeLanguage(key: "msg_language109")
        lbltax.text = myAppDelegate.changeLanguage(key: "msg_language111")
        lblordertotal.text = myAppDelegate.changeLanguage(key: "msg_language112")
        
        btnremovecoupon.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language328")), for: .normal)
        btnapplydiscount.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language113")), for: .normal)
        btnpaycheckout.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        
        btnapplydiscount.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right

        btnkeepshopping.layer.borderWidth = 1.0
        btnkeepshopping.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnkeepshopping.layer.cornerRadius = 16.0
        btnkeepshopping.layer.masksToBounds = true
        
        self.btnkeepshopping.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language367")), for: .normal)
        
        self.btnclearall.isHidden = true
        self.btnclearall.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language334")), for: .normal)
        
        btnclearall.layer.cornerRadius = 18.0
        btnclearall.layer.masksToBounds = true
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        //self.navigationItem.leftBarButtonItem = back
        
        //FIXMEACCOUNT BARBUTTON NAVBAR
        /*let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "accounticon"), for: .normal)
        button.addTarget(self, action: #selector(pressAccount), for: .touchUpInside)
        button.frame = CGRectMake(0, 0, 110, 31)
        button.imageEdgeInsets = UIEdgeInsets(top: -1, left: 36, bottom: 1, right: -28)//move image to the right
        let label = UILabel(frame: CGRectMake(0, 5, 75, 20))
        label.font = UIFont(name: "NunitoSans-Regular", size: 14)
        label.text = myAppDelegate.changeLanguage(key: "msg_language146")
        label.textAlignment = .center
        label.textColor = UIColor(named: "themecolor")!
        label.backgroundColor =   .clear
        button.addSubview(label)
        button.backgroundColor = .white
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton*/
        
        let accounticon = UIBarButtonItem(image: UIImage(named: "accounticon"), style: .plain, target: self, action: #selector(pressAccount))
        accounticon.tintColor = UIColor(named: "themecolor")!
        self.navigationItem.rightBarButtonItem = accounticon
        
        txtchoosedeliverydate.layer.borderWidth = 1.0
        txtchoosedeliverydate.layer.borderColor = UIColor(named: "darkgreencolor")!.cgColor
        txtchoosedeliverydate.layer.cornerRadius = 6.0
        txtchoosedeliverydate.layer.masksToBounds = true
        
        btnupdatelocation.layer.cornerRadius = 5.0
        btnupdatelocation.layer.masksToBounds = true
        
        btnpaycheckout.layer.cornerRadius = 16.0
        btnpaycheckout.layer.masksToBounds = true
        
        tabvcart.register(UINib(nibName: "tabvcellcartorderonce", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvcart.separatorStyle = .none
        tabvcart.backgroundView=nil
        tabvcart.backgroundColor=UIColor.clear
        tabvcart.separatorColor=UIColor.clear
        tabvcart.showsVerticalScrollIndicator = false
        
        if lbldiscountvalue.text == ""{
            lbldiscountvalue.isHidden = true
            btnapplydiscount.isHidden = false
            btnremovecoupon.isHidden = true
        }
        else{
            lbldiscountvalue.isHidden = false
            btnapplydiscount.isHidden = true
            btnremovecoupon.isHidden = false
        }
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Account Method
    @objc func pressAccount()
    {
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        if strbearertoken == ""{
            let obj = loginclass(nibName: "loginclass", bundle: nil)
            obj.strislogin = "100"
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else{
            let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                myAppDelegate.tabBarController.selectedIndex = 4
            }
            else{
                let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                myAppDelegate.tabBarController.selectedIndex = 0
            }
        }
    }
    
    //MARK: - press KeepShopping method
    @IBAction func pressKeepShopping(_ sender: Any)
    {
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
    
    //MARK: - press Pay&Checkout method
    @IBAction func presspaycheckout(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        if txtchoosedeliverydate.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language316"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if strSelectedTimeSlotID.count == 0
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language317"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            
            self.postTimeSlotDeliveryDateMethod()
        }
        
    }
    
    //MARK: - press Apply Discount method
    @IBAction func pressApplyDiscount(_ sender: Any)
    {
        let ctrl = couponlist(nibName: "couponlist", bundle: nil)
        ctrl.strselectedcartid = self.strcart_id
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Remove Discount method
    @IBAction func pressRemoveDiscount(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language347"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            self.getRemoveCouponAPIMethod()
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    //MARK: - press Morning / Afternoon / Evening Method
    @IBAction func pressmorning(_ sender: Any) {
        btnmorning.isSelected = true
        btnafternoon.isSelected = false
        btnevening.isSelected = false
        
        for x in 0 ..< self.arrMAvailbleTimeSlots.count
        {
            let dictemp = self.arrMAvailbleTimeSlots.object(at: x)as? NSDictionary
            let strslotid = String(format: "%@", dictemp?.value(forKey: "interval_id")as! CVarArg)
            let strname = String(format: "%@", dictemp?.value(forKey: "label")as? String ?? "")
            
            if strname.containsIgnoreCase("Morning"){
                self.strSelectedTimeSlotID = strslotid
                self.strSelectedTimeSlotNAME = strname
                return
            }
        }
    }
    @IBAction func pressafternoon(_ sender: Any) {
        btnmorning.isSelected = false
        btnafternoon.isSelected = true
        btnevening.isSelected = false
        
        for x in 0 ..< self.arrMAvailbleTimeSlots.count
        {
            let dictemp = self.arrMAvailbleTimeSlots.object(at: x)as? NSDictionary
            let strslotid = String(format: "%@", dictemp?.value(forKey: "interval_id")as! CVarArg)
            let strname = String(format: "%@", dictemp?.value(forKey: "label")as? String ?? "")
            
            if strname.containsIgnoreCase("Afternoon"){
                self.strSelectedTimeSlotID = strslotid
                self.strSelectedTimeSlotNAME = strname
                return
            }
        }
    }
    @IBAction func pressevening(_ sender: Any) {
        btnmorning.isSelected = false
        btnafternoon.isSelected = false
        btnevening.isSelected = true
        
        for x in 0 ..< self.arrMAvailbleTimeSlots.count
        {
            let dictemp = self.arrMAvailbleTimeSlots.object(at: x)as? NSDictionary
            let strslotid = String(format: "%@", dictemp?.value(forKey: "interval_id")as! CVarArg)
            let strname = String(format: "%@", dictemp?.value(forKey: "label")as? String ?? "")
            
            if strname.containsIgnoreCase("Evening"){
                self.strSelectedTimeSlotID = strslotid
                self.strSelectedTimeSlotNAME = strname
                return
            }
        }
    }
    
    //MARK: -  press update location method
    @IBAction func pressupdatelocation(_ sender: Any) {
        
    }
    
    //MARK: - press Clear All method
    @IBAction func pressClearAllcart(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language475"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            self.postCLEARALLCARTMethod()
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    //MARK: - show Delivery Date picker method
    func datePickerTapped()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let timestring = df.string(from: date)
        print("timestring",timestring)
        
        var  nextdate = Date()
        let s1 = timestring
        let s2 = Constants.conn.CutOffTime //"15:00:00"
        if df.date(from: s1)! > df.date(from: s2)!
        {
            print("Over 15:00:00 - Its over 3 PM")
            
            let today = Date()
            nextdate = Calendar.current.date(byAdding: .day, value: +2, to: today)!
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd/MM/yyyy"
            print("strdate date %@",nextdate)
        }
        else
        {
            print("Within 15:00:00 - Its within 3 PM")
            
            let today = Date()
            nextdate = Calendar.current.date(byAdding: .day, value: +1, to: today)!
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd/MM/yyyy"
            print("strdate date %@",nextdate)
        }
        
        
        
        let next10days = Calendar.current.date(byAdding: .day, value: +10, to: nextdate)!
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        let maxdate = formatter1.string(from: next10days)
        print("maxdate",maxdate)
        
        datePicker.show(myAppDelegate.changeLanguage(key: "msg_language105"),
                        doneButtonTitle: myAppDelegate.changeLanguage(key: "msg_language106"),
                        cancelButtonTitle: myAppDelegate.changeLanguage(key: "msg_language107"),
                        minimumDate: nextdate,
                        maximumDate: next10days,
                        datePickerMode: .date) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                print("action")
                self.txtchoosedeliverydate.text = formatter.string(from: dt)
            }
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
        if textField == self.txtchoosedeliverydate {
            datePickerTapped()
            return false
        }
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
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMcartItems.count == 0 {
            self.tabvcart.setEmptyMessage(msg)
        } else {
            self.tabvcart.restore()
        }
        return arrMcartItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 116
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 2)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 2)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! tabvcellcartorderonce
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        cell.viewcell.layer.cornerRadius = 10.0
        cell.viewcell.layer.masksToBounds = true
        
        let dict = arrMcartItems.object(at: indexPath.section)as! NSDictionary
        
        //let strproductid = String(format: "%@", dict.value(forKey: "product_id") as! CVarArg)
        let strname = String(format: "%@", dict.value(forKey: "name") as? String ?? "")
        let strprice = String(format: "%@", dict.value(forKey: "price_incl_tax") as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qty") as! CVarArg)
        //let stritem_id = String(format: "%@", dict.value(forKey: "item_id") as? String ?? "")
        //let strquote_id = String(format: "%@", dict.value(forKey: "quote_id") as? String ?? "")
        //let strproduct_url = String(format: "%@", dict.value(forKey: "product_url") as? String ?? "")
        let strimageurl = String(format: "%@", dict.value(forKey: "imageurl") as? String ?? "")
        
        let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
        print("strFinalurl",strFinalurl)
        cell.imgvprod.contentMode = .scaleAspectFit
        cell.imgvprod.imageFromURL(urlString: strFinalurl)
        
        cell.lblproductname.text = strname
        cell.lblproductmessage.text = ""
        
        if strprice != ""{
            let fltprice = Float(strprice)
            cell.lblprodprice.text = String(format: "%@ %.2f",myAppDelegate.changeLanguage(key: "msg_language481"),fltprice!)
        }
        
        let fltqtyyy  = (strqty as NSString).floatValue
        print("fltqtyyy",fltqtyyy)
        
        cell.txtqty.text = String(format: "%0.0f", fltqtyyy)
        
        cell.lblincludetax.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language474"))
        
        cell.viewcell.layer.cornerRadius = 8.0
        cell.viewcell.layer.masksToBounds = true
        
        //CELL PLUS MINUS
        cell.viewplusminus.layer.cornerRadius = 14.0
        cell.viewplusminus.layer.borderWidth = 1.0
        cell.viewplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cell.viewplusminus.layer.masksToBounds = true
        
        cell.txtqty.layer.cornerRadius = 1.0
        cell.txtqty.layer.borderWidth = 1.0
        cell.txtqty.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cell.txtqty.layer.masksToBounds = true
        
        cell.btnplus.tag = indexPath.section
        cell.btnminus.tag = indexPath.section
        cell.btnplus.addTarget(self, action: #selector(pressplus), for: .touchUpInside)
        cell.btnminus.addTarget(self, action: #selector(pressminus), for: .touchUpInside)
        
        cell.btntrash.tag = indexPath.section
        cell.btntrash.addTarget(self, action: #selector(pressRemove), for: .touchUpInside)
        
        
        //FIXMESTOCK
        let strstock = String(format: "%@", dict.value(forKey: "stock") as! CVarArg)
        let strstock_status = String(format: "%@", dict.value(forKey: "stock_status") as? String ?? "")
        print("strstock",strstock)
        print("strstock_status",strstock_status)
        
        cell.lbloutofstock.layer.borderWidth = 1.0
        cell.lbloutofstock.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.lbloutofstock.layer.cornerRadius = 14.0
        cell.lbloutofstock.layer.masksToBounds = true
        
        if strstock == "0"{
            //Out of stock
            cell.lbloutofstock.isHidden = false
            cell.viewplusminus.isHidden = true
            cell.lbloutofstock.text = strstock_status
            
        }else{
            //in stock
            cell.lbloutofstock.isHidden = true
            cell.viewplusminus.isHidden = false
        }
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    //MARK: - press Plus Method
    @objc func pressplus(sender:UIButton)
    {
        let dict = arrMcartItems.object(at: sender.tag)as! NSDictionary
        //let strproductid = String(format: "%@", dict.value(forKey: "product_id") as! CVarArg)
        //let strname = String(format: "%@", dict.value(forKey: "name") as? String ?? "")
        //let strprice = String(format: "%@", dict.value(forKey: "price_incl_tax") as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qty") as! CVarArg)
        let stritem_id = String(format: "%@", dict.value(forKey: "item_id") as? String ?? "")
        let strquote_id = String(format: "%@", dict.value(forKey: "quote_id") as? String ?? "")
        
        var intqty = (strqty as NSString).intValue
        if intqty >= 0{
            intqty = intqty + 1
        }
        else{
            //cart item 0
        }
        print("intqty",intqty as Any)
        
        self.postCartListUpdateQTYItemAPIMethod(stritemid: stritem_id, strquoteid: strquote_id, strproductQty: String(format: "%d", intqty))
    }
    //MARK: - press Minus Method
    @objc func pressminus(sender:UIButton)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dict = arrMcartItems.object(at: sender.tag)as! NSDictionary
        //let strproductid = String(format: "%@", dict.value(forKey: "product_id") as! CVarArg)
        //let strname = String(format: "%@", dict.value(forKey: "name") as? String ?? "")
        //let strprice = String(format: "%@", dict.value(forKey: "price_incl_tax") as? String ?? "")
        let strqty = String(format: "%@", dict.value(forKey: "qty") as! CVarArg)
        let stritem_id = String(format: "%@", dict.value(forKey: "item_id") as? String ?? "")
        let strquote_id = String(format: "%@", dict.value(forKey: "quote_id") as? String ?? "")
        
        var intqty = (strqty as NSString).intValue
        if intqty >= 0{
            intqty = intqty - 1
        }
        print("intqty",intqty as Any)
        
        if intqty < 1
        {
            //cart item 0
            
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
        else{
            self.postCartListUpdateQTYItemAPIMethod(stritemid: stritem_id, strquoteid: strquote_id, strproductQty: String(format: "%d", intqty))
        }
        
    }
    //MARK: - press Remove Method
    @objc func pressRemove(sender:UIButton)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dict = arrMcartItems.object(at: sender.tag)as! NSDictionary
        //let strproductid = String(format: "%@", dict.value(forKey: "product_id") as! CVarArg)
        let stritem_id = String(format: "%@", dict.value(forKey: "item_id") as? String ?? "")
        let strquote_id = String(format: "%@", dict.value(forKey: "quote_id") as? String ?? "")
        
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
    
    
    
    //MARK: -  press TAP GESTURE DISCOUNT OPTION AFTER APPLIED !ST TIME
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        
        let ctrl = couponlist(nibName: "couponlist", bundle: nil)
        ctrl.strselectedcartid = self.strcart_id
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    //MARK: - post Cart List OrderOnce API Method
    func postCartlistOrderonceAPIMethod()
    {
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["language": strLangCode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod17)
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
                    self.viewoverall.isHidden = false
                    self.view.activityStopAnimating()
                    
                    self.getAvailbleTimeSlotsAPIMethod()
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
                        
                        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        self.viewoverall.isHidden = false
                        
                        if self.arrMcartItems.count > 0{
                            self.arrMcartItems.removeAllObjects()
                        }
                        
                        if strsuccess == true
                        {
                            let arrmproducts = json.value(forKey: "cart_items") as? NSArray ?? []
                            self.arrMcartItems = NSMutableArray(array: arrmproducts)
                            //print("arrMcartItems --->",self.arrMcartItems)
                            
                            self.strcart_id = String (format: "%@", json.value(forKey: "cart_id")as! CVarArg)
                            print("self.strcart_id",self.strcart_id)
                            
                            if self.arrMcartItems.count == 0{
                                
                                self.lblsubtotalvalue.text = ""
                                self.lblshippingchargesvalue.text = ""
                                self.lblordertotalvalue.text = ""
                                self.lbltaxvalue.text = ""
                                self.lbldiscountvalue.text = ""
                                
                                self.viewtop.isHidden = true
                                self.viewbottom.isHidden = true
                                self.btnpaycheckout.isHidden = true
                                self.btnkeepshopping.isHidden = true
                                
                                self.btnclearall.isHidden = true
                            }
                            else
                            {
                                self.viewtop.isHidden = false
                                self.viewbottom.isHidden = false
                                self.btnpaycheckout.isHidden = false
                                self.btnkeepshopping.isHidden = false
                                
                                self.btnclearall.isHidden = false
                                
                                let strtax = String (format: "%@", dictemp.value(forKey: "tax")as? String ?? "0.00")
                                
                                //subtotal_incl_tax subtotal
                                let str1 = String (format: "%@", dictemp.value(forKey: "subtotal_incl_tax")as! CVarArg)
                                let str2 = String (format: "%@", dictemp.value(forKey: "shippingAmount")as? String ?? "0.00")
                                let str3 = String (format: "%@", dictemp.value(forKey: "grandtotal")as! CVarArg)
                                
                                print("str1",str1)
                                print("str2",str2)
                                print("str3",str3)
                                
                                let str5 = String (format: "%@", dictemp.value(forKey: "discount_value")as! CVarArg)
                                let str6 = String (format: "%@", dictemp.value(forKey: "coupon_code")as? String ?? "")
                                
                                var str4 = String (format: "%@", dictemp.value(forKey: "currency_code")as? String ?? "")
                                str4 = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
                                
                                let strearn_point = String (format: "%@", dictemp.value(forKey: "earn_point")as? String ?? "")
                                print("strearn_point",strearn_point)
                                
                                if strearn_point.count > 0{
                                    
                                    let splitStringArray = strearn_point.split(separator: " ", maxSplits: 1).map(String.init)
                                    print(splitStringArray)
                                    let str1pointsvalue = splitStringArray[0]
                                    let str2resttext = splitStringArray[1]
                                    
                                    self.lblearnrewardpointsvalue.text = String(format: "%@ %@ %@",myAppDelegate.changeLanguage(key: "msg_language318"), str1pointsvalue,myAppDelegate.changeLanguage(key: "msg_language319"))
                                }
                                else{
                                    self.lblearnrewardpointsvalue.text = ""
                                }
                                
                                
                                
                                
                                let intstr1 = Float(str1)
                                let intstr2 = Float(str2)
                                let intstr3 = Float(str3)
                                let intstr4 = Float(str5)
                                let intstr5 = Float(strtax)
                                
                                if intstr1 != nil{
                                    self.lblsubtotalvalue.text = String(format: "%@ %.2f",str4,intstr1!)
                                }
                                
                                if intstr2 != nil{
                                    self.lblshippingchargesvalue.text = String(format: "%@ %.2f",str4,intstr2!)
                                }
                                
                                if intstr3 != nil{
                                    self.lblordertotalvalue.text = String(format: "%@ %.2f",str4,intstr3!)
                                }
                                
                                if intstr5 != nil{
                                    self.lbltaxvalue.text = String(format: "%@ %.2f",str4,intstr5!)
                                }
                                
                                
                                
                                
                                
                                //FIXME
                                if str5 != "0" || str6 != ""
                                {
                                    //DISCOUNT SHOW
                                    self.lbldiscountvalue.isHidden = false
                                    self.lbldiscountvalue.text = String(format: "- %@ %.2f",str4,intstr4!)
                                    self.btnapplydiscount.isHidden = true
                                    self.btnremovecoupon.isHidden = false
                                    
                                    self.lbldiscount.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language110"), str6)
                                    
                                    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                                    self.lbldiscount.isUserInteractionEnabled = true
                                    self.lbldiscount.addGestureRecognizer(tap)
                                    
                                    self.lbldiscount.textColor = UIColor(named: "themecolor")!
                                    self.lbldiscount.underline()
                                }
                                else
                                {
                                    //DISCOUNT HIDE
                                    self.lbldiscountvalue.isHidden = true
                                    self.btnapplydiscount.isHidden = false
                                    self.btnremovecoupon.isHidden = true
                                    
                                    self.lbldiscount.text = myAppDelegate.changeLanguage(key: "msg_language110")
                                    self.lbldiscountvalue.text = ""
                                    
                                    self.lbldiscount.textColor = .darkGray
                                }
                                
                                
                                //IF NULL VALUE THEN ALERT WILL SHOW
                                if intstr1 == nil || intstr2 == nil || intstr3 == nil || intstr5 == nil
                                {
                                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                                    self.present(uiAlert, animated: true, completion: nil)
                                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                        print("Click of default button")
                                    }))
                                    self.viewtop.isHidden = true
                                    self.viewbottom.isHidden = true
                                    self.btnpaycheckout.isHidden = true
                                    self.btnkeepshopping.isHidden = true
                                    self.btnclearall.isHidden = true
                                }
                                
                            }
                            
                            
                            let strout_of_stock_mark = String (format: "%@", json.value(forKey: "out_of_stock_mark")as! CVarArg)
                            print("strout_of_stock_mark",strout_of_stock_mark)
                            if strout_of_stock_mark == "1"{
                                self.btnpaycheckout.isUserInteractionEnabled = false
                                self.btnpaycheckout.backgroundColor = UIColor(named: "graybordercolor")!
                                self.btnpaycheckout.setTitleColor(.darkGray, for: .normal)
                            }else{
                                self.btnpaycheckout.isUserInteractionEnabled = true
                                self.btnpaycheckout.backgroundColor = UIColor(named: "greencolor")!
                                self.btnpaycheckout.setTitleColor(.white, for: .normal)
                            }
                        }
                        else
                        {
                            self.lblsubtotalvalue.text = ""
                            self.lblshippingchargesvalue.text = ""
                            self.lblordertotalvalue.text = ""
                            self.lbltaxvalue.text = ""
                            self.lbldiscountvalue.text = ""
                            
                            self.viewtop.isHidden = true
                            self.viewbottom.isHidden = true
                            self.btnpaycheckout.isHidden = true
                            self.btnkeepshopping.isHidden = true
                            self.btnclearall.isHidden = true
                            
                            /*let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                             self.present(uiAlert, animated: true, completion: nil)
                             uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                             print("Click of default button")
                             }))*/
                        }
                        
                        if self.arrMcartItems.count == 0{
                            self.msg = myAppDelegate.changeLanguage(key: "msg_language117")
                            self.btnkeepshopping.isHidden = false
                            self.btnkeepshopping.frame = CGRect(x: self.btnkeepshopping.frame.origin.x, y: self.viewtop.frame.minY, width: self.btnkeepshopping.frame.size.width, height: self.btnkeepshopping.frame.size.height)
                        }
                        else
                        {
                            self.btnkeepshopping.isHidden = false
                            self.btnkeepshopping.frame = CGRect(x: self.btnkeepshopping.frame.origin.x, y: self.viewtop.frame.maxY, width: self.btnkeepshopping.frame.size.width, height: self.btnkeepshopping.frame.size.height)
                        }
                        self.tabvcart.reloadData()
                        
                        self.getAvailbleTimeSlotsAPIMethod()
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
                    self.viewoverall.isHidden = false
                    
                    self.lblsubtotalvalue.text = ""
                    self.lblshippingchargesvalue.text = ""
                    self.lblordertotalvalue.text = ""
                    self.lbltaxvalue.text = ""
                    self.lbldiscountvalue.text = ""
                    
                    self.viewtop.isHidden = true
                    self.viewbottom.isHidden = true
                    self.btnpaycheckout.isHidden = true
                    self.btnkeepshopping.isHidden = true
                    
                    self.view.activityStopAnimating()
                    
                    self.getAvailbleTimeSlotsAPIMethod()
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
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
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
                            if self.arrMcartItems.count > 0{
                                self.arrMcartItems.removeAllObjects()
                            }
                            
                            self.postCartlistOrderonceAPIMethod()
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
                            if self.arrMcartItems.count > 0{
                                self.arrMcartItems.removeAllObjects()
                            }
                            
                            self.postCartlistOrderonceAPIMethod()
                        }
                        else{
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
                    self.view.isUserInteractionEnabled = true
                    //self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    //MARK: - get Availble Time Slots API method
    func getAvailbleTimeSlotsAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod72)
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
                    
                    let strbearertoken1 = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                    if strbearertoken1 != ""{
                        self.getOrderOnceCartCountAPIMethod()
                    }
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
                            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            if self.arrMAvailbleTimeSlots.count > 0{
                                self.arrMAvailbleTimeSlots.removeAllObjects()
                            }
                            let arrmproducts = json.value(forKey: "timeslot") as? NSArray ?? []
                            self.arrMAvailbleTimeSlots = NSMutableArray(array: arrmproducts)
                            //print("arrMAvailbleTimeSlots --->",self.arrMAvailbleTimeSlots)
                            
                            for x in 0 ..< self.arrMAvailbleTimeSlots.count
                            {
                                let dictemp = self.arrMAvailbleTimeSlots.object(at: x)as? NSDictionary
                                let strname = String(format: "%@", dictemp?.value(forKey: "label")as? String ?? "")
                                let strtime1 = String(format: "%@", dictemp?.value(forKey: "from")as? String ?? "")
                                let strtime2 = String(format: "%@", dictemp?.value(forKey: "to")as? String ?? "")
                                
                                var str1 = ""
                                var str2 = ""
                                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                                if (strLangCode == "en")
                                {
                                    str1 = strtime1
                                    str2 = strtime2
                                }
                                else
                                {
                                    if strtime1.containsIgnoreCase("AM"){
                                        str1 = strtime1.replacingOccurrences(of: "AM", with: "")
                                        str1 = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language502"),str1)
                                    }
                                    else if strtime1.containsIgnoreCase("PM"){
                                        str1 = strtime1.replacingOccurrences(of: "PM", with: "")
                                        str1 = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language503"),str1)
                                    }
                                    
                                    if strtime2.containsIgnoreCase("AM"){
                                        str2 = strtime2.replacingOccurrences(of: "AM", with: "")
                                        str2 = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language502"),str2)
                                    }
                                    else if strtime2.containsIgnoreCase("PM"){
                                        str2 = strtime2.replacingOccurrences(of: "PM", with: "")
                                        str2 = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language503"),str2)
                                    }
                                }
                                
                                if strname.containsIgnoreCase("Morning"){
                                    self.lbltime111.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language99"))
                                    if (strLangCode == "en")
                                    {
                                        self.lbltime1.text = String(format: "%@-%@", str1,str2)
                                    }
                                    else{
                                        self.lbltime1.text = String(format: "%@-%@", str2,str1)
                                    }
                                    
                                }
                                else if strname.containsIgnoreCase("Afternoon"){
                                    self.lbltime222.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language100"))
                                    if (strLangCode == "en")
                                    {
                                        self.lbltime2.text = String(format: "%@-%@", str1,str2)
                                    }
                                    else{
                                        self.lbltime2.text = String(format: "%@-%@", str2,str1)
                                    }
                                    
                                }
                                else if strname.containsIgnoreCase("Evening"){
                                    self.lbltime333.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language101"))
                                    if (strLangCode == "en")
                                    {
                                        self.lbltime3.text = String(format: "%@-%@", str1,str2)
                                    }
                                    else{
                                        self.lbltime3.text = String(format: "%@-%@", str2,str1)
                                    }
                                    
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
                        
                        let strbearertoken1 = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                        if strbearertoken1 != ""{
                            self.getOrderOnceCartCountAPIMethod()
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
                    
                    let strbearertoken1 = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                    if strbearertoken1 != ""{
                        self.getOrderOnceCartCountAPIMethod()
                    }
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Time Slot API Method
    func postTimeSlotDeliveryDateMethod()
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
        
        let parameters = ["date": txtchoosedeliverydate.text!,
                          "comment": "",
                          "timeintervalid": strSelectedTimeSlotID] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod54)
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
                            UserDefaults.standard.set("1", forKey: "payfromOrderonce")
                            UserDefaults.standard.synchronize()
                            let ctrl = OrderOnceSelectShippingAddress(nibName: "OrderOnceSelectShippingAddress", bundle: nil)
                            self.navigationController?.pushViewController(ctrl, animated: true)
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
    
    //MARK: - get remove Coupon API method
    func getRemoveCouponAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod104)
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
                            if self.arrMcartItems.count > 0{
                                self.arrMcartItems.removeAllObjects()
                            }
                            
                            self.postCartlistOrderonceAPIMethod()
                        }
                        else{
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
                                
                                self.tabBarController?.repositionBadges()
                                //self.setupRightBarCartBagDesignMethod(intcountOrder: strcount)
                            }
                            else{
                                print("Not found!")
                                
                                UserDefaults.standard.set("0", forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                
                                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                                if (strLangCode == "en")
                                {
                                    (myAppDelegate.tabBarController.tabBar.items![3] ).badgeValue = ""
                                }else{
                                    (myAppDelegate.tabBarController.tabBar.items![1] ).badgeValue = ""
                                }
                                //self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
                                
                                self.tabBarController?.repositionBadges()
                                
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
    
    //MARK: - post Clear All cart API Method
    func postCLEARALLCARTMethod()
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
        
        /*let parameters = ["date": txtchoosedeliverydate.text!,
         "comment": "",
         "timeintervalid": strSelectedTimeSlotID] as [String : Any]*/
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod110)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        /*let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
         let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
         print("json string = \(jsonString)")
         request.httpBody = jsonData as Data*/
        
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
                            if self.arrMcartItems.count > 0{
                                self.arrMcartItems.removeAllObjects()
                            }
                            
                            self.postCartlistOrderonceAPIMethod()
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
    
}
extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
extension UITabBarController {
    func repositionBadgeLayer(_ badgeView: UIView) {
        if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
            badgeView.layer.transform = CATransform3DIdentity
            badgeView.layer.transform = CATransform3DMakeTranslation(1.0, +10.0, 1.0)
        }
    }
    
    func repositionBadges(tab: Int? = nil) {
        if let tabIndex = tab {
            for badgeView in self.tabBar.subviews[tabIndex].subviews {
                repositionBadgeLayer(badgeView)
            }
        } else {
            for tabBarSubviews in self.tabBar.subviews {
                for badgeView in tabBarSubviews.subviews {
                    repositionBadgeLayer(badgeView)
                }
            }
        }
    }
}
