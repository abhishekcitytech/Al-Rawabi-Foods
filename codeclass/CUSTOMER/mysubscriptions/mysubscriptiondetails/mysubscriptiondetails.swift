//
//  mysubscriptiondetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 09/11/22.
//

import UIKit
import DatePickerDialog

class mysubscriptiondetails: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblsubscriptionid: UILabel!
    
    @IBOutlet weak var imgvplan: UIImageView!
    
    @IBOutlet weak var viewstartdate: UIView!
    @IBOutlet weak var txtstartdate: UITextField!
    @IBOutlet weak var imgvstartcal: UIImageView!
    
    @IBOutlet weak var viewenddate: UIView!
    @IBOutlet weak var txtenddate: UITextField!
    @IBOutlet weak var imgvendcal: UIImageView!
    
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var btnpause: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnUpdateDate: UIButton!
    
    
    @IBOutlet weak var tabvmysubscription: UITableView!
    var reuseIdentifier1 = "celltabvsubscriptionorderview"
    var msg = ""
    
    
    
    
    //POPUP EDIT PENCIL ITEMS DATE SPECIFIC
    @IBOutlet var viewpopupedititems: UIView!
    @IBOutlet weak var lbleditpopupDateDay: UILabel!
    @IBOutlet weak var btncrosseditpopup: UIButton!
    @IBOutlet weak var tabveditpopupitems: UITableView!
    @IBOutlet weak var lbleditpopupnotes: UILabel!
    @IBOutlet weak var lblsubtotaleditpopup: UILabel!
    @IBOutlet weak var lblsubtotaleditpopupvalue: UILabel!
    var reuseIdentifier2 = "celltabvprodustitemsedit"
    var viewPopupAddNewExistingBG2 = UIView()
    var iseditpopupfunction = false
    
    //DELIVERY SLOTS DATE
    @IBOutlet var viewdateslotsdeliverypopup: UIView!
    @IBOutlet weak var lbldeliveryslotpopupHeader: UILabel!
    @IBOutlet weak var coltimeslots: UICollectionView!
    var reuseIdentifier3 = "celltimeslots"
    @IBOutlet weak var btncrossdateslotspopup: UIButton!
    var viewPopupAddNewExistingBG3 = UIView()
    
    var arrMAvailbleTimeSlots = NSMutableArray()
    
    
    var arrMProductItemsEdit = NSMutableArray()
    
    var diclistvalue = NSDictionary()
    var dicMSubscriptionDetails =  NSMutableDictionary()
    var arrMsubscription_order = NSMutableArray()
    
    var isEditStartDate = false
    var isEditEndDate = false
    
    let datePicker1 = DatePickerDialog()
    let datePicker2 = DatePickerDialog()
    
    var strselectedplan = ""
    
    
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
        
        /*
         '0' = 'Pending',
         '1' = 'Active',
         '2' = 'Paused',
         '3' = 'Expired',
         '4' = 'Cancel'
         */
        
        print("diclistvalue",diclistvalue)
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        let strsubscription_increment_id = String(format: "%@", diclistvalue.value(forKey: "subscription_increment_id")as? String ?? "")
        let strsubscription_plan = String(format: "%@", diclistvalue.value(forKey: "subscription_plan")as? String ?? "")
        let strsubscription_start_date = String(format: "%@", diclistvalue.value(forKey: "subscription_start_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_end_date = String(format: "%@", diclistvalue.value(forKey: "subscription_end_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_status = String(format: "%@", diclistvalue.value(forKey: "subscription_status")as? String ?? "")
        let strsubscription_status_code = String(format: "%@", diclistvalue.value(forKey: "subscription_status_code")as? String ?? "")
        //let strsubscription_renewal_status = String(format: "%@", diclistvalue.value(forKey: "subscription_renewal_status")as? String ?? "")
        
        self.lblsubscriptionid.text = String(format: "# %@", strsubscription_increment_id)
        
        self.txtstartdate.text = strsubscription_start_date
        self.txtenddate.text = strsubscription_end_date
        
        self.lblstatus.text = strsubscription_status
        
        self.strselectedplan = strsubscription_plan
        
        let  strplanidentify = strsubscription_plan
        print("strplanidentify",strplanidentify)
        if strplanidentify.containsIgnoreCase("daily") || strplanidentify.containsIgnoreCase("يوميًا")
        {
            let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                self.imgvplan.image = UIImage(named: "rb-daily-en")
            }
            else
            {
                self.imgvplan.image = UIImage(named: "rb-daily-ar")
            }
        }else if strplanidentify.containsIgnoreCase("weekly") || strplanidentify.containsIgnoreCase("أسبوعي")
        {
            let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                self.imgvplan.image = UIImage(named: "rb-weekly-en")
            }
            else
            {
                self.imgvplan.image = UIImage(named: "rb-weekly-ar")
            }
        }else if strplanidentify.containsIgnoreCase("monthly") || strplanidentify.containsIgnoreCase("شهريا")
        {
            let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                self.imgvplan.image = UIImage(named: "rb-monthly-en")
            }
            else
            {
                self.imgvplan.image = UIImage(named: "rb-monthly-ar")
            }
        }
        
        
        self.lblstatus.layer.cornerRadius = 14.0
        self.lblstatus.layer.masksToBounds = true
        
        print("strsubscription_status_code",strsubscription_status_code)
        if strsubscription_status_code == "0"{
            //Pending
            lblstatus.backgroundColor =  UIColor(named: "orangecolor")!
            
            btnpause.isHidden = true
            btncancel.isHidden = true
        }
        else if strsubscription_status_code == "1"{
            //Active
            lblstatus.backgroundColor =  UIColor(named: "themecolor")!
            
            btnpause.isHidden = false
            btncancel.isHidden = false
            
            btnpause.backgroundColor = UIColor(named: "greencolor")!
            btnpause.tag = 200
            btnpause.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language430")), for: .normal)
        }
        else if strsubscription_status_code == "2"{
            //Paused
            lblstatus.backgroundColor =  UIColor(named: "greencolor")!
            
            btnpause.isHidden = false
            btncancel.isHidden = false
            
            btnpause.backgroundColor = .blue
            btnpause.tag = 100
            btnpause.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language431")), for: .normal)
        }
        else if strsubscription_status_code == "3"{
            //Expired
            lblstatus.backgroundColor =  UIColor(named: "lightblue")!
            
            btnpause.backgroundColor = .red
            btnpause.tag = 300
            btnpause.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language432")), for: .normal)
            
            btnpause.isHidden = true
            btncancel.isHidden = true
        }
        else if strsubscription_status_code == "4"{
            //Cancel
            lblstatus.backgroundColor =  UIColor(named: "darkredcolor")!
            
            btnpause.isHidden = true
            btncancel.isHidden = true
        }
        
        btncancel.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language77")), for: .normal)
        
        self.getallmysubscriptionDetail(strsubscriptionid: strsubscription_id)
        
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
        
        btnpause.layer.cornerRadius = 16.0
        btnpause.layer.masksToBounds = true
        btncancel.layer.cornerRadius = 16.0
        btncancel.layer.masksToBounds = true
        
        viewstartdate.layer.cornerRadius = 3.0
        viewstartdate.layer.masksToBounds = true
        viewenddate.layer.cornerRadius = 3.0
        viewenddate.layer.masksToBounds = true
        
        btnUpdateDate.layer.cornerRadius = 4.0
        btnUpdateDate.layer.masksToBounds = true
        btnUpdateDate.isHidden = true
        
        self.btnpause.isHidden = true
        self.btncancel.isHidden = true
        
        tabvmysubscription.register(UINib(nibName: "celltabvsubscriptionorderview", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmysubscription.separatorStyle = .none
        tabvmysubscription.backgroundView=nil
        tabvmysubscription.backgroundColor=UIColor.clear
        tabvmysubscription.separatorColor=UIColor.clear
        tabvmysubscription.showsVerticalScrollIndicator = false
        
        
        self.txtstartdate.placeholder = myAppDelegate.changeLanguage(key: "msg_language61")
        self.txtenddate.placeholder = myAppDelegate.changeLanguage(key: "msg_language62")
        self.btnUpdateDate.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language429")), for: .normal)
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Update START & END Date Method
    @IBAction func pressUpdateDate(_ sender: Any)
    {
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        print("subscriptionid",strsubscription_id)
        print("txtstartdate",txtstartdate.text!)
        print("txtenddate",txtenddate.text!)
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language433"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            self.postStartEndDateApiMethod(strsubscription_id: strsubscription_id, strstartdate: txtstartdate.text!, strenddate: txtenddate.text!)
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - press PAUSE/RESUME method
    @IBAction func pressPAUSERESUME(_ sender: UIButton)
    {
        if sender.tag == 100{
            //RESUME
            
            let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language303"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                
                self.datePickerTappedStart3()
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        else if sender.tag == 200
        {
            //PAUSE
            let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language302"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                self.postPAUSERESUMEAPIMethod(strresumedate: "")
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        else if sender.tag == 300
        {
            let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language427"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    //MARK: - press CANCEL method
    @IBAction func pressCANCEL(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language434"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            self.postCANCELAPIMethod()
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
        
    }
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.isEqual(txtstartdate){
        }
        else if textField.isEqual(txtenddate){
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == self.txtstartdate {
            datePickerTappedStart()
            return false
        }
        else if textField == self.txtenddate {
            datePickerTappedEnd()
            return false
        }
        return true
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
    
    //MARK: - show fromdate picker method
    func datePickerTappedStart()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startdate = dateFormatter.date(from: self.txtstartdate.text!)
        let enddate = dateFormatter.date(from: self.txtenddate.text!)
        
        let maximumdaterange = Calendar.current.date(byAdding: .day, value: +60, to: startdate!)!
        
        datePicker1.show(myAppDelegate.changeLanguage(key: "msg_language61"),
                         doneButtonTitle: myAppDelegate.changeLanguage(key: "msg_language106"),
                         cancelButtonTitle: myAppDelegate.changeLanguage(key: "msg_language77"),
                         minimumDate: startdate,
                         maximumDate: maximumdaterange,
                         datePickerMode: .date) { (date) in
            if let dt = date
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.txtstartdate.text = formatter.string(from: dt)
                
                let enddate = formatter.date(from: self.txtstartdate.text!)
                var intdiff = 0
                if self.strselectedplan.containsIgnoreCase("daily"){
                    intdiff = 9
                }else if self.strselectedplan.containsIgnoreCase("weekly"){
                    intdiff = 7
                }else if self.strselectedplan.containsIgnoreCase("monthly"){
                    intdiff = 30
                }
                
                let nextdate1 = Calendar.current.date(byAdding: .day, value: +intdiff, to: enddate!)!
                let enddate2 = formatter.string(from: nextdate1)
                print("enddate2 date %@",enddate2)
                self.txtenddate.text = enddate2
                
            }
        }
    }
    func datePickerTappedEnd()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startdate = dateFormatter.date(from: self.txtstartdate.text!)
        let enddate = dateFormatter.date(from: self.txtenddate.text!)
        
        let maximumdaterange = Calendar.current.date(byAdding: .day, value: +60, to: startdate!)!
        
        var intdiff = 0
        if self.strselectedplan.containsIgnoreCase("daily"){
            intdiff = 9
        }else if self.strselectedplan.containsIgnoreCase("weekly"){
            intdiff = 7
        }else if self.strselectedplan.containsIgnoreCase("monthly"){
            intdiff = 30
        }
        
        let minimumdaterange = Calendar.current.date(byAdding: .day, value: +intdiff, to: startdate!)!
        
        datePicker2.show(myAppDelegate.changeLanguage(key: "msg_language62"),
                         doneButtonTitle: myAppDelegate.changeLanguage(key: "msg_language106"),
                         cancelButtonTitle: myAppDelegate.changeLanguage(key: "msg_language77"),
                         minimumDate: minimumdaterange,
                         maximumDate: maximumdaterange,
                         datePickerMode: .date) { (date) in
            if let dt = date
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                print("action")
                self.txtenddate.text = formatter.string(from: dt)
                
            }
        }
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        
        if arrMsubscription_order.count == 0 {
            self.tabvmysubscription.setEmptyMessage(msg)
        } else {
            self.tabvmysubscription.restore()
        }
        return arrMsubscription_order.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tabveditpopupitems
        {
            return self.arrMProductItemsEdit.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tabveditpopupitems
        {
            print("self.iseditpopupfunction",self.iseditpopupfunction)
            //is Editable Check Popup functions
            if self.iseditpopupfunction == false
            {
                //NOT EDITABLE
                return 115
            }
            else{
                //EDITABLE
                return 155
            }
        }
        return 147
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tabveditpopupitems
        {
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
            print("dictm",dictm)
            
            let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
            let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
            let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
            let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
            
            let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
            let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
            
            print("strqtyonce",strqtyonce)
            print("strqtyall",strqtyall)
            
            cell.imgvproduct.isHidden = true
            
            cell.lblname.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblname.frame.origin.y, width: cell.lblname.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblname.frame.size.height)
            cell.lblspec.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblspec.frame.origin.y, width: cell.lblspec.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblspec.frame.size.height)
            cell.lblunitprice.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblunitprice.frame.origin.y, width: cell.lblunitprice.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblunitprice.frame.size.height)
            
            cell.lblname.text = strproduct_name
            cell.lblspec.text = "" //strsku
            
            cell.lblunitprice.frame = CGRect(x: cell.lblunitprice.frame.origin.x, y: cell.lblname.frame.maxY, width: cell.lblunitprice.frame.size.width, height: cell.lblunitprice.frame.size.height)
            
            let fltamount  = (strproduct_price as NSString).floatValue
            cell.lblunitprice.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltamount)
            
            cell.btnremove.tag = indexPath.row
            cell.btnremove.addTarget(self, action: #selector(pressEditPopupRemove), for: .touchUpInside)
            
            cell.btnaddonce.layer.cornerRadius = 14.0
            cell.btnaddonce.layer.masksToBounds = true
            
            cell.btnaddtoall.setTitleColor(UIColor(named: "orangecolor")!, for: .normal)
            cell.btnaddtoall.layer.cornerRadius = 14.0
            cell.btnaddtoall.layer.borderWidth = 1.0
            cell.btnaddtoall.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
            cell.btnaddtoall.layer.masksToBounds = true
            
            //CELL ADD ONCE & ADD TO ALL
            cell.btnaddonce.tag = indexPath.row
            cell.btnaddtoall.tag = indexPath.row
            cell.btnaddonce.addTarget(self, action: #selector(pressaddonce), for: .touchUpInside)
            cell.btnaddtoall.addTarget(self, action: #selector(pressaddtoall), for: .touchUpInside)
            
            
            //CELL PLUS MINUS
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
            cell.btnplus.addTarget(self, action: #selector(pressplus), for: .touchUpInside)
            cell.btnminus.addTarget(self, action: #selector(pressminus), for: .touchUpInside)
            
            //CELL PLUS MINUS ALL
            cell.viewplusminusATA.layer.cornerRadius = 14.0
            cell.viewplusminusATA.layer.borderWidth = 1.0
            cell.viewplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
            cell.viewplusminusATA.layer.masksToBounds = true
            
            cell.txtplusminusATA.layer.cornerRadius = 1.0
            cell.txtplusminusATA.layer.borderWidth = 1.0
            cell.txtplusminusATA.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
            cell.txtplusminusATA.layer.masksToBounds = true
            
            cell.btnplusATA.tag = indexPath.row
            cell.btnminusATA.tag = indexPath.row
            cell.btnplusATA.addTarget(self, action: #selector(pressplusATA), for: .touchUpInside)
            cell.btnminusATA.addTarget(self, action: #selector(pressminusATA), for: .touchUpInside)
            
            cell.btnaddonce.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language71")), for: .normal)
            cell.btnaddtoall.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language70")), for: .normal)
            cell.lbladdonce.text = myAppDelegate.changeLanguage(key: "msg_language71")
            cell.lbladdtoall.text = myAppDelegate.changeLanguage(key: "msg_language70")
            
            var fltpointy = 0.00
            //is Editable Check Popup functions
            if self.iseditpopupfunction == false
            {
                //NOT EDITABLE
                fltpointy = 114.5
                
                cell.btnaddonce.isHidden = true
                cell.btnaddtoall.isHidden = true
                cell.viewplusminus.isHidden = true
                cell.viewplusminusATA.isHidden = true
                
                cell.btnremove.isHidden = true
                
                
            }
            else
            {
                //EDITABLE
                fltpointy = 154.5
                
                cell.btnremove.isHidden = false
                
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
                
            }
            
            /*let lblSeparator = UILabel(frame: CGRect(x: 0, y: fltpointy, width: tableView.frame.size.width, height: 0.5))
             lblSeparator.backgroundColor = UIColor(named: "graybordercolor")!
             cell.contentView.addSubview(lblSeparator)*/
            
            return cell;
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvsubscriptionorderview
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMsubscription_order.object(at: indexPath.section)as! NSDictionary
        
        
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strisedit = dic.value(forKey: "is_edit")as? Bool ?? false
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        
        let strsubtotal = String(format: "%@", dic.value(forKey: "subtotal")as? String ?? "")
        let strshipping_amount = String(format: "%@", dic.value(forKey: "shipping_amount")as? String ?? "")
        let strgrand_total = String(format: "%@", dic.value(forKey: "grand_total")as! CVarArg)
        let strcurrency = String(format: "%@", dic.value(forKey: "currency")as? String ?? "")
        
        let strtimeslot_id = String(format: "%@", dic.value(forKey: "timeslot_id")as? String ?? "")
        
        let arrsubscription_product = dic.value(forKey: "subscription_product")as? NSArray ?? []
        
        cell.lbldateday.text = String(format: "%@", strsubscription_order_date)
        cell.lbltotal.text = String(format: "%@: %@ %@",myAppDelegate.changeLanguage(key: "msg_language304"),myAppDelegate.changeLanguage(key: "msg_language481"),strsubtotal)
        cell.lblstatus.text = String(format: "%@",strorder_status)
        
        
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
        
        
        
        cell.lblstatus.textColor = UIColor(named: "themecolor")!
        /*cell.lblstatus.backgroundColor =  UIColor(named: "plate1")!
        cell.lblstatus.layer.cornerRadius = 12.0
        cell.lblstatus.layer.masksToBounds = true*/
        
        
        if strisedit == true
        {
            cell.btnAddMore.isHidden = false
            cell.viewupdatetimeslot.isHidden = false
            cell.btnedit.isHidden = false
            
            cell.btnupdatetimeslot.isUserInteractionEnabled = true
        }
        else{
            cell.btnAddMore.isHidden = true
            cell.viewupdatetimeslot.isHidden = false
            cell.btnedit.isHidden = true
            
            cell.btnupdatetimeslot.isUserInteractionEnabled = false
        }
        
        cell.btnedit.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language73")), for: .normal)
        cell.btnedit.tag = indexPath.section
        cell.btnedit.addTarget(self, action: #selector(pressEdit), for: .touchUpInside)
        
        cell.btndetail.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language91")), for: .normal)
        cell.btndetail.tag = indexPath.section
        cell.btndetail.addTarget(self, action: #selector(pressDetail), for: .touchUpInside)
        
        cell.btnAddMore.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language92")), for: .normal)
        cell.btnAddMore.tag = indexPath.section
        cell.btnAddMore.addTarget(self, action: #selector(pressAddMoreProducts), for: .touchUpInside)
        
        cell.viewupdatetimeslot.tag = indexPath.section
        cell.btnupdatetimeslot.tag = indexPath.section
        cell.btnupdatetimeslot.addTarget(self, action: #selector(pressUpdateTimeSlot), for: .touchUpInside)
        
        if strisedit == true
        {
            cell.viewcell.backgroundColor = UIColor(named: "greenlighter")!
            cell.viewcell.layer.borderWidth  = 1.0
            cell.viewcell.layer.borderColor  = UIColor(named: "graybordercolor")!.cgColor
            cell.viewcell.layer.cornerRadius = 8.0
            cell.viewcell.layer.masksToBounds = true
        }
        else{
            cell.viewcell.backgroundColor = UIColor(named: "lightred")!
            cell.viewcell.layer.borderWidth  = 1.0
            cell.viewcell.layer.borderColor  = UIColor(named: "graybordercolor")!.cgColor
            cell.viewcell.layer.cornerRadius = 8.0
            cell.viewcell.layer.masksToBounds = true
        }
        
        
        cell.viewupdatetimeslot.layer.borderWidth  = 1.0
        cell.viewupdatetimeslot.layer.borderColor  = UIColor(named: "lightblue")!.cgColor
        cell.viewupdatetimeslot.layer.cornerRadius = 14.0
        cell.viewupdatetimeslot.layer.masksToBounds = true
        
        cell.btndetail.layer.cornerRadius = 14.0
        cell.btndetail.layer.masksToBounds = true
        cell.btnAddMore.layer.cornerRadius = 14.0
        cell.btnAddMore.layer.masksToBounds = true
        cell.btnupdatetimeslot.layer.cornerRadius = 14.0
        cell.btnupdatetimeslot.layer.masksToBounds = true
        
        //IF NO PRODUCT ADDED ON DATE
        if arrsubscription_product.count == 0{
            cell.lblwarningmessage.textColor = UIColor(named: "darkgreencolor")!
            cell.lblwarningmessage.text = myAppDelegate.changeLanguage(key: "msg_language92")
            cell.viewshippingwarning.isHidden = false
            
            cell.imgvstatus.isHidden = true
            cell.lblstatus.isHidden = true
            
            cell.btnAddMore.isHidden = false
        }
        
        
        //CHCECK TIMELOT FOR EACH DATE
        if strtimeslot_id == ""
        {
            cell.lblupdatetimeslot.text = myAppDelegate.changeLanguage(key: "msg_language436")
        }
        else
        {
            for x in 0 ..< self.arrMAvailbleTimeSlots.count
            {
                let dictemp = self.arrMAvailbleTimeSlots.object(at: x)as? NSDictionary
                let strslotid = String(format: "%@", dictemp?.value(forKey: "interval_id")as! CVarArg)
                let strname = String(format: "%@", dictemp?.value(forKey: "label")as? String ?? "")
                let strstart_time = String(format: "%@", dictemp?.value(forKey: "from")as? String ?? "")
                let strend_time = String(format: "%@", dictemp?.value(forKey: "to")as? String ?? "")
                
                if strslotid == strtimeslot_id
                {
                    if strname.containsIgnoreCase("Morning"){
                        cell.lblupdatetimeslot.text = myAppDelegate.changeLanguage(key: "msg_language99")
                    }
                    else if strname.containsIgnoreCase("Afternoon"){
                        cell.lblupdatetimeslot.text = myAppDelegate.changeLanguage(key: "msg_language100")
                    }
                    else if strname.containsIgnoreCase("Evening"){
                        cell.lblupdatetimeslot.text = myAppDelegate.changeLanguage(key: "msg_language101")
                    }
                    
                }
            }
        }
        
        
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    //MARK: - press Edit / Details / Add More / Update Time Slot Method
    @objc func pressEdit(sender:UIButton)
    {
        let dic = self.arrMsubscription_order.object(at: sender.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strisedit = dic.value(forKey: "is_edit")as? Bool ?? false
        
        self.createEditpopupDatewiseItems(selecteddateindex: sender.tag,iseditbool: strisedit)
    }
    
    @objc func pressDetail(sender:UIButton)
    {
        let dic = self.arrMsubscription_order.object(at: sender.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strisedit = dic.value(forKey: "is_edit")as? Bool ?? false
        
        self.createEditpopupDatewiseItems(selecteddateindex: sender.tag,iseditbool: strisedit)
    }
    
    @objc func pressAddMoreProducts(sender:UIButton)
    {
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: sender.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strisedit = dic.value(forKey: "is_edit")as? Bool ?? false
        
        let ctrl = mysubscriptionEditAddProduct(nibName: "mysubscriptionEditAddProduct", bundle: nil)
        ctrl.strsubscription_order_id = strsubscription_order_id
        ctrl.strsubscription_id = strsubscription_id
        ctrl.strselecteddate = strsubscription_order_date
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    @objc func pressUpdateTimeSlot(sender:UIButton)
    {
        let dic = self.arrMsubscription_order.object(at: sender.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strtimeslot_id = String(format: "%@", dic.value(forKey: "timeslot_id")as? String ?? "")
        
        self.createEditpopupTimeSlot(selecteddateindex: sender.tag)
    }
    
    
    
    //MARK: - press EditPopupRemove Method
    @objc func pressEditPopupRemove(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
        let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
        
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: self.tabveditpopupitems.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        print("strsubscription_id",strsubscription_id)
        print("self.lbleditpopupDateDay.text",self.lbleditpopupDateDay.text)
        print("strproduct_id",strproduct_id)
        print("strqtyonce",strqtyonce)
        
        self.postRemoveProductApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_date: self.lbleditpopupDateDay.text!, strproductid: strproduct_id)
        
    }
    
    //MARK: - press ADDONCE && ADDTOALL method
    @objc func pressaddonce(sender:UIButton)
    {
        
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
        let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
        
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: self.tabveditpopupitems.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        print("strsubscription_id",strsubscription_id)
        print("strsubscription_order_id",strsubscription_order_id)
        print("strproduct_id",strproduct_id)
        print("strqtyonce",strqtyonce)
        
        self.postUpdateQTYApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyonce: "1")
    }
    @objc func pressaddtoall(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
        let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
        
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: self.tabveditpopupitems.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        print("strsubscription_id",strsubscription_id)
        print("strsubscription_order_id",strsubscription_order_id)
        print("strproduct_id",strproduct_id)
        print("strqtyall",strqtyall)
        
        self.postUpdateQTYALLApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyall: "1")
        
    }
    
    //MARK: - press ADDONCE PLUS MINUS method
    @objc func pressplus(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
        let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
        
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: self.tabveditpopupitems.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        print("strsubscription_id",strsubscription_id)
        print("strsubscription_order_id",strsubscription_order_id)
        print("strproduct_id",strproduct_id)
        print("strqtyonce",strqtyonce)
        
        var fltqtyonce = Float(strqtyonce)! as Float
        fltqtyonce = fltqtyonce + 1
        print("fltqtyonce",fltqtyonce)
        
        self.postUpdateQTYApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyonce: String(format: "%0.0f", fltqtyonce))
    }
    @objc func pressminus(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
        let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
        
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: self.tabveditpopupitems.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        print("strsubscription_id",strsubscription_id)
        print("strsubscription_order_id",strsubscription_order_id)
        print("strproduct_id",strproduct_id)
        print("strqtyonce",strqtyonce)
        
        var fltqtyonce = Float(strqtyonce)! as Float
        if fltqtyonce > 1
        {
            fltqtyonce = fltqtyonce - 1
            print("fltqtyonce",fltqtyonce)
            
            self.postUpdateQTYApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyonce: String(format: "%0.0f", fltqtyonce))
        }
        else{
            //Remove api call
            
            if fltqtyonce == 1.0
            {
                self.postUpdateQTYApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyonce: String(format: "%0.0f", 0))
            }else{
                //Nothing
            }
            
        }
    }
    
    //MARK: - press ADDTOALL PLUS MINUS method
    @objc func pressplusATA(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
        let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
        
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: self.tabveditpopupitems.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        print("strsubscription_id",strsubscription_id)
        print("strsubscription_order_id",strsubscription_order_id)
        print("strproduct_id",strproduct_id)
        print("strqtyall",strqtyall)
        
        var fltqtyall = Float(strqtyall)! as Float
        fltqtyall = fltqtyall + 1
        print("fltqtyall",fltqtyall)
        
        self.postUpdateQTYALLApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyall: String(format: "%0.0f", fltqtyall))
    }
    @objc func pressminusATA(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dictm.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dictm.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dictm.value(forKey: "sku")as? String ?? "")
        let strproduct_price = String(format: "%@", dictm.value(forKey: "product_price")as? String ?? "")
        
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qty_once")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qty_all")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: self.tabveditpopupitems.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        print("strsubscription_id",strsubscription_id)
        print("strsubscription_order_id",strsubscription_order_id)
        print("strproduct_id",strproduct_id)
        print("strqtyall",strqtyall)
        
        var fltqtyall = Float(strqtyall)! as Float
        if fltqtyall > 1
        {
            fltqtyall = fltqtyall - 1
            print("fltqtyall",fltqtyall)
            
            self.postUpdateQTYALLApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyall: String(format: "%0.0f", fltqtyall))
            
        }
        else{
            //Remove api call
            
            if fltqtyall == 1.0
            {
                self.postUpdateQTYALLApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqtyall: String(format: "%0.0f", 0))
                
            }else{
                //Nothing
            }
            
        }
    }
    
    
    
    //MARK: - create POPUP TIME SLOT method
    func createEditpopupTimeSlot(selecteddateindex:Int)
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewdateslotsdeliverypopup.layer.cornerRadius = 6.0
        self.viewdateslotsdeliverypopup.layer.masksToBounds = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let dic = self.arrMsubscription_order.object(at:selecteddateindex)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strtimeslot_id = String(format: "%@", dic.value(forKey: "timeslot_id")as? String ?? "")
        
        self.lbldeliveryslotpopupHeader.text = myAppDelegate.changeLanguage(key: "msg_language437")
        
        viewdateslotsdeliverypopup.tag = selecteddateindex
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: coltimeslots.frame.size.width / 3.1, height: 100)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        coltimeslots.collectionViewLayout = layout
        coltimeslots.register(UINib(nibName: "celltimeslots", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier3)
        coltimeslots.showsHorizontalScrollIndicator = false
        coltimeslots.showsVerticalScrollIndicator=false
        coltimeslots.backgroundColor = .white
        coltimeslots.tag = Int(strtimeslot_id)!
        coltimeslots.reloadData()
        
        viewPopupAddNewExistingBG3 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG3.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG3.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG3.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG3.addSubview(self.viewdateslotsdeliverypopup)
        self.viewdateslotsdeliverypopup.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG3)
        
    }
    @IBAction func presscrossTimeSlotpopup(_ sender: Any) {
        self.viewdateslotsdeliverypopup.removeFromSuperview()
        viewPopupAddNewExistingBG3.removeFromSuperview()
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //print("arrMAvailbleTimeSlots.count",arrMAvailbleTimeSlots.count)
        return arrMAvailbleTimeSlots.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! celltimeslots
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let dict = self.arrMAvailbleTimeSlots.object(at: indexPath.row) as! NSDictionary
        let strslotid = String(format: "%@", dict.value(forKey: "interval_id")as! CVarArg)
        let strname = String(format: "%@", dict.value(forKey: "label")as? String ?? "")
        let strstart_time = String(format: "%@", dict.value(forKey: "from")as? String ?? "")
        let strend_time = String(format: "%@", dict.value(forKey: "to")as? String ?? "")
        
        
        let strSelectedTimeslot = String(format: "%d", coltimeslots.tag)
        if strSelectedTimeslot == strslotid
        {
            cellA.imgvradio.image = UIImage(named: "checkRadio")
            
            cellA.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 4.0
            cellA.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        else
        {
            cellA.imgvradio.image = UIImage(named: "uncheckRadio")
            
            cellA.viewcell.backgroundColor = .white
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 1.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        
        if strname.containsIgnoreCase("Morning"){
            cellA.lblslotname.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language99"))
        }
        else if strname.containsIgnoreCase("Afternoon"){
            cellA.lblslotname.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language100"))
        }
        else if strname.containsIgnoreCase("Evening"){
            cellA.lblslotname.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language101"))
        }
        
        //cellA.lblslotname.text = strname
        cellA.lblslottime.text = String(format: "%@ - %@", strstart_time,strend_time)
        
        cellA.viewcell.layer.cornerRadius = 6.0
        cellA.viewcell.layer.masksToBounds = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: coltimeslots.frame.size.width / 3.1 , height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dict = self.arrMAvailbleTimeSlots.object(at: indexPath.row) as! NSDictionary
        let strslotid = String(format: "%@", dict.value(forKey: "interval_id")as! CVarArg)
        let strname = String(format: "%@", dict.value(forKey: "label")as? String ?? "")
        let strstart_time = String(format: "%@", dict.value(forKey: "from")as? String ?? "")
        let strend_time = String(format: "%@", dict.value(forKey: "to")as? String ?? "")
        
        self.viewdateslotsdeliverypopup.removeFromSuperview()
        viewPopupAddNewExistingBG3.removeFromSuperview()
        
        print("tag",viewdateslotsdeliverypopup.tag)
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let dic = self.arrMsubscription_order.object(at: viewdateslotsdeliverypopup.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strtimeslot_id = String(format: "%@", dic.value(forKey: "timeslot_id")as? String ?? "")
        
        self.postTimeSlotApiMethod(strsubscription_id: strsubscription_id, strsubscription_order_date: strsubscription_order_date, strslotId: strslotid)
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    
    //MARK: - create POPUP EDIT ITEMS DATE WISE method
    func createEditpopupDatewiseItems(selecteddateindex:Int,iseditbool:Bool)
    {
        if arrMProductItemsEdit.count > 0{
            arrMProductItemsEdit.removeAllObjects()
        }
        
        self.iseditpopupfunction = iseditbool
        
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewpopupedititems.layer.cornerRadius = 6.0
        self.viewpopupedititems.layer.masksToBounds = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let dic = self.arrMsubscription_order.object(at: selecteddateindex)as! NSDictionary
        
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        
        let strsubtotal = String(format: "%@", dic.value(forKey: "subtotal")as? String ?? "")
        let strdiscount = String(format: "%@", dic.value(forKey: "discount")as? String ?? "")
        let strshipping_amount = String(format: "%@", dic.value(forKey: "shipping_amount")as? String ?? "")
        let strgrand_total = String(format: "%@", dic.value(forKey: "grand_total")as! CVarArg)
        let strcurrency = String(format: "%@", dic.value(forKey: "currency")as? String ?? "")
        
        let arrsubscription_product = dic.value(forKey: "subscription_product")as? NSArray ?? []
        self.arrMProductItemsEdit = NSMutableArray(array: arrsubscription_product)
        print("arrMProductItemsEdit --->",self.arrMProductItemsEdit)
        
        self.lbleditpopupDateDay.text = String(format: "%@", strsubscription_order_date)
        self.lblsubtotaleditpopupvalue.text = String(format: "%@ %@", myAppDelegate.changeLanguage(key: "msg_language481"),strsubtotal)
        
        lblsubtotaleditpopup.text = myAppDelegate.changeLanguage(key: "msg_language304")
        lbleditpopupnotes.text = myAppDelegate.changeLanguage(key: "msg_language69")
        
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
        self.iseditpopupfunction = false
        self.viewpopupedititems.removeFromSuperview()
        viewPopupAddNewExistingBG2.removeFromSuperview()
    }
    
    
    //MARK: - show fromdate picker method
    let datePicker3 = DatePickerDialog()
    func datePickerTappedStart3()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let timestring = df.string(from: date)
        print("timestring",timestring)
        
        let s1 = timestring
        let s2 = Constants.conn.CutOffTime //"15:00:00"
        var strdate = String()
        if df.date(from: s1)! > df.date(from: s2)!
        {
            print("Over 15:00:00 - Its over 3 PM")
            
            
            let today = Date()
            let nextdate = Calendar.current.date(byAdding: .day, value: +2, to: today)!
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd/MM/yyyy"
            strdate = formatter1.string(from: nextdate)
            print("strdate date %@",strdate)
            
        }
        else
        {
            print("Within 15:00:00 - Its within 3 PM")
            
            let today = Date()
            let nextdate = Calendar.current.date(byAdding: .day, value: +1, to: today)!
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd/MM/yyyy"
            strdate = formatter1.string(from: nextdate)
            print("strdate date %@",strdate)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date111 = dateFormatter.date(from: strdate)
        
        var dateComponents1 = DateComponents()
        dateComponents1.day = 365
        let next365days = Calendar.current.date(byAdding: dateComponents1, to: date111!)
        
        datePicker3.show(myAppDelegate.changeLanguage(key: "msg_language477"),
                         doneButtonTitle: myAppDelegate.changeLanguage(key: "msg_language106"),
                         cancelButtonTitle: myAppDelegate.changeLanguage(key: "msg_language107"),
                         minimumDate: date111,
                         maximumDate: next365days,
                         datePickerMode: .date) { (date) in
            
            if let dt = date
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let strSelectedResumeDate = formatter.string(from: dt)
                print("Selected Resume Date >>>>>>>",strSelectedResumeDate)
                self.postPAUSERESUMEAPIMethod(strresumedate: strSelectedResumeDate)
            }
            
        }
    }
    
    //MARK: - post PAUSE / RESUME API Method
    func postPAUSERESUMEAPIMethod(strresumedate:String)
    {
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        //language
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        let parameters = ["subscription_id": strsubscription_id,"resumeDate":strresumedate,"language":strLangCode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod47)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "PUT"
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
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                self.navigationController?.popViewController(animated: true)
                            }))
                            
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
    
    //MARK: - post CANCEL API Method
    func postCANCELAPIMethod()
    {
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        //language
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        let parameters = ["subscriptionid": strsubscription_id,"language":strLangCode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod48)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "PUT"
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
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                self.navigationController?.popViewController(animated: true)
                            }))
                            
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
    
    
    //MARK: - get All My subscription Detail API method
    func getallmysubscriptionDetail(strsubscriptionid:String)
    {
        if arrMsubscription_order.count > 0{
            arrMsubscription_order.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?subscriptionid=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod59,strsubscriptionid,strLangCode)
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
                           
                            self.isEditStartDate = dictemp.value(forKey: "is_edit_start_date")as? Bool ?? false
                            self.isEditEndDate = dictemp.value(forKey: "is_edit_end_date")as? Bool ?? false
                            print("self.isEditStartDate",self.isEditStartDate)
                            print("self.isEditEndDate",self.isEditEndDate)
                            
                            
                            if self.isEditStartDate == false && self.isEditEndDate ==  false{
                                self.txtstartdate.isUserInteractionEnabled = false
                                self.txtenddate.isUserInteractionEnabled = false
                                self.btnUpdateDate.isHidden = true
                                
                                self.txtstartdate.backgroundColor = UIColor(named: "plate1")!
                                self.txtenddate.backgroundColor = UIColor(named: "plate1")!
                            }
                            else if self.isEditStartDate == true && self.isEditEndDate ==  false{
                                self.txtstartdate.isUserInteractionEnabled = true
                                self.txtenddate.isUserInteractionEnabled = false
                                self.btnUpdateDate.isHidden = false
                                
                                self.txtstartdate.backgroundColor = UIColor.white
                                self.txtenddate.backgroundColor = UIColor(named: "plate1")!
                            }
                            else if self.isEditStartDate == false && self.isEditEndDate ==  true{
                                self.txtstartdate.isUserInteractionEnabled = false
                                self.txtenddate.isUserInteractionEnabled = true
                                self.btnUpdateDate.isHidden = false
                                
                                self.txtstartdate.backgroundColor = UIColor(named: "plate1")!
                                self.txtenddate.backgroundColor = .white
                            }
                            else if self.isEditStartDate == true && self.isEditEndDate ==  true{
                                self.txtstartdate.isUserInteractionEnabled = true
                                self.txtenddate.isUserInteractionEnabled = true
                                self.btnUpdateDate.isHidden = false
                                
                                self.txtstartdate.backgroundColor = .white
                                self.txtenddate.backgroundColor = .white
                            }
                            else{
                                self.txtstartdate.isUserInteractionEnabled = false
                                self.txtenddate.isUserInteractionEnabled = false
                                self.btnUpdateDate.isHidden = true
                                
                                self.txtstartdate.backgroundColor = UIColor(named: "plate1")!
                                self.txtenddate.backgroundColor = UIColor(named: "plate1")!
                            }
                            
                            

                            let arrm = dictemp.value(forKey: "subscription_detail") as? NSArray ?? []
                            self.arrMsubscription_order = NSMutableArray(array: arrm)
                            print("arrMsubscription_order --->",self.arrMsubscription_order)
                            
                            if self.arrMsubscription_order.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language206")
                            }
                            self.tabvmysubscription.reloadData()
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getAvailbleTimeSlotsAPIMethod()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.getAvailbleTimeSlotsAPIMethod()
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
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.tabvmysubscription.reloadData()
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
                            if self.arrMAvailbleTimeSlots.count > 0{
                                self.arrMAvailbleTimeSlots.removeAllObjects()
                            }
                            let arrmproducts = json.value(forKey: "timeslot") as? NSArray ?? []
                            self.arrMAvailbleTimeSlots = NSMutableArray(array: arrmproducts)
                            //print("arrMAvailbleTimeSlots --->",self.arrMAvailbleTimeSlots)
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.tabvmysubscription.reloadData()
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
                    self.tabvmysubscription.reloadData()
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Update QTYONCE API Method
    func postUpdateQTYApiMethod(strsubscription_id:String,strsubscription_order_id:String,strproductid:String,strqtyonce:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["subscriptionId": strsubscription_id,
                          "subscriptionOrderId": strsubscription_order_id,
                          "productId": strproductid,
                          "qtyOnce": strqtyonce
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod60)
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
                            //Reload Over all Page
                            self.viewpopupedititems.removeFromSuperview()
                            self.viewPopupAddNewExistingBG2.removeFromSuperview()
                            
                            self.getallmysubscriptionDetail(strsubscriptionid: strsubscription_id)
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
    
    //MARK: - post Update QTYALL API Method
    func postUpdateQTYALLApiMethod(strsubscription_id:String,strsubscription_order_id:String,strproductid:String,strqtyall:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["subscriptionId": strsubscription_id,
                          "productId": strproductid,
                          "qtyAll": strqtyall
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod61)
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
                    uiAlert.addAction(UIAlertAction(title:myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
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
                            //Reload Over all Page
                            self.viewpopupedititems.removeFromSuperview()
                            self.viewPopupAddNewExistingBG2.removeFromSuperview()
                            
                            self.getallmysubscriptionDetail(strsubscriptionid: strsubscription_id)
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
    
    //MARK: - post Remove product API Method
    func postRemoveProductApiMethod(strsubscription_id:String,strsubscription_order_date:String,strproductid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["subscriptionId": strsubscription_id,
                          "subscriptionOrderDate":strsubscription_order_date,
                          "productId": strproductid
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod63)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
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
                            //Reload Over all Page
                            self.viewpopupedititems.removeFromSuperview()
                            self.viewPopupAddNewExistingBG2.removeFromSuperview()
                            
                            self.getallmysubscriptionDetail(strsubscriptionid: strsubscription_id)
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
    
    //MARK: - post Update Time Slot API Method
    func postTimeSlotApiMethod(strsubscription_id:String,strsubscription_order_date:String,strslotId:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["subscriptionId": strsubscription_id,
                          "subscriptionOrderDate":strsubscription_order_date,
                          "slotId": strslotId
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod64)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
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
                            //Reload Over all Page
                            
                            self.getallmysubscriptionDetail(strsubscriptionid: strsubscription_id)
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
    
    
    //MARK: - post Update START DATE & END DATE API Method
    func postStartEndDateApiMethod(strsubscription_id:String,strstartdate:String,strenddate:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["subscriptionId": strsubscription_id,
                          "subscriptionStartDate":strstartdate,
                          "subscriptionEndDate": strenddate
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod68)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
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
                            //Reload Over all Page
                            
                            self.getallmysubscriptionDetail(strsubscriptionid: strsubscription_id)
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
