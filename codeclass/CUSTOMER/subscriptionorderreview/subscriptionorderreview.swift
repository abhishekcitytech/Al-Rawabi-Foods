//
//  subscriptionorderreview.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/07/22.
//

import UIKit
import CoreData

class subscriptionorderreview: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var lblmessageminimumorder: UILabel!
    @IBOutlet weak var imgvribbonsubscriptionplan: UIImageView!
    
    @IBOutlet weak var tabvordereview: UITableView!
    var reuseIdentifier1 = "celltabvsubscriptionOR"
    
    @IBOutlet weak var btnproceed: UIButton!
    
    @IBOutlet weak var lblminimumwarningshippingcost: UILabel!
    
    @IBOutlet weak var viewpaymentcondition: UIView!
    @IBOutlet weak var lblfullpayment: UILabel!
    @IBOutlet weak var lblfirst3payment: UILabel!
    @IBOutlet weak var btnfullpayment: UIButton!
    @IBOutlet weak var btnfirst3payment: UIButton!
    
    
    //POPUP EDIT PENCIL ITEMS DATE SPECIFIC
    @IBOutlet var viewpopupedititems: UIView!
    @IBOutlet weak var lbleditpopupDateDay: UILabel!
    @IBOutlet weak var btncrosseditpopup: UIButton!
    @IBOutlet weak var tabveditpopupitems: UITableView!
    @IBOutlet weak var lblsubtotaleditpopup: UILabel!
    @IBOutlet weak var lblitemsubtotal: UILabel!
    @IBOutlet weak var lblitembottommessage: UILabel!
    var reuseIdentifier2 = "celltabvprodustitemsedit"
    var viewPopupAddNewExistingBG2 = UIView()
    
    
    
    var arrMProductItemsEdit = NSMutableArray()
    
    @IBOutlet weak var btnclearall: UIButton!
    
    
    //DELIVERY SLOTS DATE
    @IBOutlet var viewdateslotsdeliverypopup: UIView!
    @IBOutlet weak var lblheaderpopupdeliveryslot: UILabel!
    @IBOutlet weak var scrollviewdeliveryslotpopup: UIScrollView!
    
    @IBOutlet weak var lblpopupdeliveryslot11: UILabel!
    @IBOutlet weak var lblpopupdeliveryslot22: UILabel!
    @IBOutlet weak var lblpopupdeliveryslot33: UILabel!
    @IBOutlet weak var lblpopupdeliveryslot44: UILabel!
    
    @IBOutlet weak var txtsubsriptionplanpopup2: UITextField!
    @IBOutlet weak var txtsubscriptionstartdatepopup2: UITextField!
    @IBOutlet weak var txtsubscriptionenddatepopup2: UITextField!
    
    @IBOutlet weak var btnmorningslot: UIButton!
    @IBOutlet weak var btnafternoonslot: UIButton!
    @IBOutlet weak var btneveningslot: UIButton!
    
    @IBOutlet weak var lbltime1: UILabel!
    @IBOutlet weak var lbltime2: UILabel!
    @IBOutlet weak var lbltime3: UILabel!
    
    @IBOutlet weak var lbltime111: UILabel!
    @IBOutlet weak var lbltime222: UILabel!
    @IBOutlet weak var lbltime333: UILabel!
    
    @IBOutlet weak var btncrossdateslotspopup: UIButton!
    @IBOutlet weak var btnsavedateslotspopup: UIButton!
    var viewPopupAddNewExistingBG3 = UIView()
    
    var arrMordereview = NSMutableArray()
    
    var strpageidentifier = ""
    var strpageidentifierplanname = ""
    
    var strFulladdress = ""
    var strFulladdressLocationname = ""
    var strFulladdressCityname = ""
    
    var strSubtotalAmount = ""
    var strShippingchargesAmount = ""
    var strTotalTaxAmount = ""
    
    var arrMAvailbleTimeSlots = NSMutableArray()
    
    var arrMshippingcalculation = NSMutableArray()
    var arrMshippingcalculationOutput = NSMutableArray()
    
    var strSelectedTimeSlotID = ""
    var strSelectedTimeSlotNAME = ""
    
    var strSelectedpaymentoption = ""
    
    var strSelectedLATITUDE = ""
    var strSelectedLONGITUDE = ""
    
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
        
        self.refreshmainlist()
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language81")
        
        btnclearall.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language334")), for: .normal)
        btnproceed.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language98")), for: .normal)
        lblminimumwarningshippingcost.text = String(format: "%@ %0.2f %@", myAppDelegate.changeLanguage(key: "msg_language335"),Constants.conn.CutOffSubscriptionOrderTotal,myAppDelegate.changeLanguage(key: "msg_language447"))
        lblfullpayment.text = myAppDelegate.changeLanguage(key: "msg_language336")
        lblfirst3payment.text = myAppDelegate.changeLanguage(key: "msg_language337")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        viewpaymentcondition.layer.borderWidth = 2.0
        viewpaymentcondition.layer.borderColor = UIColor(named: "lightblue")!.cgColor
        viewpaymentcondition.layer.cornerRadius = 6.0
        viewpaymentcondition.layer.masksToBounds = true
        
        
        tabvordereview.register(UINib(nibName: "celltabvsubscriptionOR", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvordereview.separatorStyle = .none
        tabvordereview.backgroundView = nil
        tabvordereview.backgroundColor=UIColor.clear
        tabvordereview.separatorColor=UIColor.clear
        tabvordereview.showsVerticalScrollIndicator = false
        
        btnproceed.layer.borderWidth = 1.0
        btnproceed.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnproceed.layer.cornerRadius = 18.0
        btnproceed.layer.masksToBounds = true
        
        btnclearall.layer.cornerRadius = 16.0
        btnclearall.layer.masksToBounds = true
        
        if strpageidentifier == "100"{
            lblmessageminimumorder.text = myAppDelegate.changeLanguage(key: "msg_language64")
            //self.imgvribbonsubscriptionplan.image = UIImage(named: "ribbonlinedaily")
        }
        else if strpageidentifier == "200"{
            lblmessageminimumorder.text = myAppDelegate.changeLanguage(key: "msg_language65")
            //self.imgvribbonsubscriptionplan.image = UIImage(named: "ribbonlineweekly")
        }
        else if strpageidentifier == "300"{
            lblmessageminimumorder.text = myAppDelegate.changeLanguage(key: "msg_language66")
            //self.imgvribbonsubscriptionplan.image = UIImage(named: "ribbonlinemonthly")
        }
        
        if arrMordereview.count == 0{
            hideviewall()
        }else{
            unhideviewall()
        }
        
        if strSelectedpaymentoption == "FULL"{
            self.btnfullpayment.isSelected = true
            self.btnfirst3payment.isSelected = false
        }
        else if strSelectedpaymentoption == "THREE"{
            self.btnfullpayment.isSelected = false
            self.btnfirst3payment.isSelected = true
        }
        else{
            strSelectedpaymentoption = "FULL"
            self.btnfullpayment.isSelected = true
            self.btnfirst3payment.isSelected = false
        }
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Refresh Main table List of Order Review
    func refreshmainlist()
    {
        if strpageidentifier == "100"{
            //DAILY
            self.fetchTABLEDailymodel()
        }
        else if strpageidentifier == "200"{
            //WEEKLY
            self.fetchTABLEWeeklymodel()
        }
        else if strpageidentifier == "300"{
            //MONTHLY
            self.fetchTABLEMonthlymodel()
        }
        
        self.shippingchargescalculation()
    }
    
    //MARK: - create Hide tableview bottom
    func hideviewall()
    {
        tabvordereview.isHidden = true
        btnclearall.isHidden = true
        btnproceed.isHidden = true
        lblminimumwarningshippingcost.isHidden = true
    }
    func unhideviewall()
    {
        tabvordereview.isHidden = false
        btnclearall.isHidden = false
        btnproceed.isHidden = false
        lblminimumwarningshippingcost.isHidden = true
    }
    
    //MARK: -  press proceed method
    @IBAction func pressproceed(_ sender: Any)
    {
        print("strSubtotalAmount",strSubtotalAmount)
        print("strShippingchargesAmount",strShippingchargesAmount)
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if strpageidentifier == "100"
        {
            //DAILY
            self.fetchcounter(strtablenam: "Dailyproduct")
            
            if productcount < 10
            {
                let alert = UIAlertController(title: myAppDelegate.changeLanguage(key: "msg_language330"), message: myAppDelegate.changeLanguage(key: "msg_language64"), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            self.fetchcounter(strtablenam: "Weeklyproduct")
            
            if productcount < 3
            {
                let alert = UIAlertController(title: myAppDelegate.changeLanguage(key: "msg_language330"), message: myAppDelegate.changeLanguage(key: "msg_language65"), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            self.fetchcounter(strtablenam: "Monthlyproduct")
            
            if productcount < 8
            {
                let alert = UIAlertController(title: myAppDelegate.changeLanguage(key: "msg_language330"), message: myAppDelegate.changeLanguage(key: "msg_language65"), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //Other Validation check
        
        if strSelectedTimeSlotID == "" && strSelectedTimeSlotNAME == ""
        {
            let alert = UIAlertController(title: nil, message: myAppDelegate.changeLanguage(key: "msg_language266"), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if strSubtotalAmount == "" || strSubtotalAmount == "0.00"
        {
            let alert = UIAlertController(title: nil, message: myAppDelegate.changeLanguage(key: "msg_language331"), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
            if btnfullpayment.isSelected == true
            {
                /*let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language332"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")

                    let ctrl = SubscriptionShippingAddress(nibName: "SubscriptionShippingAddress", bundle: nil)
                    ctrl.strpageidentifier = strpageidentifier
                    ctrl.strpageidentifierplanname = strpageidentifierplanname
                    ctrl.strsubtotalamount = strSubtotalAmount
                    ctrl.strshippingchargesamount = strShippingchargesAmount
                    ctrl.strselectedslotid = self.strSelectedTimeSlotID
                    ctrl.strselectedslotname = self.strSelectedTimeSlotNAME
                    ctrl.strpaymentype = self.strSelectedpaymentoption
                    ctrl.arrmShippingchargeslist = self.arrMshippingcalculationOutput
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }))
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                self.present(refreshAlert, animated: true, completion: nil)*/
                
                let ctrl = SubscriptionShippingAddress(nibName: "SubscriptionShippingAddress", bundle: nil)
                ctrl.strpageidentifier = strpageidentifier
                ctrl.strpageidentifierplanname = strpageidentifierplanname
                ctrl.strsubtotalamount = strSubtotalAmount
                ctrl.strshippingchargesamount = strShippingchargesAmount
                ctrl.strselectedslotid = self.strSelectedTimeSlotID
                ctrl.strselectedslotname = self.strSelectedTimeSlotNAME
                ctrl.strpaymentype = self.strSelectedpaymentoption
                ctrl.arrmShippingchargeslist = self.arrMshippingcalculationOutput
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if btnfirst3payment.isSelected == true
            {
                /*let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language333"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")

                    let ctrl = SubscriptionShippingAddress(nibName: "SubscriptionShippingAddress", bundle: nil)
                    ctrl.strpageidentifier = strpageidentifier
                    ctrl.strpageidentifierplanname = strpageidentifierplanname
                    ctrl.strsubtotalamount = strSubtotalAmount
                    ctrl.strshippingchargesamount = strShippingchargesAmount
                    ctrl.strselectedslotid = self.strSelectedTimeSlotID
                    ctrl.strselectedslotname = self.strSelectedTimeSlotNAME
                    ctrl.strpaymentype = self.strSelectedpaymentoption
                    ctrl.arrmShippingchargeslist = self.arrMshippingcalculationOutput
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }))
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                self.present(refreshAlert, animated: true, completion: nil)*/
                
                let ctrl = SubscriptionShippingAddress(nibName: "SubscriptionShippingAddress", bundle: nil)
                ctrl.strpageidentifier = strpageidentifier
                ctrl.strpageidentifierplanname = strpageidentifierplanname
                ctrl.strsubtotalamount = strSubtotalAmount
                ctrl.strshippingchargesamount = strShippingchargesAmount
                ctrl.strselectedslotid = self.strSelectedTimeSlotID
                ctrl.strselectedslotname = self.strSelectedTimeSlotNAME
                ctrl.strpaymentype = self.strSelectedpaymentoption
                ctrl.arrmShippingchargeslist = self.arrMshippingcalculationOutput
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            
        }
        
    }
    
    //MARK: - press clear all method
    @IBAction func pressClearAll(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language82"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            
            if strpageidentifier == "100"
            {
                //DAILY
                
                //REMOVE Subscriptionmodel TABLE ROW
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent = appDelegate.persistentContainer.viewContext
                let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
                let objects = try! manageContent.fetch(fetchData)
                for obj in objects {
                    manageContent.delete(obj as! NSManagedObject)
                }
                do {
                    try manageContent.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                //REMOVE Dailymodel TABLE ROW
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
                let objects1 = try! manageContent1.fetch(fetchData1)
                for obj1 in objects1 {
                    manageContent1.delete(obj1 as! NSManagedObject)
                }
                do {
                    try manageContent1.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                //REMOVE Dailyproduct TABLE ROW
                guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent2 = appDelegate2.persistentContainer.viewContext
                let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
                let objects2 = try! manageContent2.fetch(fetchData2)
                for obj2 in objects2 {
                    manageContent2.delete(obj2 as! NSManagedObject)
                }
                do {
                    try manageContent2.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                   if controller.isKind(of: subscriptionmodel.self) {
                      let tabVC = controller as! subscriptionmodel
                      self.navigationController?.popToViewController(tabVC, animated: true)
                   }
                }
            }
            else if strpageidentifier == "200"
            {
                //WEEKLY
                
                //REMOVE Subscriptionmodel TABLE ROW
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent = appDelegate.persistentContainer.viewContext
                let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
                let objects = try! manageContent.fetch(fetchData)
                for obj in objects {
                    manageContent.delete(obj as! NSManagedObject)
                }
                do {
                    try manageContent.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                //REMOVE Weeklymodel TABLE ROW
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
                let objects1 = try! manageContent1.fetch(fetchData1)
                for obj1 in objects1 {
                    manageContent1.delete(obj1 as! NSManagedObject)
                }
                do {
                    try manageContent1.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                //REMOVE Weeklyproduct TABLE ROW
                guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent2 = appDelegate2.persistentContainer.viewContext
                let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
                let objects2 = try! manageContent2.fetch(fetchData2)
                for obj2 in objects2 {
                    manageContent2.delete(obj2 as! NSManagedObject)
                }
                do {
                    try manageContent2.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                   if controller.isKind(of: subscriptionmodelweekly.self) {
                      let tabVC = controller as! subscriptionmodelweekly
                      self.navigationController?.popToViewController(tabVC, animated: true)
                   }
                }
            }
            else if strpageidentifier == "300"
            {
                //MONTHLY
                
                //REMOVE Subscriptionmodel TABLE ROW
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent = appDelegate.persistentContainer.viewContext
                let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
                let objects = try! manageContent.fetch(fetchData)
                for obj in objects {
                    manageContent.delete(obj as! NSManagedObject)
                }
                do {
                    try manageContent.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                //REMOVE Monthlymodel TABLE ROW
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
                let objects1 = try! manageContent1.fetch(fetchData1)
                for obj1 in objects1 {
                    manageContent1.delete(obj1 as! NSManagedObject)
                }
                do {
                    try manageContent1.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                //REMOVE Monthlyproduct TABLE ROW
                guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent2 = appDelegate2.persistentContainer.viewContext
                let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
                let objects2 = try! manageContent2.fetch(fetchData2)
                for obj2 in objects2 {
                    manageContent2.delete(obj2 as! NSManagedObject)
                }
                do {
                    try manageContent2.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                   if controller.isKind(of: subscriptionmodelmonthly.self) {
                      let tabVC = controller as! subscriptionmodelmonthly
                      self.navigationController?.popToViewController(tabVC, animated: true)
                   }
                }
            }
            
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
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
            return self.arrMProductItemsEdit.count
        }
        
        return self.arrMordereview.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tabveditpopupitems{
            return 155
        }
        return 115
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        return 120
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if tableView == tabvordereview
        {
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
            headerView.backgroundColor = UIColor.clear
            
            /*let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width - 140, height: 64))
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
             headerView.addSubview(btnUpdateAddress)*/
            
            
            //CHOOSE DELIEVRY SLOTS DATE TIME DESIGN
            let viewslot = UIView(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width, height: 44))
            viewslot.backgroundColor = UIColor(named: "greenlighter")!
            viewslot.layer.cornerRadius = 6.0
            viewslot.layer.borderWidth = 1.0
            viewslot.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            viewslot.layer.masksToBounds = true
            headerView.addSubview(viewslot)
            
            let title2 = UILabel(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width - 44, height: 44))
            title2.textAlignment = .center
            title2.textColor = UIColor.black
            title2.backgroundColor = .clear
            title2.numberOfLines = 10
            title2.font = UIFont (name: "NunitoSans-Bold", size: 13)
            title2.text = myAppDelegate.changeLanguage(key: "msg_language83")
            headerView.addSubview(title2)
            
            let imgvarrow = UIImageView(frame: CGRect(x: viewslot.frame.self.width - 44, y: 6, width:32, height: 32))
            imgvarrow.image = UIImage(named: "circlearrow")
            headerView.addSubview(imgvarrow)
            
            let btnChooseDelievryslotsdatetime = UIButton(frame: CGRect(x: 0 , y: 0 , width: viewslot.frame.size.width, height: 44))
            btnChooseDelievryslotsdatetime.backgroundColor = UIColor.clear
            btnChooseDelievryslotsdatetime.addTarget(self, action: #selector(pressChooseDelievryslotsdatetime), for: .touchUpInside)
            headerView.addSubview(btnChooseDelievryslotsdatetime)
            btnChooseDelievryslotsdatetime.bringSubviewToFront(headerView)
            
            return headerView
        }
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if tableView == tabvordereview
        {
            let footerView = UIView()
            footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 120)
            footerView.backgroundColor = UIColor(named: "greenlighter")!
            
            //SUBTOTAL
            if strpageidentifier == "100"
            {
                //DAILY
                self.fetchTotalSubtotalAmount(strtype: "100")
            }
            else if strpageidentifier == "200"
            {
                //WEEKLY
                self.fetchTotalSubtotalAmount(strtype: "200")
            }
            else if strpageidentifier == "300"
            {
                //MONTHLY
                self.fetchTotalSubtotalAmount(strtype: "300")
            }
            
            
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:footerView.frame.self.width / 2, height: 30))
            title1.textAlignment = .left
            title1.textColor = UIColor.black
            title1.backgroundColor = .clear
            title1.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title1.text = String(format: "  %@", myAppDelegate.changeLanguage(key: "msg_language84"))
            footerView.addSubview(title1)
            
            let title1value = UILabel(frame: CGRect(x: title1.frame.maxX, y: 0, width:footerView.frame.self.width / 2, height: 30))
            title1value.textAlignment = .right
            title1value.textColor = UIColor.black
            title1value.backgroundColor = .clear
            title1value.font = UIFont (name: "NunitoSans-Regular", size: 16)
            footerView.addSubview(title1value)
            
            //SHIPPING
            let title2 = UILabel(frame: CGRect(x: 0, y: title1.frame.maxY, width:footerView.frame.self.width / 2, height: 50))
            title2.textAlignment = .left
            title2.textColor = UIColor.black
            title2.backgroundColor = .clear
            title2.numberOfLines = 3
            title2.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title2.text = String(format: "  %@", myAppDelegate.changeLanguage(key: "msg_language85"))
            footerView.addSubview(title2)
            
            let title2value = UILabel(frame: CGRect(x: title2.frame.maxX, y: title1.frame.maxY, width:footerView.frame.self.width / 2, height: 50))
            title2value.textAlignment = .right
            title2value.textColor = UIColor.black
            title2value.backgroundColor = .clear
            title2value.font = UIFont (name: "NunitoSans-Regular", size: 16)
            footerView.addSubview(title2value)
            
            //GRANDTOTAL
            let title3 = UILabel(frame: CGRect(x: 0, y: title2.frame.maxY, width:footerView.frame.self.width / 2, height: 30))
            title3.textAlignment = .left
            title3.textColor = UIColor.black
            title3.backgroundColor = .clear
            title3.numberOfLines = 3
            title3.font = UIFont (name: "NunitoSans-Bold", size: 16)
            title3.text = String(format: "  %@", myAppDelegate.changeLanguage(key: "msg_language86"))
            footerView.addSubview(title3)
            
            let title3value = UILabel(frame: CGRect(x: title3.frame.maxX, y: title2.frame.maxY, width:footerView.frame.self.width / 2, height: 30))
            title3value.textAlignment = .right
            title3value.textColor = UIColor.black
            title3value.backgroundColor = .clear
            title3value.font = UIFont (name: "NunitoSans-Bold", size: 16)
            footerView.addSubview(title3value)
            
            //TOTALTAX
            //let title4 = UILabel(frame: CGRect(x: 0, y: title3.frame.maxY, width:footerView.frame.self.width, height: 50))
            //title4.textAlignment = .left
            //title4.textColor = UIColor.black
            //title4.backgroundColor = .clear
            //title4.numberOfLines = 3
            //title4.font = UIFont (name: "NunitoSans-Regular", size: 16)
            //title4.text = String(format: "  %@", myAppDelegate.changeLanguage(key: "msg_language385"))
            //footerView.addSubview(title4)
            
            /*let title4value = UILabel(frame: CGRect(x: 0, y: title3.frame.maxY, width:footerView.frame.self.width, height: 50))
            title4value.textAlignment = .left
            title4value.textColor = UIColor(named: "themecolor")!
            title4value.backgroundColor = .clear
            title4value.font = UIFont (name: "NunitoSans-SemiBold", size: 14)
            footerView.addSubview(title4value)
            
            title4value.isHidden = true*/
            
            
            
            if strSelectedpaymentoption == "FULL"
            {
                //No Yellow Top 3 ROWS
                
                title1value.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strSubtotalAmount)
                
                var flttotalcharges = 0.00
                for x in 0 ..< self.arrMshippingcalculationOutput.count
                {
                    let dict = self.arrMshippingcalculationOutput.object(at: x)as? NSDictionary
                    print("dict", dict)
                    let strcharges = String(format: "%@", dict?.value(forKey: "delivery_charge")as! CVarArg)
                    
                    flttotalcharges = flttotalcharges + Double(strcharges)!
                }
                print("flttotalcharges",flttotalcharges)
                strShippingchargesAmount = String(format: "%0.2f", flttotalcharges)
                title2value.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), flttotalcharges)
                
                //title4value.text = String(format: "( %@ %@ %@)", myAppDelegate.changeLanguage(key: "msg_language385"),myAppDelegate.changeLanguage(key: "msg_language481"),self.strTotalTaxAmount)
                
                var fltgrandtotal = 0.00
                fltgrandtotal = flttotalcharges + Double(strSubtotalAmount)!
                print("fltgrandtotal",fltgrandtotal)
                title3value.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltgrandtotal)
            }
            else
            {
                //Full Yellow color background Top 3 ROWS
                
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
            
                strSubtotalAmount = String(format: "%0.2f", flttotal2)
                title1value.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language481"), strSubtotalAmount)
                
                strShippingchargesAmount = String(format: "%0.2f", flttotal1)
                title2value.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), flttotal1)
                
                //title4value.text = String(format: "( %@ %@ %@)", myAppDelegate.changeLanguage(key: "msg_language385"),myAppDelegate.changeLanguage(key: "msg_language481"),self.strTotalTaxAmount)
                
                var fltgrandtotal = 0.00
                fltgrandtotal = Double(flttotal1) + Double(strSubtotalAmount)!
                print("fltgrandtotal",fltgrandtotal)
                title3value.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), fltgrandtotal)
            }
            
            return footerView
        }
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
            

            let dictm = self.arrMProductItemsEdit.object(at: indexPath.row)as! NSMutableDictionary
            let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
            let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
            let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
            let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
            let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
            let strproductsize = String(format: "%@", dictm.value(forKey: "productsize")as? String ?? "")
            let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
            let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
            let strselected = String(format: "%@", dictm.value(forKey: "selected")as? String ?? "")
            let strsubtotal = String(format: "%@", dictm.value(forKey: "subtotal")as? String ?? "")
            
            let strFinalurl = strproductimage.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
            if strFinalurl != ""{
                cell.imgvproduct.contentMode = .scaleAspectFit
                cell.imgvproduct.imageFromURL(urlString: strFinalurl)
            }else{
                cell.imgvproduct.contentMode = .scaleAspectFit
                cell.imgvproduct.imageFromURL(urlString: strFinalurl)
            }
            
            
            cell.lblname.text = strproductname
            cell.lblspec.text = strproductsize
            
            let fltamount  = (strproductprice as NSString).floatValue
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
            
            return cell
            
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
        
        cell.lblsubscriptiondate.text = String(format: "%@",strdate)
        
        
        var strdayvalue = ""
        if strday.containsIgnoreCase("Monday"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language489")
        }
        else if strday.containsIgnoreCase("Tuesday"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language490")
        }
        if strday.containsIgnoreCase("Wednesday"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language491")
        }
        if strday.containsIgnoreCase("Thursday"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language492")
        }
        if strday.containsIgnoreCase("Friday"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language493")
        }
        if strday.containsIgnoreCase("Saturday"){
            strdayvalue = myAppDelegate.changeLanguage(key: "msg_language494")
        }
        if strday.containsIgnoreCase("Sunday"){
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
        
        if strpageidentifier == "100"
        {
            //DAILY
            
            var flttotalproductcount = 0.00
            var flttotalprice = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From Dailyproduct TABLE As per ROW DATE -------------//
            let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
            let manageContent2 = appDelegate2.persistentContainer.viewContext
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
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
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            
            var flttotalproductcount = 0.00
            var flttotalprice = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From Weeklyproduct TABLE As per ROW DATE -------------//
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
        }
        else
        {
            //MONTHLY
            
            var flttotalproductcount = 0.00
            var flttotalprice = 0.00
            //----------------- ADD ALL SUBTOTAL PRICE From Monthlyproduct TABLE As per ROW DATE -------------//
            let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
            let manageContent2 = appDelegate2.persistentContainer.viewContext
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
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
        
    }
    
    //MARK: - press Detail View Method
    @objc func pressDetail(sender:UIButton)
    {
        let dictm = self.arrMordereview.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        
        //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
        self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
        
        self.createEditpopupDatewiseItems(selecteddateindex: sender.tag)
    }
    
    //MARK: - press Add More Products Method
    @objc func pressAddMoreProducts(sender:UIButton)
    {
        if strpageidentifier == "100"
        {
            //DAILY
            
            //self.navigationController?.popToViewController(of: dailyproductcatalogue.self, animated: true)

            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: dailyproductcatalogue.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
                else{
                    print("push to product page")
                    
                    let dictm = self.arrMordereview.object(at: sender.tag)as! NSMutableDictionary
                    let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
                    let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
                    
                    let ctrl = dailyproductcatalogue(nibName: "dailyproductcatalogue", bundle: nil)
                    ctrl.strpageidentifier = "100"
                    ctrl.strselecteddateindex = String(format: "%d", sender.tag)
                    ctrl.strselecteddateindexdate = strdate
                    ctrl.strselecteddateindexday = strday
                    self.navigationController?.pushViewController(ctrl, animated: true)
                    
                    break
                }
            }
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: weeklyproductcatalogue.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
                else{
                    print("push to product page")
                    
                    let dictm = self.arrMordereview.object(at: sender.tag)as! NSMutableDictionary
                    let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
                    let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
                    
                    let ctrl = weeklyproductcatalogue(nibName: "weeklyproductcatalogue", bundle: nil)
                    ctrl.strpageidentifier = "200"
                    ctrl.strselecteddateindex = String(format: "%d", sender.tag)
                    ctrl.strselecteddateindexdate = strdate
                    ctrl.strselecteddateindexday = strday
                    self.navigationController?.pushViewController(ctrl, animated: true)
                    
                    break
                }
            }
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: monthlyproductcatalogue.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
                else{
                    print("push to product page")
                    
                    let dictm = self.arrMordereview.object(at: sender.tag)as! NSMutableDictionary
                    let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
                    let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
                    
                    let ctrl = monthlyproductcatalogue(nibName: "monthlyproductcatalogue", bundle: nil)
                    ctrl.strpageidentifier = "300"
                    ctrl.strselecteddateindex = String(format: "%d", sender.tag)
                    ctrl.strselecteddateindexdate = strdate
                    ctrl.strselecteddateindexday = strday
                    self.navigationController?.pushViewController(ctrl, animated: true)
                    
                    break
                }
            }
        }
    }
    
    
    //MARK: - press Update Address Method
    /*@objc func pressUpdateAddress(sender:UIButton)
     {
     let ctrl = mapaddress(nibName: "mapaddress", bundle: nil)
     ctrl.strFrompageMap = "subscriptionorderreview"
     self.navigationController?.pushViewController(ctrl, animated: true)
     
     let ctrl = mapaddressgoogle(nibName: "mapaddressgoogle", bundle: nil)
     ctrl.strFrompageMap = "subscriptionorderreview"
     self.navigationController?.pushViewController(ctrl, animated: true)
     }*/
    
    //MARK: - press ADDONCE && ADDTOALL method
    @objc func pressaddonce(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
        let strproductimage = String(format: "%@", dictm.value(forKey: "productimage")as? String ?? "")
        let strproductname = String(format: "%@", dictm.value(forKey: "productname")as? String ?? "")
        let strproductprice = String(format: "%@", dictm.value(forKey: "productprice")as? String ?? "")
        let strproductsize = String(format: "%@", dictm.value(forKey: "productsize")as? String ?? "")
        let strqtyall = String(format: "%@", dictm.value(forKey: "qtyall")as? String ?? "")
        let strqtyonce = String(format: "%@", dictm.value(forKey: "qtyonce")as? String ?? "")
        let strselected = String(format: "%@", dictm.value(forKey: "selected")as? String ?? "")
        let strsubtotal = String(format: "%@", dictm.value(forKey: "subtotal")as? String ?? "")
        
        var tblname = ""
        if strpageidentifier == "100"
        {
            //DAILY
            tblname = "Dailyproduct"
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            tblname = "Weeklyproduct"
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            tblname = "Monthlyproduct"
        }
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: tblname)
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
                            
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + intqtyall!
                            
                            var fltsubtotalprice = Float(strproductprice)! * Float(inttotalqty)
                            print("fltsubtotalprice",fltsubtotalprice as Any)
                            data1.setValue(String(format: "%0.2f", fltsubtotalprice), forKey: "subtotal")
                        }
                        else
                        {
                            //qtyall not available add new  add once qty
                            
                            var intsubtotalprice = Float(strproductprice)! * 1
                            print("intsubtotalprice",intsubtotalprice)
                            
                            //------------------- INSERT INTO Dailyproduct TABLE ---------------- //
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                            let manageContent = appDelegate.persistentContainer.viewContext
                            let userEntity = NSEntityDescription.entity(forEntityName: tblname, in: manageContent)!
                            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                            users.setValue(strdate, forKeyPath: "date")
                            users.setValue(strday, forKeyPath: "day")
                            users.setValue(strproductid, forKeyPath: "productid")
                            users.setValue(strproductimage, forKeyPath: "productimage")
                            users.setValue(strproductname, forKeyPath: "productname")
                            users.setValue(strproductprice, forKeyPath: "productprice")
                            users.setValue(strproductsize, forKeyPath: "productsize")
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
                
                var intsubtotalprice = Float(strproductprice)! * 1
                print("intsubtotalprice",intsubtotalprice)
                
                //------------------- INSERT INTO product TABLE ---------------- //
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent = appDelegate.persistentContainer.viewContext
                let userEntity = NSEntityDescription.entity(forEntityName: tblname, in: manageContent)!
                let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                users.setValue(strdate, forKeyPath: "date")
                users.setValue(strday, forKeyPath: "day")
                users.setValue(strproductid, forKeyPath: "productid")
                users.setValue(strproductimage, forKeyPath: "productimage")
                users.setValue(strproductname, forKeyPath: "productname")
                users.setValue(strproductprice, forKeyPath: "productprice")
                users.setValue(strproductsize, forKeyPath: "productsize")
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
        
        
        //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
        self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
    }
    @objc func pressaddtoall(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
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
        
        let intsubtotalprice = Float(strproductprice)! * 1
        print("intsubtotalprice",intsubtotalprice)
        
        var tblname = ""
        if strpageidentifier == "100"
        {
            //DAILY
            tblname = "Dailyproduct"
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            tblname = "Weeklyproduct"
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            tblname = "Monthlyproduct"
        }
        
        for x in 0 ..< self.arrMordereview.count
        {
            let dict = self.arrMordereview.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICI DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: tblname)
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
                            
                            let fltsubtotalprice = Float(strproductprice)! * Float(inttotalqty)
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
                    
                    //------------------- INSERT INTO product TABLE ---------------- //
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent = appDelegate.persistentContainer.viewContext
                    let userEntity = NSEntityDescription.entity(forEntityName: tblname, in: manageContent)!
                    let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                    users.setValue(strdate, forKeyPath: "date")
                    users.setValue(strday, forKeyPath: "day")
                    users.setValue(strproductid, forKeyPath: "productid")
                    users.setValue(strproductimage, forKeyPath: "productimage")
                    users.setValue(strproductname, forKeyPath: "productname")
                    users.setValue(strproductprice, forKeyPath: "productprice")
                    users.setValue(strproductsize, forKeyPath: "productsize")
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
        
        //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
        self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
    }
    
    //MARK: - press ADDONCE PLUS && MINUS method
    @objc func pressplus(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
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
        
        var tblname = ""
        if strpageidentifier == "100"
        {
            //DAILY
            tblname = "Dailyproduct"
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            tblname = "Weeklyproduct"
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            tblname = "Monthlyproduct"
        }
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: tblname)
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
                        
                        var fltsubtotalprice = Float(strproductprice)! * Float(inttotalqty)
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
        
        //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
        self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
        
    }
    @objc func pressminus(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
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
        
        var tblname = ""
        if strpageidentifier == "100"
        {
            //DAILY
            tblname = "Dailyproduct"
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            tblname = "Weeklyproduct"
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            tblname = "Monthlyproduct"
        }
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: tblname)
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
                            
                            var inttotalqty = Float()
                            inttotalqty = intqtyonce! + intqtyall!
                            
                            let fltsubtotalprice = Float(strproductprice)! * Float(inttotalqty)
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
        
        //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
        self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
    }
    
    //MARK: - press ADDTOALL PLUS && MINUS method
    @objc func pressplusATA(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
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
        
        var tblname = ""
        if strpageidentifier == "100"
        {
            //DAILY
            tblname = "Dailyproduct"
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            tblname = "Weeklyproduct"
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            tblname = "Monthlyproduct"
        }
        
        for x in 0 ..< arrMordereview.count
        {
            let dict = self.arrMordereview.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: tblname)
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
                            
                            let fltsubtotalprice = Float(strproductprice)! * Float(inttotalqty)
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
        
        //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
        self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
    }
    @objc func pressminusATA(sender:UIButton)
    {
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")
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
        
        var tblname  = ""
        if strpageidentifier == "100"
        {
            //DAILY
            tblname = "Dailyproduct"
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            tblname = "Weeklyproduct"
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            tblname = "Monthlyproduct"
        }
        
        for x in 0 ..< arrMordereview.count
        {
            let dict = self.arrMordereview.object(at: x)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            
            //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: tblname)
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
                                
                                let fltsubtotalprice = Float(strproductprice)! * Float(inttotalqty)
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
        
        //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
        self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
        self.tabveditpopupitems.reloadData()
    }
    
    //MARK: - press REMOVE Product Item from Date Specfic Method
    @objc func pressEditPopupRemove(sender:UIButton)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dictm = self.arrMProductItemsEdit.object(at: sender.tag)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strproductid = String(format: "%@", dictm.value(forKey: "productid")as? String ?? "")
        
        if strpageidentifier == "100"
        {
            //DAILY
            
            //REMOVE Dailyproduct TABLE ROW
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
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
            
            //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
            self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
            self.tabveditpopupitems.reloadData()
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            
            //REMOVE Weeklyproduct TABLE ROW
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
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
            
            //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
            self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
            self.tabveditpopupitems.reloadData()
            
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
            
            //REMOVE Monthlyproduct TABLE ROW
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
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
            
            //fetch product items from DAILY / WEEKLY / MONTHLY Table Data
            self.fetchTABLEProductItems(strtype: strpageidentifier,strselecteddate: strdate)
            self.tabveditpopupitems.reloadData()
        }
        
        //REFRESH SUBTOTAL VALUE IN EDIT POPUP
        var flttotal = Float()
        for x in 0 ..< arrMProductItemsEdit.count
        {
            let dictemp = arrMProductItemsEdit.object(at: x)as? NSMutableDictionary
            let strsubtotal = String(format: "%@", dictemp?.value(forKey: "subtotal")as? String ?? "")
            
            let fltamount  = (strsubtotal as NSString).floatValue
            flttotal = flttotal + fltamount
        }
        
        print("flttotal",flttotal)
        self.lblsubtotaleditpopup.text = String(format: "%@ %0.2f", myAppDelegate.changeLanguage(key: "msg_language481"),flttotal)
    }
    
    
    //MARK: - press Choose Delievry slots date time Method
    @objc func pressChooseDelievryslotsdatetime(sender:UIButton)
    {
        self.createDateslotsPopup()
    }
    
    
    //MARK: - create POPUP EDIT ITEMS DATE WISE method
    func createEditpopupDatewiseItems(selecteddateindex:Int)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewpopupedititems.layer.cornerRadius = 6.0
        self.viewpopupedititems.layer.masksToBounds = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        if strpageidentifier == "100"
        {
            //DAILY
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
        }
        else if strpageidentifier == "300"{
            //MONTHLY
        }
        
        let dictm = self.arrMordereview.object(at: selecteddateindex)as! NSMutableDictionary
        let strdate = String(format: "%@", dictm.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dictm.value(forKey: "day")as? String ?? "")

        var flttotal = Float()
        for x in 0 ..< arrMProductItemsEdit.count
        {
            let dictemp = arrMProductItemsEdit.object(at: x)as? NSMutableDictionary
            let strsubtotal = String(format: "%@", dictemp?.value(forKey: "subtotal")as? String ?? "")
            
            let fltamount  = (strsubtotal as NSString).floatValue
            flttotal = flttotal + fltamount
        }
        
        print("flttotal",flttotal)
        
        lblitemsubtotal.text = myAppDelegate.changeLanguage(key: "msg_language68")
        lblitembottommessage.text = myAppDelegate.changeLanguage(key: "msg_language69")
        
        self.lbleditpopupDateDay.text = String(format: "%@ (%@)", strdate,strday)
        self.lblsubtotaleditpopup.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), flttotal)
        
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
        
        self.tabveditpopupitems.reloadData()
    }
    @IBAction func presscrosseditpopup(_ sender: Any) {
        self.viewpopupedititems.removeFromSuperview()
        viewPopupAddNewExistingBG2.removeFromSuperview()
        
        self.refreshmainlist()
    }

    
    
    //MARK: - create POPUP EDIT DELIVERY DATE & SLOTS TIME method
    func createDateslotsPopup()
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        
        lblheaderpopupdeliveryslot.text = appDel.changeLanguage(key: "msg_language338") 
        lblpopupdeliveryslot11.text = appDel.changeLanguage(key: "msg_language339")
        lblpopupdeliveryslot22.text = appDel.changeLanguage(key: "msg_language340")
        lblpopupdeliveryslot33.text = appDel.changeLanguage(key: "msg_language341")
        lblpopupdeliveryslot44.text = appDel.changeLanguage(key: "msg_language342")
        btnsavedateslotspopup.setTitle(String(format: "%@", appDel.changeLanguage(key: "msg_language191")), for: .normal)
        
        
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
        
        
        if strpageidentifier == "100"
        {
            //DAILY
            self.txtsubsriptionplanpopup2.text = appDel.changeLanguage(key: "msg_language37") //"Daily"
            
            self.txtsubsriptionplanpopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubsriptionplanpopup2.isUserInteractionEnabled = false
            
            self.txtsubscriptionstartdatepopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubscriptionenddatepopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubscriptionstartdatepopup2.isUserInteractionEnabled = false
            self.txtsubscriptionenddatepopup2.isUserInteractionEnabled = false
            
            let arrmtemp = NSMutableArray()
            //----- FETCH ALL DATE DAY LIST FROM DAILY MODEL TABLE ------------//
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
            fetchData.predicate = NSPredicate(format: "userid = %@", strcustomerid)
            do {
                let result = try manageContent.fetch(fetchData)
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        let dictemp = NSMutableDictionary()
                        dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                        dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                        arrmtemp.add(dictemp)
                    }
                }
            }catch {
                print("err")
            }
            print("arrmtemp",arrmtemp)
            
            let dict = arrmtemp.object(at: 0)as! NSMutableDictionary
            let strstartdate = String(format: "%@", dict.value(forKey: "date")as? String ?? "")
            
            let dict1 = arrmtemp.lastObject as! NSMutableDictionary
            let strenddate = String(format: "%@", dict1.value(forKey: "date")as? String ?? "")
            
            self.txtsubscriptionstartdatepopup2.text = strstartdate
            self.txtsubscriptionenddatepopup2.text = strenddate
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
            self.txtsubsriptionplanpopup2.text = appDel.changeLanguage(key: "msg_language38") //"Weekly"
            
            self.txtsubsriptionplanpopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubsriptionplanpopup2.isUserInteractionEnabled = false
            
            self.txtsubscriptionstartdatepopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubscriptionenddatepopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubscriptionstartdatepopup2.isUserInteractionEnabled = false
            self.txtsubscriptionenddatepopup2.isUserInteractionEnabled = false
            
            let arrmtemp = NSMutableArray()
            //----- FETCH ALL DATE DAY LIST FROM WEEKLY MODEL TABLE ------------//
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
            fetchData.predicate = NSPredicate(format: "userid = %@", strcustomerid)
            do {
                let result = try manageContent.fetch(fetchData)
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        let dictemp = NSMutableDictionary()
                        dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                        dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                        arrmtemp.add(dictemp)
                    }
                }
            }catch {
                print("err")
            }
            print("arrmtemp",arrmtemp)
            
            let dict = arrmtemp.object(at: 0)as! NSMutableDictionary
            let strstartdate = String(format: "%@", dict.value(forKey: "date")as? String ?? "")
            
            let dict1 = arrmtemp.lastObject as! NSMutableDictionary
            let strenddate = String(format: "%@", dict1.value(forKey: "date")as? String ?? "")
            
            self.txtsubscriptionstartdatepopup2.text = strstartdate
            self.txtsubscriptionenddatepopup2.text = strenddate
        }
        else if strpageidentifier == "300"{
            //MONTHLY
            self.txtsubsriptionplanpopup2.text = appDel.changeLanguage(key: "msg_language39") //"Monthly"
            
            self.txtsubsriptionplanpopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubsriptionplanpopup2.isUserInteractionEnabled = false
            
            self.txtsubscriptionstartdatepopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubscriptionenddatepopup2.backgroundColor = UIColor(named: "lightgreencolor")!
            self.txtsubscriptionstartdatepopup2.isUserInteractionEnabled = false
            self.txtsubscriptionenddatepopup2.isUserInteractionEnabled = false
            
            let arrmtemp = NSMutableArray()
            //----- FETCH ALL DATE DAY LIST FROM MONTHLY MODEL TABLE ------------//
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
            fetchData.predicate = NSPredicate(format: "userid = %@", strcustomerid)
            do {
                let result = try manageContent.fetch(fetchData)
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        let dictemp = NSMutableDictionary()
                        dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                        dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                        arrmtemp.add(dictemp)
                    }
                }
            }catch {
                print("err")
            }
            print("arrmtemp",arrmtemp)
            
            let dict = arrmtemp.object(at: 0)as! NSMutableDictionary
            let strstartdate = String(format: "%@", dict.value(forKey: "date")as? String ?? "")
            
            let dict1 = arrmtemp.lastObject as! NSMutableDictionary
            let strenddate = String(format: "%@", dict1.value(forKey: "date")as? String ?? "")
            
            self.txtsubscriptionstartdatepopup2.text = strstartdate
            self.txtsubscriptionenddatepopup2.text = strenddate
        }
        
        //Fetch Delivery Slots List
        self.getAvailbleTimeSlotsAPIMethod()
        
        
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
        self.viewdateslotsdeliverypopup.removeFromSuperview()
        viewPopupAddNewExistingBG3.removeFromSuperview()
    }
    @IBAction func pressmorninglot(_ sender: Any) {
        self.btnmorningslot.isSelected = true
        self.btnafternoonslot.isSelected = false
        self.btneveningslot.isSelected = false
        
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
    @IBAction func pressafternoonslot(_ sender: Any) {
        self.btnmorningslot.isSelected = false
        self.btnafternoonslot.isSelected = true
        self.btneveningslot.isSelected = false
        
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
    @IBAction func presseveningslot(_ sender: Any) {
        self.btnmorningslot.isSelected = false
        self.btnafternoonslot.isSelected = false
        self.btneveningslot.isSelected = true
        
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
    
    
    
    //MARK: - press FULL PAYMENT // FIRST 3 PAYMENT Method
    @IBAction func pressFullPayment(_ sender: Any) {
        strSelectedpaymentoption = "FULL"
        self.btnfullpayment.isSelected = true
        self.btnfirst3payment.isSelected = false
        
        
        var flttotalcharges = 0.00
        for x in 0 ..< self.arrMshippingcalculationOutput.count
        {
            let dict = self.arrMshippingcalculationOutput.object(at: x)as? NSDictionary
            print("dict", dict)
            let strcharges = String(format: "%@", dict?.value(forKey: "delivery_charge")as! CVarArg)
            
            flttotalcharges = flttotalcharges + Double(strcharges)!
        }
        print("flttotalcharges",flttotalcharges)
        self.strShippingchargesAmount = String(format: "%0.2f", flttotalcharges)
        
        self.tabvordereview.reloadData()
    }
    @IBAction func pressFirst3Payment(_ sender: Any)
    {
        strSelectedpaymentoption = "THREE"
        self.btnfullpayment.isSelected = false
        self.btnfirst3payment.isSelected = true
        
        print("self.arrMshippingcalculation",self.arrMshippingcalculation)
        print("arrMshippingcalculationOutput --->",self.arrMshippingcalculationOutput)
        
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
        
        self.strSubtotalAmount = String(format: "%0.2f", flttotal2)
        self.strShippingchargesAmount = String(format: "%0.2f", flttotal1)
        
        self.tabvordereview.reloadData()
    }
    
    
    
    
    //MARK: - Fetch Dailymodel TABLE data
    func fetchTABLEDailymodel()
    {
        if self.arrMordereview.count > 0{
            self.arrMordereview.removeAllObjects()
        }
        
        
        //----- FETCH ALL DATE DAY LIST FROM DAILY MODEL TABLE ------------//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
        fetchData.predicate = NSPredicate(format: "userid = %@", strcustomerid)
        do {
            let result = try manageContent.fetch(fetchData)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    self.arrMordereview.add(dictemp)
                }
            }
        }catch {
            print("err")
        }
        print("self.arrMordereview",self.arrMordereview)
        unhideviewall()
        self.tabvordereview.reloadData()
    }
    
    //MARK: - Fetch Weeklymodel TABLE data
    func fetchTABLEWeeklymodel()
    {
        if self.arrMordereview.count > 0{
            self.arrMordereview.removeAllObjects()
        }
        
        //----- FETCH ALL DATE DAY LIST FROM WEEKLY MODEL TABLE ------------//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
        fetchData.predicate = NSPredicate(format: "userid = %@ && selected = %@", strcustomerid,"1")
        do {
            let result = try manageContent.fetch(fetchData)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    self.arrMordereview.add(dictemp)
                }
            }
        }catch {
            print("err")
        }
        print("self.arrMordereview",self.arrMordereview)
        unhideviewall()
        self.tabvordereview.reloadData()
    }
    
    //MARK: - Fetch Monthlymodel TABLE data
    func fetchTABLEMonthlymodel()
    {
        if self.arrMordereview.count > 0{
            self.arrMordereview.removeAllObjects()
        }
        
        //----- FETCH ALL DATE DAY LIST FROM WEEKLY MODEL TABLE ------------//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
        fetchData.predicate = NSPredicate(format: "userid = %@ && selected = %@", strcustomerid,"1")
        do {
            let result = try manageContent.fetch(fetchData)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    self.arrMordereview.add(dictemp)
                }
            }
        }catch {
            print("err")
        }
        print("self.arrMordereview",self.arrMordereview)
        unhideviewall()
        self.tabvordereview.reloadData()
    }
    
    //MARK: - Fetch SUBTOTAL - ALL DATES Method
    func fetchTotalSubtotalAmount(strtype:String)
    {
        var strTablename = ""
        if strtype == "100"{
            strTablename = "Dailyproduct"
        }
        else if strtype == "200"{
            strTablename = "Weeklyproduct"
        }
        else if strtype == "300"{
            strTablename = "Monthlyproduct"
        }
  
        var flttotalprice = 0.00
        let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
        let manageContent2 = appDelegate2.persistentContainer.viewContext
        let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: strTablename)
        
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
        
        strSubtotalAmount = String(format: "%0.2f", flttotalprice)
    }
    
    //MARK: - Fetch Porudcut Items TABLE data
    func fetchTABLEProductItems(strtype:String,strselecteddate:String)
    {
        if self.arrMProductItemsEdit.count > 0{
            self.arrMProductItemsEdit.removeAllObjects()
        }
        
        var strTablename = ""
        if strtype == "100"{
            strTablename = "Dailyproduct"
        }
        else if strtype == "200"{
            strTablename = "Weeklyproduct"
        }
        else if strtype == "300"{
            strTablename = "Monthlyproduct"
        }
        
        
        //----- FETCH ALL DATE DAY LIST FROM PRODUCT ITEMS DAILY / WEEKLY / MONTHLY TABLE ------------//
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: strTablename)
        fetchData.predicate = NSPredicate(format: "date = %@",strselecteddate)
        do {
            let result = try manageContent.fetch(fetchData)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    dictemp.setValue(data.value(forKeyPath: "productid") ?? "", forKey: "productid")
                    dictemp.setValue(data.value(forKeyPath: "productimage") ?? "", forKey: "productimage")
                    dictemp.setValue(data.value(forKeyPath: "productname") ?? "", forKey: "productname")
                    dictemp.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "productprice")
                    dictemp.setValue(data.value(forKeyPath: "productsize") ?? "", forKey: "productsize")
                    dictemp.setValue(data.value(forKeyPath: "qtyall") ?? "", forKey: "qtyall")
                    dictemp.setValue(data.value(forKeyPath: "qtyonce") ?? "", forKey: "qtyonce")
                    dictemp.setValue(data.value(forKeyPath: "selected") ?? "", forKey: "selected")
                    dictemp.setValue(data.value(forKeyPath: "subtotal") ?? "", forKey: "subtotal")
                    
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
            var flttotal = Float()
            for x in 0 ..< arrMProductItemsEdit.count
            {
                let dictemp = arrMProductItemsEdit.object(at: x)as? NSMutableDictionary
                let strsubtotal = String(format: "%@", dictemp?.value(forKey: "subtotal")as? String ?? "")
                
                let fltamount  = (strsubtotal as NSString).floatValue
                flttotal = flttotal + fltamount
            }
            print("flttotal",flttotal)
            self.lblsubtotaleditpopup.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), flttotal)
        }
        
        
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
                            if self.arrMAvailbleTimeSlots.count > 0{
                                self.arrMAvailbleTimeSlots.removeAllObjects()
                            }
                            let arrmproducts = json.value(forKey: "timeslot") as? NSArray ?? []
                            self.arrMAvailbleTimeSlots = NSMutableArray(array: arrmproducts)
                            print("arrMAvailbleTimeSlots --->",self.arrMAvailbleTimeSlots)
                            
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
                                        str1 = strtime1.replacingOccurrences(of: "AM", with: myAppDelegate.changeLanguage(key: "msg_language502"))
                                    }
                                    else if strtime1.containsIgnoreCase("PM"){
                                        str1 = strtime1.replacingOccurrences(of: "PM", with: myAppDelegate.changeLanguage(key: "msg_language503"))
                                    }
                                    
                                    if strtime2.containsIgnoreCase("AM"){
                                        str2 = strtime2.replacingOccurrences(of: "AM", with: myAppDelegate.changeLanguage(key: "msg_language502"))
                                    }
                                    else if strtime2.containsIgnoreCase("PM"){
                                        str2 = strtime2.replacingOccurrences(of: "PM", with: myAppDelegate.changeLanguage(key: "msg_language503"))
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
    
    //MARK: - create shipping calculation dictionary
    func shippingchargescalculation()
    {
        var tablename1 = ""
        var tablename2 = ""
        if strpageidentifier == "100"{
            tablename1 = "Dailymodel"
            tablename2 = "Dailyproduct"
        }else if strpageidentifier == "200"{
            tablename1 = "Weeklymodel"
            tablename2 = "Weeklyproduct"
        }else if strpageidentifier == "300"{
            tablename1 = "Monthlymodel"
            tablename2 = "Monthlyproduct"
        }
        
        if self.arrMshippingcalculation.count > 0{
            self.arrMshippingcalculation.removeAllObjects()
        }
        
        
        //----- FETCH ALL DATE DAY LIST FROM MODEL TABLE ------------//
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: tablename1)
        if strpageidentifier == "100"{
            fetchData.predicate = NSPredicate(format: "userid = %@", strcustomerid)
        }else if strpageidentifier == "200"{
            fetchData.predicate = NSPredicate(format: "userid = %@ && selected = %@", strcustomerid,"1")
        }else if strpageidentifier == "300"{
            fetchData.predicate = NSPredicate(format: "userid = %@ && selected = %@", strcustomerid,"1")
        }
        
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
            let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: tablename2)
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
                            
                            self.strTotalTaxAmount = strtaxtotal
                            print("self.strTotalTaxAmount --->",self.strTotalTaxAmount)
                            
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
                                self.strShippingchargesAmount = String(format: "%0.2f", flttotalcharges)
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
                                self.strSubtotalAmount = String(format: "%0.2f", flttotal2)
                                self.strShippingchargesAmount = String(format: "%0.2f", flttotal1)
                                
                            }
                            
                            self.tabvordereview.reloadData()
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
}

extension UINavigationController {
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }

    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }
}
