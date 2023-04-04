//
//  renewsubscriptiondetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/11/22.
//

import UIKit
import CoreData
import DatePickerDialog

class renewsubscriptiondetails: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var imgvplan: UIImageView!
    @IBOutlet weak var lblplanname: UILabel!
    
    @IBOutlet weak var viewstartdate: UIView!
    @IBOutlet weak var txtstartdate: UITextField!
    @IBOutlet weak var imgvstartcal: UIImageView!
    
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblsubtotalvalue: UILabel!
    @IBOutlet weak var lblshipping: UILabel!
    @IBOutlet weak var lblshippingvalue: UILabel!
    @IBOutlet weak var lblgrandtotal: UILabel!
    @IBOutlet weak var lblgrandtotalvalue: UILabel!
    
    @IBOutlet weak var lblautorenew: UILabel!
    @IBOutlet weak var btnautorenew: UIButton!
    
    @IBOutlet weak var btnreset: UIButton!
    
    @IBOutlet weak var tabvorderlist: UITableView!
    var reuseIdentifier1 = "celltabvsubscriptionOR"
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
    

    var arrMordereview = NSMutableArray()
    var strSelectedpaymentoption = ""
    
    var arrMProductItemsEdit = NSMutableArray()
    
    var strsubscriptionplanid = ""
    
    var strSUBTOTAL = ""
    var strSHIPPING = ""
    var strTAX = ""
    var strGRANDTOTAL = ""
   
    
    var strISAUTORENEW = "0"
    
    var strSelectedStartDate = ""
    
    var strmainPreviousSubscriptionid = ""
    
    var arrMshippingcalculation = NSMutableArray()
    var arrMshippingcalculationOutput = NSMutableArray()
    
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


        print("self.strsubscriptionplanid",self.strsubscriptionplanid)
        if self.strsubscriptionplanid == "1"
        {
            self.lblplanname.text = myAppDelegate.changeLanguage(key: "msg_language37")
        }
        else if self.strsubscriptionplanid == "2"
        {
            self.lblplanname.text = myAppDelegate.changeLanguage(key: "msg_language38")
        }
        else if self.strsubscriptionplanid == "3"
        {
            self.lblplanname.text = myAppDelegate.changeLanguage(key: "msg_language39")
        }
        
        
        self.refreshmainlist()
        
        self.fetchDataRenewmodelSubscriptionmodelTableAUTORENEW()
        
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
        
        tabvorderlist.register(UINib(nibName: "celltabvsubscriptionOR", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvorderlist.separatorStyle = .none
        tabvorderlist.backgroundView=nil
        tabvorderlist.backgroundColor=UIColor.clear
        tabvorderlist.separatorColor=UIColor.clear
        tabvorderlist.showsVerticalScrollIndicator = false
        
        btncheckout.layer.cornerRadius = 18.0
        btncheckout.layer.masksToBounds = true
        
        btnreset.layer.borderWidth = 1.0
        btnreset.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnreset.layer.cornerRadius = 18.0
        btnreset.layer.masksToBounds = true
        
        
        
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
        
        lblsubtotal.text = myAppDelegate.changeLanguage(key: "msg_language311")
        lblshipping.text = myAppDelegate.changeLanguage(key: "msg_language441")
        lblgrandtotal.text = myAppDelegate.changeLanguage(key: "msg_language86")
        
        lblautorenew.text = myAppDelegate.changeLanguage(key: "msg_language63")
        
        lblfullpayment.text = myAppDelegate.changeLanguage(key: "msg_language336")
        lblfirst3payment.text = myAppDelegate.changeLanguage(key: "msg_language337")
        btncheckout.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language482")), for: .normal)
        
        btnreset.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language508")), for: .normal)
        
         let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
         if (strLangCode == "en")
         {
        
         }
         else
         {

         }
    }
    
    // MARK: - press Reset Method
    @IBAction func pressreset(_ sender: Any)
    {
        print("self.strmainPreviousSubscriptionid",self.strmainPreviousSubscriptionid)
        //New Date Range API CALL
        self.getallRenewmysubscription(strid: self.strmainPreviousSubscriptionid, strdate: "")
    }
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.isEqual(txtstartdate)
        {
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == self.txtstartdate {
            datePickerTappedStart(strstartdate: self.strSelectedStartDate)
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
    let datePicker1 = DatePickerDialog()
    func datePickerTappedStart(strstartdate:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date111 = dateFormatter.date(from: strstartdate)
        
        var dateComponents1 = DateComponents()
        dateComponents1.day = 365
        let next6days = Calendar.current.date(byAdding: dateComponents1, to: date111!)
        
        
        datePicker1.show(myAppDelegate.changeLanguage(key: "msg_language61"),
                         doneButtonTitle: myAppDelegate.changeLanguage(key: "msg_language106"),
                         cancelButtonTitle: myAppDelegate.changeLanguage(key: "msg_language107"),
                         defaultDate: date111!,
                         minimumDate: date111,
                         maximumDate: next6days,
                         datePickerMode: .date) { (date) in
            if let dt = date
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                print("action")
                self.txtstartdate.text = formatter.string(from: dt)
                self.strSelectedStartDate = formatter.string(from: dt)
                
                //New Date Range API CALL
                self.getallRenewmysubscription(strid: self.strmainPreviousSubscriptionid, strdate: self.strSelectedStartDate)
            }
        }
    }
    
    //MARK: - press auto renew method
    @IBAction func pressautorenewclick(_ sender: Any)
    {
        if btnautorenew.isSelected == true{
            self.btnautorenew.isSelected = false
            self.strISAUTORENEW = "0"
            self.updateDataRenewmodelSubscriptionmodelTableAUTORENEW(strselectedautorenew: "0")
        }
        else{
            self.btnautorenew.isSelected = true
            self.strISAUTORENEW = "1"
            self.updateDataRenewmodelSubscriptionmodelTableAUTORENEW(strselectedautorenew: "1")
        }
    }
    
    //MARK: - Update SubscriptionmodelTable data Renewmodel AUTONENEW exist or not
    func updateDataRenewmodelSubscriptionmodelTableAUTORENEW(strselectedautorenew:String)
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@", strcustomerid)
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            if result.count > 0
            {
                // result available
                
                for data in result as! [NSManagedObject]{
                    
                    data.setValue(strselectedautorenew, forKey: "isrenew")
                }
            }
            else{
                //result not available
            }
        }catch {
            print("err")
        }
    }
    //MARK: - Fetch SubscriptionmodelTable data Renewmodel AUTONENEW exist or not
    func fetchDataRenewmodelSubscriptionmodelTableAUTORENEW()
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@", strcustomerid)
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            if result.count > 0
            {
                // result available
                
                for data in result as! [NSManagedObject]{
                    
                    let strautonewcode = data.value(forKeyPath: "isrenew") ?? ""
                    print("strautonewcode", strautonewcode)

                    if strautonewcode as! String == "0"
                    {
                        self.btnautorenew.isSelected = false
                        self.strISAUTORENEW = "0"
                    }
                    else{
                        self.btnautorenew.isSelected = true
                        self.strISAUTORENEW = "1"
                    }
                }
            }
            else{
                //result not available
            }
        }catch {
            print("err")
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
            if self.strsubscriptionplanid == "1"
            {
                //DAILY
                self.fetchcounter(strtablenam: "Renewmodelproduct")
                
                if productcount < 10
                {
                    let alert = UIAlertController(title: myAppDelegate.changeLanguage(key: "msg_language330"), message: myAppDelegate.changeLanguage(key: "msg_language64"), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if self.strsubscriptionplanid == "2"
            {
                //WEEKLY
                self.fetchcounter(strtablenam: "Renewmodelproduct")
                
                if productcount < 3
                {
                    let alert = UIAlertController(title: myAppDelegate.changeLanguage(key: "msg_language330"), message: myAppDelegate.changeLanguage(key: "msg_language65"), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if self.strsubscriptionplanid == "3"
            {
                //MONTHLY
                self.fetchcounter(strtablenam: "Renewmodelproduct")
                
                if productcount < 8
                {
                    let alert = UIAlertController(title: myAppDelegate.changeLanguage(key: "msg_language330"), message: myAppDelegate.changeLanguage(key: "msg_language65"), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            //Other Validation check
            
            if strSUBTOTAL == "" || strSUBTOTAL == "0.00"
            {
                let alert = UIAlertController(title: nil, message: myAppDelegate.changeLanguage(key: "msg_language331"), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                
                if btnfullpayment.isSelected == true
                {
                    let ctrl = renewaddresstimeslot(nibName: "renewaddresstimeslot", bundle: nil)
                    ctrl.strSubscriptionID = self.strmainPreviousSubscriptionid
                    ctrl.strautorenew = strISAUTORENEW
                    ctrl.strsubtotalamount = strSUBTOTAL
                    ctrl.strshippingchargesamount = strSHIPPING
                    ctrl.strgrandtotalamount = strGRANDTOTAL
                    ctrl.strpaymentype = self.strSelectedpaymentoption
                    ctrl.strplanid = self.strsubscriptionplanid
                    ctrl.arrmShippingchargeslist = self.arrMshippingcalculationOutput
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                else if btnfirst3payment.isSelected == true
                {
                    
                    let ctrl = renewaddresstimeslot(nibName: "renewaddresstimeslot", bundle: nil)
                    ctrl.strSubscriptionID = self.strmainPreviousSubscriptionid
                    ctrl.strautorenew = strISAUTORENEW
                    ctrl.strsubtotalamount = strSUBTOTAL
                    ctrl.strshippingchargesamount = strSHIPPING
                    ctrl.strgrandtotalamount = strGRANDTOTAL
                    ctrl.strpaymentype = self.strSelectedpaymentoption
                    ctrl.strplanid = self.strsubscriptionplanid
                    ctrl.arrmShippingchargeslist = self.arrMshippingcalculationOutput
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                
            }
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
        var flttotalGRANDTOTAL = Float()
        
        for x in 0 ..< self.arrMordereview.count
        {
            let dict = self.arrMordereview.object(at: x)as? NSDictionary
            let strdate = String(format: "%@", dict!.value(forKey: "date")as? String ?? "")
            
            var flttotalprice = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From Renewmodelproduct TABLE As per ROW DATE -------------//
            let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
            let manageContent2 = appDelegate2.persistentContainer.viewContext
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
                            
                            let intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                            let intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                            let intproductprice = Float(String(format: "%@", productprice as! CVarArg))
                            
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + intqtyall!
                            let fltsubtotalprice = Float(Float(intproductprice!) * Float(inttotalqty))
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
            
            var fltshpp  = 0.0
            if flttotalprice > Constants.conn.CutOffSubscriptionOrderTotal{
                fltshpp = 0.00
            }
            else if flttotalprice == 0.00 {
                fltshpp = 0.00
            }
            else{
                fltshpp = 5.00
            }
            
            flttotalSUBTOTAL = flttotalSUBTOTAL + Float(flttotalprice)
            flttotalSHIPPING = flttotalSHIPPING + Float(fltshpp)
        }
        print("flttotalSUBTOTAL",flttotalSUBTOTAL)
        print("flttotalSHIPPING",flttotalSHIPPING)
        
        flttotalGRANDTOTAL = flttotalSUBTOTAL + flttotalSHIPPING
        print("flttotalGRANDTOTAL",flttotalGRANDTOTAL)
        
        strSUBTOTAL = String(format: "%0.2f", flttotalSUBTOTAL)
        strSHIPPING = String(format: "%0.2f", flttotalSHIPPING)
        strGRANDTOTAL = String(format: "%0.2f", flttotalGRANDTOTAL)
        
        self.lblsubtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") ,strSUBTOTAL)
        self.lblshippingvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") , strSHIPPING)
        self.lblgrandtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") , strGRANDTOTAL)
    }
    func calculate3DAYSPAY()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var flttotalSUBTOTAL = Float()
        var flttotalSHIPPING = Float()
        var flttotalGRANDTOTAL = Float()
        
        for x in 0 ..< 3
        {
            let dict = self.arrMordereview.object(at: x)as? NSDictionary
            let strdate = String(format: "%@", dict!.value(forKey: "date")as? String ?? "")
            
            var flttotalprice = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From Renewmodelproduct TABLE As per ROW DATE -------------//
            let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
            let manageContent2 = appDelegate2.persistentContainer.viewContext
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
                            
                            let intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                            let intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                            let intproductprice = Float(String(format: "%@", productprice as! CVarArg))
                            
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + intqtyall!
                            let fltsubtotalprice = Float(Float(intproductprice!) * Float(inttotalqty))
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
            
            var fltshpp  = 0.0
            if flttotalprice > Constants.conn.CutOffSubscriptionOrderTotal{
                fltshpp = 0.00
            }
            else if flttotalprice == 0.00 {
                fltshpp = 0.00
            }
            else{
                fltshpp = 5.00
            }
            
            flttotalSUBTOTAL = flttotalSUBTOTAL + Float(flttotalprice)
            flttotalSHIPPING = flttotalSHIPPING + Float(fltshpp)
        }
        print("flttotalSUBTOTAL",flttotalSUBTOTAL)
        print("flttotalSHIPPING",flttotalSHIPPING)
        
        flttotalGRANDTOTAL = flttotalSUBTOTAL + flttotalSHIPPING
        print("flttotalGRANDTOTAL",flttotalGRANDTOTAL)
        
        strSUBTOTAL = String(format: "%0.2f", flttotalSUBTOTAL)
        strSHIPPING = String(format: "%0.2f", flttotalSHIPPING)
        strGRANDTOTAL = String(format: "%0.2f", flttotalGRANDTOTAL)
        
        self.lblsubtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strSUBTOTAL)
        self.lblshippingvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strSHIPPING)
        self.lblgrandtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strGRANDTOTAL)
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tabveditpopupitems
        {
            return self.arrMProductItemsEdit.count
        }
        
        if arrMordereview.count == 0 {
            self.tabvorderlist.setEmptyMessage(msg)
        } else {
            self.tabvorderlist.restore()
        }
        return arrMordereview.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tabveditpopupitems
        {
            return 155
        }
        
        return 115
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
            
            let strproduct_id = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
            let strproduct_name = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
            let strproduct_price = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
            let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
            let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
            
            cell.imgvproduct.isHidden = true
            
            cell.lblname.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblname.frame.origin.y, width: cell.lblname.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblname.frame.size.height)
            cell.lblspec.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblspec.frame.origin.y, width: cell.lblspec.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblspec.frame.size.height)
            cell.lblunitprice.frame = CGRect(x: cell.imgvproduct.frame.minX, y: cell.lblunitprice.frame.origin.y, width: cell.lblunitprice.frame.size.width + cell.imgvproduct.frame.size.width, height: cell.lblunitprice.frame.size.height)
            
            cell.lblname.text = strproduct_name
            cell.lblspec.isHidden = true
            
            let fltamount  = (strproduct_price as NSString).floatValue
            cell.lblunitprice.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltamount)
            
            cell.btnremove.tag = indexPath.row
            cell.btnremove.addTarget(self, action: #selector(pressEditPopupRemove), for: .touchUpInside)
            
            //CELL ADD ONCE & ADD TO ALL
            cell.btnaddonce.layer.cornerRadius = 14.0
            cell.btnaddonce.layer.masksToBounds = true
            
            cell.btnaddtoall.setTitleColor(UIColor(named: "orangecolor")!, for: .normal)
            cell.btnaddtoall.layer.cornerRadius = 14.0
            cell.btnaddtoall.layer.borderWidth = 1.0
            cell.btnaddtoall.layer.borderColor = UIColor(named: "orangecolor")!.cgColor
            cell.btnaddtoall.layer.masksToBounds = true
            
            
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
            
            let lblSeparator = UILabel(frame: CGRect(x: 0, y: 154.5, width: tableView.frame.size.width, height: 0.5))
            lblSeparator.backgroundColor = UIColor(named: "graybordercolor")!
            cell.contentView.addSubview(lblSeparator)
            
            return cell;
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvsubscriptionOR
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        
        let dictm = self.arrMordereview.object(at: indexPath.row)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        
        cell.lblsubscriptiondate.text = String(format: "%@",strdate)
        
        
        var strdayvalue = ""
        if strday.containsIgnoreCase("1"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language489")
        }
        else if strday.containsIgnoreCase("2"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language490")
        }
        if strday.containsIgnoreCase("3"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language491")
        }
        if strday.containsIgnoreCase("4"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language492")
        }
        if strday.containsIgnoreCase("5"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language493")
        }
        if strday.containsIgnoreCase("6"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language494")
        }
        if strday.containsIgnoreCase("0"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language495")
        }
        cell.lblsubscriptionday.text = String(format: "%@",strdayvalue)
        
        cell.viewoverall.layer.borderWidth = 1.0
        cell.viewoverall.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewoverall.layer.cornerRadius = 2.0
        cell.viewoverall.layer.masksToBounds = true
        
        cell.btndetail.layer.cornerRadius = 6.0
        cell.btndetail.layer.masksToBounds = true
        
        cell.btndetail.tag = indexPath.row
        cell.btndetail.addTarget(self, action: #selector(pressDetail), for: .touchUpInside)
        
        cell.btnAddMore.tag = indexPath.row
        cell.btnAddMore.addTarget(self, action: #selector(pressAddMoreProducts), for: .touchUpInside)
        
        
        var flttotalproductcount = 0.00
        var flttotalprice = 0.00
        //----------------- ADD ALL SUBTOTAL PRICE From Renewmodelproduct TABLE As per ROW DATE -------------//
        let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
        let manageContent2 = appDelegate2.persistentContainer.viewContext
        let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
                        flttotalproductcount = flttotalproductcount + 1.00
                        
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
        
        
        print("flttotalproductcount",flttotalproductcount as Any)
        print("flttotalprice",flttotalprice as Any)
        
        cell.lbltotalproducts.text = String(format: "%@ :%0.0f",myAppDelegate.changeLanguage(key: "msg_language87"),flttotalproductcount)
        cell.lblsubtotal.text = String(format: "%@ %@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language88"),myAppDelegate.changeLanguage(key: "msg_language481"),flttotalprice)
        
        //cell.lbldeliverydate.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language89"),strday)
        //cell.lbldeliverydate1.text = String(format: "%@",strdate)
        
        
        if flttotalproductcount > 0.00{
            cell.btndetail.isHidden = false
        }else{
            cell.btndetail.isHidden = true
        }
        
        if flttotalprice >= Constants.conn.CutOffSubscriptionOrderTotal //15.00
        {
            //HIDE WARNING ICON
            cell.viewoverall.backgroundColor = .white
            cell.viewleft.backgroundColor = .white
            cell.btnwarning.isHidden = true
            cell.lblwarning.isHidden = true
        }
        else if flttotalprice < Constants.conn.CutOffSubscriptionOrderTotal //15.00
        {
            //SHOW WARNING ICON
            cell.viewoverall.backgroundColor = UIColor(named: "lightred")!
            cell.viewleft.backgroundColor = UIColor(named: "lightred")!
            cell.btnwarning.isHidden = false
            cell.lblwarning.isHidden = false
        }
        
        if strSelectedpaymentoption == "FULL"{
            //No Yellow Top 3 ROWS
        }else{
            //Full Yellow color background Top 3 ROWS
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2{
                cell.viewleft.backgroundColor = UIColor(named: "plate6")!
                cell.viewoverall.backgroundColor = UIColor(named: "plate6")!
            }
        }
        
        cell.lblwarning.text = String(format: "%@ %0.2f %@", myAppDelegate.changeLanguage(key: "msg_language335"),Constants.conn.CutOffSubscriptionOrderTotal,myAppDelegate.changeLanguage(key: "msg_language447"))
        cell.btnAddMore.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language92")), for: .normal)
        cell.btndetail.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language73")), for: .normal)
        
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 149.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor(named: "graybordercolor")!
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tabveditpopupitems
        {
        }
        else
        {
            
        }
    }
    
    //MARK: - press Details Method
    @objc func pressDetail(sender:UIButton)
    {
        let dictm = self.arrMordereview.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        
        self.createEditpopupDatewiseItems(selecteddateindex: sender.tag,strdayname:strdayname,strdate:strdate)
    }
    @objc func pressAddMoreProducts(sender:UIButton)
    {
        let dictm = self.arrMordereview.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        print("strsubscriptionplanid",self.strsubscriptionplanid)
        
        
        let ctrl = renewsubscriptionaddproduct(nibName: "renewsubscriptionaddproduct", bundle: nil)
        ctrl.strselectedsubscriptionplanid = self.strsubscriptionplanid
        ctrl.strselecteddate = strdate
        ctrl.strselectedday = strday
        ctrl.strselecteddayname = strdayname
        ctrl.strpagefrom = "1230"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - create POPUP EDIT ITEMS DATE WISE method
    func createEditpopupDatewiseItems(selecteddateindex:Int,strdayname:String,strdate:String)
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
        
     
        self.lbleditpopupDateDay.text = String(format: "%@ (%@)", strdate,strdayname)
        
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
    
    
    
    //MARK: - press ADDONCE && ADDTOALL method
    @objc func pressaddonce(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let dayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
        let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
        let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
        
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
                        var intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                        intqtyonce = intqtyonce! + 1 // ADDONCE + 1 INCREAMENTAL WHEN CLICK ON PLUS ICON
                        
                        let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                        var intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                        
                        if intqtyall != 0.00
                        {
                            //qtyall available only update add once qty
                            
                            data1.setValue(String(format: "%.0f", intqtyonce!), forKey: "qtyonce")
                            
                        }
                        else
                        {
                            //qtyall not available add new  add once qty
                            
                            let intsubtotalprice = Float(strproductprice)! * 1
                            print("intsubtotalprice",intsubtotalprice)
                            
                            //------------------- INSERT INTO Dailyproduct TABLE ---------------- //
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                            let manageContent = appDelegate.persistentContainer.viewContext
                            let userEntity = NSEntityDescription.entity(forEntityName: "Renewmodelproduct", in: manageContent)!
                            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                            users.setValue(strdate, forKeyPath: "date")
                            users.setValue(strday, forKeyPath: "day")
                            users.setValue(dayname, forKeyPath: "dayname")
                            users.setValue(strproductid, forKeyPath: "productid")
                            users.setValue(strproductimage, forKeyPath: "productimage")
                            users.setValue(strproductname, forKeyPath: "productname")
                            users.setValue(strproductprice, forKeyPath: "productprice")
                            users.setValue("0", forKeyPath: "qtyall")
                            users.setValue("1", forKeyPath: "qtyonce")
                            users.setValue(self.strsubscriptionplanid, forKeyPath: "subscriptionid")
                            users.setValue(strcustomerid, forKeyPath: "userid")
                        
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
                
                let intsubtotalprice = Float(strproductprice)! * 1
                print("intsubtotalprice",intsubtotalprice)
                
                //------------------- INSERT INTO product TABLE ---------------- //
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent = appDelegate.persistentContainer.viewContext
                let userEntity = NSEntityDescription.entity(forEntityName: "Renewmodelproduct", in: manageContent)!
                let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                users.setValue(strdate, forKeyPath: "date")
                users.setValue(strday, forKeyPath: "day")
                users.setValue(dayname, forKeyPath: "dayname")
                users.setValue(strproductid, forKeyPath: "productid")
                users.setValue(strproductimage, forKeyPath: "productimage")
                users.setValue(strproductname, forKeyPath: "productname")
                users.setValue(strproductprice, forKeyPath: "productprice")
                users.setValue("0", forKeyPath: "qtyall")
                users.setValue("1", forKeyPath: "qtyonce")
                users.setValue(self.strsubscriptionplanid, forKeyPath: "subscriptionid")
                users.setValue(strcustomerid, forKeyPath: "userid")
                do{
                    try manageContent.save()
                }catch let error as NSError {
                    print("could not save . \(error), \(error.userInfo)")
                }
            }
        }catch {
            print("err")
        }
        
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
        self.refreshmainlist()
        self.tabvorderlist.reloadData()
    }
    @objc func pressaddtoall(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
        let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
        let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        let intsubtotalprice = Float(strproductprice)! * 1
        print("intsubtotalprice",intsubtotalprice)
        
        for x in 0 ..< self.arrMordereview.count
        {
            let dict = self.arrMordereview.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICI DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
                            
                            let intqtyonce = Int(String(format: "%@", qtyonce as! CVarArg))
                            let intqtyall = Int(String(format: "%@", qtyall as! CVarArg))
                            var inttotalqty = Int()
                            inttotalqty = intqtyonce! + (intqtyall! + 1)
                            
                            data1.setValue(String(format: "%d", (intqtyall! + 1)), forKey: "qtyall")
                            
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
                    
                    //------------------- INSERT INTO product TABLE ---------------- //
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent = appDelegate.persistentContainer.viewContext
                    let userEntity = NSEntityDescription.entity(forEntityName: "Renewmodelproduct", in: manageContent)!
                    let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                    users.setValue(strdate, forKeyPath: "date")
                    users.setValue(strday, forKeyPath: "day")
                    users.setValue(strdayname, forKeyPath: "dayname")
                    users.setValue(strproductid, forKeyPath: "productid")
                    users.setValue(strproductimage, forKeyPath: "productimage")
                    users.setValue(strproductname, forKeyPath: "productname")
                    users.setValue(strproductprice, forKeyPath: "productprice")
                    users.setValue("1", forKeyPath: "qtyall")
                    users.setValue("0", forKeyPath: "qtyonce")
                    users.setValue(self.strsubscriptionplanid, forKeyPath: "subscriptionid")
                    users.setValue(strcustomerid, forKeyPath: "userid")
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
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
        self.refreshmainlist()
        self.tabvorderlist.reloadData()
    }
    
    //MARK: - press ADDONCE PLUS && MINUS method
    @objc func pressplus(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
        let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
        let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
        let strproductsize = String(format: "%@", dictm.value(forKey: "productsize")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
       
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
                        var intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                        intqtyonce = intqtyonce! + 1 // ADDONCE + 1 INCREAMENTAL WHEN CLICK ON PLUS ICON
                        
                        let qtyall = data1.value(forKeyPath: "qtyall") ?? ""
                        var intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                        
                        var inttotalqty = Float()
                        inttotalqty = intqtyonce! + intqtyall!
                        
                        data1.setValue(String(format: "%.0f", intqtyonce!), forKey: "qtyonce")
                        
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
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
        self.refreshmainlist()
        self.tabvorderlist.reloadData()
        
    }
    @objc func pressminus(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
        let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
        let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
        let strproductsize = String(format: "%@", dictm.value(forKey: "productsize")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")

        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
    
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
        self.refreshmainlist()
        self.tabvorderlist.reloadData()
    }
    
    //MARK: - press ADDTOALL PLUS && MINUS method
    @objc func pressplusATA(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
        let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
        let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
        let strproductsize = String(format: "%@", dictm.value(forKey: "productsize")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
       
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        
        for x in 0 ..< arrMordereview.count
        {
            let dict = self.arrMordereview.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
        self.refreshmainlist()
        self.tabvorderlist.reloadData()
    }
    @objc func pressminusATA(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strdayname = String(format: "%@", dictm.value(forKey: "dayname")as? String ?? "")
        let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
        let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
        let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
        let strproductsize = String(format: "%@", dictm.value(forKey: "productsize")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
        let strselected = String(format: "%@", dictm.value(forKey: "selected")as? String ?? "")
        let strsubtotal = String(format: "%@", dictm.value(forKey: "subtotal")as? String ?? "")
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
       
        
        for x in 0 ..< arrMordereview.count
        {
            let dict = self.arrMordereview.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
        self.refreshmainlist()
        self.tabvorderlist.reloadData()
    }
    
    //MARK: - press REMOVE Product Item from Date Specfic Method
    @objc func pressEditPopupRemove(sender:UIButton)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        
        //REMOVE Renewmodelproduct TABLE ROW
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
        fetchData.predicate = NSPredicate(format: "date = %@ && productid = %@",strdate,strproductid)
        let objects = try! manageContent.fetch(fetchData)
        for obj in objects {
            manageContent.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //fetch product items from Renewmodelproduct Table Data
        self.fetchTABLEProductItems(strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
        self.refreshmainlist()
        self.tabvorderlist.reloadData()
    }
    
    
    
    //MARK: - get All Coupons API method
    /*func getallCoupons()
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
                            
                            let fltamount111  = (self.strDISCOUNTAMOUNT as NSString).floatValue
                            
                            self.lblgrandtotal.text = String(format: "%@: (%@ %@ %0.2f)",myAppDelegate.changeLanguage(key: "msg_language86"),myAppDelegate.changeLanguage(key: "msg_language443"),myAppDelegate.changeLanguage(key: "msg_language481"), fltamount111)
                            
                            
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
    }*/
    
    
    //MARK: - Fetch Renewmodel TABLE data
    func fetchTABLERenewmodel()
    {
        if self.arrMordereview.count > 0{
            self.arrMordereview.removeAllObjects()
        }
        
        
        //----- FETCH ALL DATE DAY LIST FROM RENEW MODEL TABLE ------------//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodel")
        fetchData.predicate = NSPredicate(format: "userid = %@", strcustomerid)
        do {
            let result = try manageContent.fetch(fetchData)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    dictemp.setValue(data.value(forKeyPath: "dayname") ?? "", forKey: "dayname")
                    dictemp.setValue(data.value(forKeyPath: "isrenew") ?? "", forKey: "isrenew")
                    self.arrMordereview.add(dictemp)
                }
            }
        }catch {
            print("err")
        }
        print("self.arrMordereview",self.arrMordereview)
        
        let dictm = self.arrMordereview.object(at: 0)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strisrenew = String(format: "%@", dictm.value(forKey: "isrenew")as? String ?? "")
        self.txtstartdate.text = strdate
        self.strSelectedStartDate = strdate
        
        if strisrenew == "0"{
            self.btnautorenew.isSelected = false
            self.strISAUTORENEW = "0"
        }else{
            self.btnautorenew.isSelected = true
            self.strISAUTORENEW = "1"
        }
        
        //BY DAFULT FULL PAY
        self.strSelectedpaymentoption = "FULL"
        self.btnfullpayment.isSelected = true
        self.btnfirst3payment.isSelected = false
        
        calculateFullPAY()

        self.tabvorderlist.reloadData()
    }
    
    //MARK: - Fetch Porudcut Items TABLE data
    func fetchTABLEProductItems(strselecteddate:String)
    {
        if self.arrMProductItemsEdit.count > 0{
            self.arrMProductItemsEdit.removeAllObjects()
        }
        
        //----- FETCH ALL DATE DAY LIST FROM PRODUCT ITEMS Renewmodelproduct TABLE ------------//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
        fetchData.predicate = NSPredicate(format: "date = %@",strselecteddate)
        do {
            let result = try manageContent.fetch(fetchData)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    dictemp.setValue(data.value(forKeyPath: "dayname") ?? "", forKey: "dayname")
                    dictemp.setValue(data.value(forKeyPath: "productid") ?? "", forKey: "productid")
                    dictemp.setValue(data.value(forKeyPath: "productimage") ?? "", forKey: "productimage")
                    dictemp.setValue(data.value(forKeyPath: "productname") ?? "", forKey: "productname")
                    dictemp.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "productprice")
                    dictemp.setValue(data.value(forKeyPath: "qtyall") ?? "", forKey: "qtyall")
                    dictemp.setValue(data.value(forKeyPath: "qtyonce") ?? "", forKey: "qtyonce")
                    
                    self.arrMProductItemsEdit.add(dictemp)
                }
            }
        }catch {
            print("err")
        }
        print("self.arrMProductItemsEdit",self.arrMProductItemsEdit)
        
        
        //Refresh Subtotal in popup if POPUP is OPEN
        if viewPopupAddNewExistingBG2 != nil
        {
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            var flttotal = 0.00
            for x in 0 ..< arrMProductItemsEdit.count
            {
                let dictemp = arrMProductItemsEdit.object(at: x)as? NSMutableDictionary
                
                let qtyonce = dictemp!.value(forKeyPath: "qtyonce") ?? ""
                let qtyall = dictemp!.value(forKeyPath: "qtyall") ?? ""
                let productprice = dictemp!.value(forKeyPath: "productprice") ?? ""
                
                let intqtyonce = Float(String(format: "%@", qtyonce as! CVarArg))
                let intqtyall = Float(String(format: "%@", qtyall as! CVarArg))
                let intproductprice = Float(String(format: "%@", productprice as! CVarArg))
                
                var inttotalqty = Float()
                inttotalqty = intqtyonce! + intqtyall!
                let fltsubtotalprice = Float(Float(intproductprice!) * Float(inttotalqty))
                print("fltsubtotalprice",fltsubtotalprice as Any)
                
                flttotal = flttotal + Double(fltsubtotalprice)
                
            }
            print("flttotal",flttotal)
            self.lblsubtotaleditpopupvalue.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), flttotal)
        }
    }
    
    
    var productcount = 0
    //MARK: - fetch daily date counter method
    func fetchcounter(strtablenam:String)
    {
        for x in 0 ..< self.arrMordereview.count
        {
            let dictm = self.arrMordereview.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dictm!.value(forKey: "date")as? String ?? "")
            
            var flttotalproductcount = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From Dailyproduct TABLE As per ROW DATE -------------//
            let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
            let manageContent2 = appDelegate2.persistentContainer.viewContext
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: strtablenam)
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
                            
                            flttotalproductcount = flttotalproductcount + 1.00
                            
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
            
            if flttotalproductcount >= 1.0{
                productcount = productcount + 1
            }
            print("productcount",productcount)
            print("flttotalproductcount",flttotalproductcount as Any)
        }
        print("productcount",productcount)
    }
    
    
    //MARK: - get All My Renew subscription API method
    func getallRenewmysubscription(strid:String,strdate:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strdate1 = strdate.replacingOccurrences(of: "/", with: "-")
        print("strdate",strdate)
        print("strdate1",strdate1)
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?subscriptionId=%@&renewStartDate=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod69,strid,strdate1,strLangCode)
        print("strconnurl",strconnurl)
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
                            
                            let dicrenewdata = dictemp.value(forKey: "subscriptionRenewdata") as! NSDictionary
                            
                            self.insertallDataintoRenewdLocalBase(dicall: dicrenewdata)
                            
                            
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
    
    //MARK: - INSERT ALL DATA INTO RENEW LOCAL DATABSE EMTHOD
    func insertallDataintoRenewdLocalBase(dicall:NSDictionary)
    {
        //Remove Renewmodel table data
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodel")
        fetchData1.predicate = NSPredicate(format: "userid == %@", strcustomerid)
        let objects1 = try! manageContent1.fetch(fetchData1)
        for obj in objects1 {
            manageContent1.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent1.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Renewmodelproduct table data
        guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent2 = appDelegate2.persistentContainer.viewContext
        let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
        fetchData2.predicate = NSPredicate(format: "userid == %@", strcustomerid)
        let objects2 = try! manageContent2.fetch(fetchData2)
        for obj in objects2 {
            manageContent2.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent2.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        
        let strplanid = String(format: "%@", dicall.value(forKey: "plan_id")as? String ?? "")
        //1 Daily 2 Weekly 3 Monthly
        let arr1 = dicall.value(forKey: "subscription_order_details") as? NSArray ?? []
        
        for xx in 0 ..< arr1.count
        {
            let dictemp = arr1.object(at: xx)as? NSDictionary
            
            let strorder_date = String(format: "%@", dictemp?.value(forKey: "order_date")as? String ?? "")
            let strday = String(format: "%@", dictemp?.value(forKey: "day")as? String ?? "")
            let strday_name = String(format: "%@", dictemp?.value(forKey: "day_name")as? String ?? "")
            let strcurrency_code = String(format: "%@", dictemp?.value(forKey: "currency_code")as? String ?? "")
            let strorder_subtotal = String(format: "%@", dictemp?.value(forKey: "order_subtotal")as? String ?? "")
            let strshipping_amount = String(format: "%@", dictemp?.value(forKey: "shipping_amount")as? String ?? "")
            let strorder_grandtotal = String(format: "%@", dictemp?.value(forKey: "order_grandtotal")as? String ?? "")
            let strtax = String(format: "%@", dictemp?.value(forKey: "tax")as? String ?? "")
            let strpayment_status = String(format: "%@", dictemp?.value(forKey: "payment_status")as? String ?? "")
            
            let arr2 = dictemp?.value(forKey: "order_product") as? NSArray ?? []
            
            //------------------- INSERT INTO Renewmodel TABLE ---------------- //
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Renewmodel", in: manageContent)!
            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
            users.setValue(strplanid, forKeyPath: "subscriptionid")
            users.setValue(strcustomerid, forKeyPath: "userid")
            users.setValue(strorder_date, forKeyPath: "date")
            users.setValue(strday, forKeyPath: "day")
            users.setValue(strday_name, forKeyPath: "dayname")
            users.setValue("0", forKeyPath: "isrenew")
            users.setValue(strorder_subtotal, forKeyPath: "subtotal")
            users.setValue(strshipping_amount, forKeyPath: "shipping")
            do{
                try manageContent.save()
            }catch let error as NSError {
                print("could not save . \(error), \(error.userInfo)")
            }
            
            for yy in 0 ..< arr2.count
            {
                let dictemp = arr2.object(at: yy)as? NSDictionary
                
                let strproduct_id = String(format: "%@", dictemp?.value(forKey: "product_id")as? String ?? "")
                let strproduct_name = String(format: "%@", dictemp?.value(forKey: "product_name")as? String ?? "")
                let strproduct_price = String(format: "%@", dictemp?.value(forKey: "product_price")as? String ?? "")
                let strproduct_original_price = String(format: "%@", dictemp?.value(forKey: "product_original_price")as? String ?? "")
                let strqty = String(format: "%@", dictemp?.value(forKey: "qty")as? String ?? "")
                let strqty_all = String(format: "%@", dictemp?.value(forKey: "qty_all")as? String ?? "")
                let strdiscount_amount = String(format: "%@", dictemp?.value(forKey: "discount_amount")as? String ?? "")
                let strproduct_image = String(format: "%@", dictemp?.value(forKey: "product_image")as? String ?? "")
                 
                
                //------------------- INSERT INTO Renewmodelproduct TABLE ---------------- //
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let userEntity1 = NSEntityDescription.entity(forEntityName: "Renewmodelproduct", in: manageContent1)!
                let users1 = NSManagedObject(entity: userEntity1, insertInto: manageContent1)
                users1.setValue(strplanid, forKeyPath: "subscriptionid")
                users1.setValue(strcustomerid, forKeyPath: "userid")
                users1.setValue(strorder_date, forKeyPath: "date")
                users1.setValue(strday, forKeyPath: "day")
                users1.setValue(strday_name, forKeyPath: "dayname")
                users1.setValue(strproduct_id, forKeyPath: "productid")
                users1.setValue(strproduct_image, forKeyPath: "productimage")
                users1.setValue(strproduct_name, forKeyPath: "productname")
                users1.setValue(strproduct_price, forKeyPath: "productprice")
                users1.setValue(strqty, forKeyPath: "qtyonce")
                users1.setValue(strqty_all, forKeyPath: "qtyall")
                do{
                    try manageContent1.save()
                }catch let error1 as NSError {
                    print("could not save . \(error1), \(error1.userInfo)")
                }
            }
            
        }
        
        //REFRESH FETCHING ALL DATA AGIAIN
        self.refreshmainlist()
    }
    
    
    //MARK: - Refresh Main table List of Order Review
    func refreshmainlist()
    {
        self.fetchTABLERenewmodel()
        
        self.shippingchargescalculation()
    }
    //MARK: - create shipping calculation dictionary
    func shippingchargescalculation()
    {
        
        if self.arrMshippingcalculation.count > 0{
            self.arrMshippingcalculation.removeAllObjects()
        }
        
        
        //----- FETCH ALL DATE DAY LIST FROM MODEL TABLE ------------//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodel")
        fetchData.predicate = NSPredicate(format: "userid = %@", strcustomerid)
        
        do {
            let result = try manageContent.fetch(fetchData)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    self.arrMshippingcalculation.add(dictemp)
                }
            }
        }catch {
            print("err")
        }
        
        //----- FETCH ALL DATE DAY LIST FROM PRODUCT SUB-TOTAL TABLE ------------//
        for x in 0 ..< self.arrMshippingcalculation.count
        {
            let dict = self.arrMshippingcalculation.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            
            var flttotalprice = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From product TABLE As per ROW DATE -------------//
            let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
            let manageContent2 = appDelegate2.persistentContainer.viewContext
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
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
            
            dict?.setValue(String(format: "%0.2f", flttotalprice), forKey: "subtotal")
        }
        
        print("self.arrMshippingcalculation",self.arrMshippingcalculation)
        self.postshippingaddressCalculation(arrm: self.arrMshippingcalculation)
    }
    //MARK: - post Shipping Calculation List Method
    func postshippingaddressCalculation(arrm:NSMutableArray)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["items": arrm] as [String : Any]
        print("parameters",parameters)
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod36)
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
                    
                    let dictemp1 = dictemp.value(forKey: "shipping_charges_calculation")as? NSDictionary
                    
                    let strtaxtotal =  String(format: "%@", dictemp1!.value(forKey: "taxTotal")as! CVarArg)
                    print("strtaxtotal",strtaxtotal)
                    
                    let strmethod_name = dictemp1!.value(forKey: "method_name")as? String ?? ""
                    print("strmethod_name",strmethod_name)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            if self.arrMshippingcalculationOutput.count > 0 {
                                self.arrMshippingcalculationOutput.removeAllObjects()
                            }
                            let arrm = dictemp1!.value(forKey: "charges") as? NSArray ?? []
                            self.arrMshippingcalculationOutput = NSMutableArray(array: arrm)
                            print("arrMshippingcalculationOutput --->",self.arrMshippingcalculationOutput)
                            
                            
                            if self.strSelectedpaymentoption == "FULL"
                            {
                                var flttotalcharges = 0.00
                                for x in 0 ..< self.arrMshippingcalculationOutput.count
                                {
                                    let dict = self.arrMshippingcalculationOutput.object(at: x)as? NSDictionary
                                    //print("dict", dict)
                                    let strcharges = String(format: "%@", dict?.value(forKey: "delivery_charge")as! CVarArg)
                                    
                                    flttotalcharges = flttotalcharges + Double(strcharges)!
                                }
                                print("flttotalcharges",flttotalcharges)
                                self.strSHIPPING = String(format: "%0.2f", flttotalcharges)
                                
                                self.lblshippingvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") , self.strSHIPPING)
                            }
                            else
                            {
                                var flttotal1 = Float()
                                var flttotal2 = Float()
                                for x in 0 ..< 3
                                {
                                    let dictemp = self.arrMshippingcalculationOutput.object(at: x)as? NSDictionary
                                    
                                    let strdelivery_charge = String(format: "%@", dictemp?.value(forKey: "delivery_charge")as! CVarArg)
                                    let strsubtotal = String(format: "%@", dictemp?.value(forKey: "subtotal")as? String ?? "")
                                    
                                    let fltamount1  = (strdelivery_charge as NSString).floatValue
                                    let fltamount2  = (strsubtotal as NSString).floatValue
                                    flttotal1 = flttotal1 + fltamount1
                                    flttotal2 = flttotal2 + fltamount2
                                }
                                print("Delivery charges 3 days",flttotal1)
                                print("Subtotal 3 days",flttotal2)
                                self.strSUBTOTAL = String(format: "%0.2f", flttotal2)
                                self.strSHIPPING = String(format: "%0.2f", flttotal1)
                                
                                self.lblsubtotalvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") ,self.strSUBTOTAL)
                                self.lblshippingvalue.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481") , self.strSHIPPING)
                                
                            }
                            
                            
                            
                            self.tabvorderlist.reloadData()
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
