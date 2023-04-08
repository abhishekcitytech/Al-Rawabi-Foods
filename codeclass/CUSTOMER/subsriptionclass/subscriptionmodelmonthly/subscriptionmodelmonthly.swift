//
//  subscriptionmodelmonthly.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 02/09/22.
//

import UIKit
import CoreData
import DatePickerDialog

class subscriptionmodelmonthly: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var lblsubscriptionselected: UILabel!
    
    @IBOutlet weak var btnautorenew: UIButton!
    @IBOutlet weak var lblmessage: UILabel!
    
    @IBOutlet weak var colmonthlycalendar: UICollectionView!
    var reuseIdentifier1 = "colcellsubmodelmonthly"
    var msg = ""
    
    var strplanname = String()
    var arrMDateBlock = NSMutableArray()
    
    @IBOutlet weak var lblautorenew: UILabel!
    @IBOutlet weak var btnReviewPlaceOrder: UIButton!
    @IBOutlet weak var btnContinuetoAddProducts: UIButton!
    
    
    //POPUP EDIT PENCIL ITEMS DATE SPECIFIC
    @IBOutlet var viewpopupedititems: UIView!
    @IBOutlet weak var lbleditpopupDateDay: UILabel!
    @IBOutlet weak var btncrosseditpopup: UIButton!
    @IBOutlet weak var tabveditpopupitems: UITableView!
    @IBOutlet weak var lblsubtotaleditpopup: UILabel!
    var reuseIdentifier2 = "celltabvprodustitemsedit"
    var viewPopupAddNewExistingBG2 = UIView()
    
    var monthlydatecounter = 0
    
    @IBOutlet weak var lblSelectedCounter: UILabel!
    var inSelectedDateCounter = 0
    
    @IBOutlet weak var txtstartdate: UITextField!
    
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        if inSelectedDateCounter > 0{
            self.lblSelectedCounter.isHidden = false
            self.lblSelectedCounter.text = String(format: "%d %@ %@", inSelectedDateCounter,myAppDelegate.changeLanguage(key: "msg_language380"),myAppDelegate.changeLanguage(key: "msg_language57"))
        }
        else{
            self.lblSelectedCounter.isHidden = true
        }
        
        self.fetchDataMONTHLYSubscriptionmodelTableAUTORENEW()
        
        self.fetchDataMonthlymodelTable()
        
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language74")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        lblsubscriptionselected.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language60"))
        
        lblmessage.text = myAppDelegate.changeLanguage(key: "msg_language42")  //msg_language42 //msg_language452
        lblautorenew.text = myAppDelegate.changeLanguage(key: "msg_language63")
        
        txtstartdate.placeholder = myAppDelegate.changeLanguage(key: "msg_language61")
        
        btnReviewPlaceOrder.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language67")), for: .normal)
        btnContinuetoAddProducts.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language382")), for: .normal)
        
        txtstartdate.setLeftPaddingPoints(10.0)
        txtstartdate.layer.cornerRadius = 4.0
        txtstartdate.layer.borderWidth = 1.0
        txtstartdate.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtstartdate.layer.masksToBounds = true
        
        var floatDevider = 0.0
        var floatcellheight = 0.0
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
            floatDevider = 5.0
            floatcellheight = 110.0
        }
        else
        {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            floatDevider = 3.0
            floatcellheight = 100.0
        }
        
        colmonthlycalendar.backgroundColor = .clear
        let layout = colmonthlycalendar.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/floatDevider - 15, height: floatcellheight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colmonthlycalendar.register(UINib(nibName: "colcellsubmodelmonthly", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colmonthlycalendar.showsVerticalScrollIndicator = false
        colmonthlycalendar.showsHorizontalScrollIndicator = false
        
        btnContinuetoAddProducts.layer.cornerRadius = 22.0
        btnContinuetoAddProducts.layer.masksToBounds = true
        
        btnReviewPlaceOrder.layer.borderWidth = 1.0
        btnReviewPlaceOrder.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnReviewPlaceOrder.layer.cornerRadius = 22.0
        btnReviewPlaceOrder.layer.masksToBounds = true
        
        self.lblSelectedCounter.layer.cornerRadius = 14.0
        self.lblSelectedCounter.layer.masksToBounds = true
        

        self.lblSelectedCounter.isHidden = true
        
    }
    
    //MARK: - press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
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
            datePickerTappedStart()
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
    func datePickerTappedStart()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var strdefaultdate = ""
        print("self.arrMDateBlock",self.arrMDateBlock)
        if self.arrMDateBlock.count > 0{
            
            let dict = self.arrMDateBlock.object(at: 0)as? NSMutableDictionary
            strdefaultdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            print("strfirstdate >>>>",strdefaultdate)
        }
       
        
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
        var date111 = dateFormatter.date(from: strdate)
        
        var dateComponents1 = DateComponents()
        dateComponents1.day = 365
        let next6days = Calendar.current.date(byAdding: dateComponents1, to: date111!)
        
        if strdefaultdate != ""{
            date111 = dateFormatter.date(from: strdefaultdate)
        }
        
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
                
                let nextdate = formatter.date(from: self.txtstartdate.text!)
                var intdiff = 27
                let nextdate1 = Calendar.current.date(byAdding: .day, value: +intdiff, to: nextdate!)!
                let formatter2 = DateFormatter()
                formatter2.dateFormat = "dd/MM/yyyy"
                let enddate = formatter2.string(from: nextdate1)
                print("enddate date %@",enddate)
                
                //RECRETAE DATE LIST WITH FRESH DATE RANGE && DB SHOULD BE CLEAR UP
                print("self.arrMDateBlock.count",self.arrMDateBlock.count)
                if self.arrMDateBlock.count > 0
                {
                    self.arrMDateBlock.removeAllObjects()
                    
                    let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
                    //Remove Monthlymodel table data
                    guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent2 = appDelegate2.persistentContainer.viewContext
                    let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
                    fetchData2.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
                    let objects2 = try! manageContent2.fetch(fetchData2)
                    for obj in objects2 {
                        manageContent2.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent2.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    //Remove Monthlyproduct table data
                    guard let appDelegate3 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent3 = appDelegate3.persistentContainer.viewContext
                    let fetchData3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
                    let objects3 = try! manageContent3.fetch(fetchData3)
                    for obj in objects3 {
                        manageContent3.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent3.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    self.inSelectedDateCounter = 0
                    self.lblSelectedCounter.isHidden = true
                    self.lblSelectedCounter.text = ""
                }
                
                self.listofdate(strdate: self.txtstartdate.text!, enddate: enddate)
                
            }
        }
    }
    
    //MARK: - press auto renew method
    @IBAction func pressautorenew(_ sender: Any)
    {
        if self.btnautorenew.isSelected == true
        {
            self.updateDataMONTHLYSubscriptionmodelTableAUTORENEW(strselectedautorenew: "0")
            self.btnautorenew.isSelected = false
        }
        else{
            self.updateDataMONTHLYSubscriptionmodelTableAUTORENEW(strselectedautorenew: "1")
            self.btnautorenew.isSelected = true
        }
    }
    
    //MARK: - checkinh Alert Days Minimum Selection
    @objc func checkingAlertMinimumSelectionDate()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language66"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - press Review & Place Order Method
    @IBAction func pressReviewPlaceOrder(_ sender: Any)
    {
        let ctrl = subscriptionorderreview(nibName: "subscriptionorderreview", bundle: nil)
        ctrl.strpageidentifier = "300"
        ctrl.strpageidentifierplanname = "Monthly"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Continue to Add Products Method
    @IBAction func pressContinuetoAddProducts(_ sender: Any)
    {
        fetchselecteddatecountfromMonthlyModelTable()
        
        if monthlydatecounter < 8
        {
            self.checkingAlertMinimumSelectionDate()
        }
        else{
            let ctrl = monthlyproductcatalogue(nibName: "monthlyproductcatalogue", bundle: nil)
            ctrl.strpageidentifier = "300"
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
   
    //MARK: - calculate time date Monthly
    func claculateDatetimeMonthly()
    {
        let intdiff = 27
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let timestring = df.string(from: date)
        print("timestring",timestring)
        
        let s1 = timestring
        let s2 = Constants.conn.CutOffTime //"15:00:00"
        if df.date(from: s1)! > df.date(from: s2)!
        {
            print("Over 15:00:00 - Its over 3 PM")
            
            
            let today = Date()
            let nextdate = Calendar.current.date(byAdding: .day, value: +2, to: today)!
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd/MM/yyyy"
            let strdate = formatter1.string(from: nextdate)
            print("strdate date %@",strdate)
            
            let nextdate1 = Calendar.current.date(byAdding: .day, value: +intdiff, to: nextdate)!
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "dd/MM/yyyy"
            let enddate = formatter1.string(from: nextdate1)
            print("enddate date %@",enddate)
            
            self.txtstartdate.text = strdate
            self.listofdate(strdate: strdate, enddate: enddate)
        }
        else
        {
            print("Within 15:00:00 - Its within 3 PM")
            
            let today = Date()
            let nextdate = Calendar.current.date(byAdding: .day, value: +1, to: today)!
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd/MM/yyyy"
            let strdate = formatter1.string(from: nextdate)
            print("strdate date %@",strdate)
            
            let nextdate1 = Calendar.current.date(byAdding: .day, value: +intdiff, to: nextdate)!
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "dd/MM/yyyy"
            let enddate = formatter1.string(from: nextdate1)
            print("enddate date %@",enddate)
           
            self.txtstartdate.text = strdate
            self.listofdate(strdate: strdate, enddate: enddate)
        }
    }
    
    //MARK: - List of date and days Calculation method
    func listofdate(strdate:String,enddate:String)
    {
        let mydates = NSMutableArray()
        var dateFrom =  Date() // Start date
        var dateTo = Date()   // End date
        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
        dateFrom = fmt.date(from: strdate)!
        dateTo = fmt.date(from: enddate)!
        while dateFrom <= dateTo {
            mydates.add(fmt.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        }
        print("Date array:%@",mydates)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        for x in 0 ..< mydates.count
        {
            let strdate = String(format: "%@", mydates.object(at: x)as? String ?? "")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: strdate)
            
            let dayformatter = DateFormatter()
            dayformatter.dateFormat  = "EEEE" // "EE" to get short style
            let dayname = dayformatter.string(from: date!)
            
            print("date:%@ day:%@",strdate,dayname)
            
            //------------------- INSERT INTO Monthlymodel TABLE ---------------- //
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Monthlymodel", in: manageContent)!
            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
            users.setValue(strdate, forKeyPath: "date")
            users.setValue(dayname, forKeyPath: "day")
            users.setValue("0", forKeyPath: "isrenew")
            users.setValue("0", forKeyPath: "selected")
            users.setValue("3", forKeyPath: "subscriptionid")
            users.setValue(strcustomerid, forKeyPath: "userid")
            do{
                try manageContent.save()
            }catch let error as NSError {
                print("could not save . \(error), \(error.userInfo)")
            }
        }
        
        //Ftch table data array
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
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
                    
                    self.arrMDateBlock.add(dictemp)
                    
                }
            }
        }catch {
            print("err")
        }
        
        print("self.arrMDateBlock",self.arrMDateBlock)
        self.colmonthlycalendar.reloadData()
        
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.arrMDateBlock.count == 0 {
            print("msg ---",msg)
            self.colmonthlycalendar.setEmptyMessage(msg)
        } else {
            self.colmonthlycalendar.restore()
        }
        return self.arrMDateBlock.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellsubmodelmonthly
        cell.contentView.backgroundColor = .clear
        cell.contentView.layer.borderWidth = 8.0
        cell.contentView.layer.cornerRadius = 0.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        let dict = self.arrMDateBlock.object(at: indexPath.row)as? NSMutableDictionary
        
        let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
        let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
        var strisrenew = String(format: "%@", dict?.value(forKey: "isrenew")as? String ?? "")
        var strsubscriptionid = String(format: "%@", dict?.value(forKey: "subscriptionid")as? String ?? "")
        
        
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
        
        cell.lblname.text = String(format: "%@\n%@", strdate,strdayvalue)
        
        cell.lbltotalprice.isHidden = true
        
        if strselected == "0"
        {
            cell.imgvcheckuncheck.image = UIImage(named: "uncheckbox")
        }
        else{
            cell.imgvcheckuncheck.image = UIImage(named: "checkbox")
        }
        
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
        
        if flttotalprice != 0.00{
            cell.lbltotalprice.font = UIFont (name: "NunitoSans-Bold", size: 14)
            cell.lbltotalprice.text = String(format: "%@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language481"), flttotalprice)
        }
        else{
            cell.lbltotalprice.font = UIFont (name: "NunitoSans-Bold", size: 14)
            cell.lbltotalprice.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language382"))
        }
        
        if flttotalprice == 0.00
        {
            //no products
            cell.lblname.backgroundColor = .clear
            cell.lblname.textColor = .black
            cell.lbltotalprice.textColor = UIColor(named: "orangecolor")!
            
            
            //Red Border for Empty BOX
            cell.viewcell.backgroundColor = UIColor.white
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 3.0
            cell.viewcell.layer.borderColor = UIColor(named: "darkredcolor")!.cgColor
            cell.viewcell.layer.borderWidth = 1.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 3.0
        }
        else if flttotalprice >= Constants.conn.CutOffSubscriptionOrderTotal //15.00
        {
            //GREEN
            cell.lblname.backgroundColor = .clear
            cell.lblname.textColor = .black
            cell.lbltotalprice.textColor = UIColor(named: "orangecolor")!
    
            cell.viewcell.backgroundColor = UIColor.white
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 3.0
            cell.viewcell.layer.borderColor = UIColor(named: "darkgreencolor")!.cgColor
            cell.viewcell.layer.borderWidth = 2.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 3.0
        }
        else if flttotalprice < Constants.conn.CutOffSubscriptionOrderTotal //15.00
        {
            //RED
            cell.lblname.backgroundColor = .clear
            cell.lblname.textColor = .black
            cell.lbltotalprice.textColor = .black
            
            
            cell.viewcell.backgroundColor = UIColor(named: "plate4")!
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 3.0
            cell.viewcell.layer.borderColor = UIColor(named: "darkmostredcolor")!.cgColor
            cell.viewcell.layer.borderWidth = 2.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 3.0
        }

        cell.viewcell.layer.cornerRadius = 8.0
        cell.viewcell.layer.masksToBounds = true
        
        // Set up cell
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dict = self.arrMDateBlock.object(at: indexPath.row)as? NSMutableDictionary
        let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
        let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
        var strisrenew = String(format: "%@", dict?.value(forKey: "isrenew")as? String ?? "")
        var strsubscriptionid = String(format: "%@", dict?.value(forKey: "subscriptionid")as? String ?? "")
        
        if strselected == "0"
        {
            //Update date specific selection
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
            fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && date = %@", strcustomerid,"3",strdate)
            do {
                let result = try manageContent.fetch(fetchData)
                print("result",result)
                
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        // update
                        do {
                            data.setValue("1", forKey: "selected")
                            
                            try manageContent.save()
                            print("update successfull")
                            
                        } catch let error as NSError {
                            print("Could not Update. \(error), \(error.userInfo)")
                        }
                        //end update
                    }
                }
            }catch {
                print("err")
            }
            
            inSelectedDateCounter = inSelectedDateCounter + 1
            //fetch refreshed date list
            self.fetchDataMonthlymodelTableREFRESH()
        }
        else
        {
            //Update date specific selection
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
            fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && date = %@", strcustomerid,"3",strdate)
            do {
                let result = try manageContent.fetch(fetchData)
                print("result",result)
                
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        // update
                        do {
                            data.setValue("0", forKey: "selected")
                            
                            try manageContent.save()
                            print("update successfull")
                            
                        } catch let error as NSError {
                            print("Could not Update. \(error), \(error.userInfo)")
                        }
                        //end update
                    }
                }
            }catch {
                print("err")
            }
            
            //Remove date specific all products
            guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent1 = appDelegate1.persistentContainer.viewContext
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
            fetchData1.predicate = NSPredicate(format: "date == %@", strdate)
            let objects = try! manageContent1.fetch(fetchData1)
            for obj in objects {
                manageContent1.delete(obj as! NSManagedObject)
            }
            do {
                try manageContent1.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
            }
            
            inSelectedDateCounter = inSelectedDateCounter - 1
            
            //fetch refreshed date list
            self.fetchDataMonthlymodelTableREFRESH()
        }
        
        //CHECKING NO OF DAYS SELECTED COUNTER
        print("inSelectedDateCounter",inSelectedDateCounter)
        if inSelectedDateCounter > 0{
            self.lblSelectedCounter.isHidden = false
            self.lblSelectedCounter.text = String(format: "%d %@ %@", inSelectedDateCounter,myAppDelegate.changeLanguage(key: "msg_language380"),myAppDelegate.changeLanguage(key: "msg_language57"))
        }
        else{
            self.lblSelectedCounter.isHidden = true
        }
        
        self.colmonthlycalendar.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }

    //MARK: - press Edit Pencil for  Product from Each Daily Date Method
    @objc func pressEdit(sender:UIButton)
    {
        self.createEditpopupDatewiseItems(selecteddateindex:sender.tag)
    }
    
    //MARK: - create POPUP EDIT ITEMS DATE WISE method
    func createEditpopupDatewiseItems(selecteddateindex:Int)
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        //self.lbleditpopupDateDay.text = String(format: "%@ (%@)", strdate,strday)
        //self.lblsubtotaleditpopup.text = String(format: "%@ %@",appDel.changeLanguage(key: "msg_language481"), strtotalprice)
        
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
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height:1)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as! celltabvprodustitemsedit
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        //cell.lblname.text = strname
        //cell.lblspec.text = "1.5 ltr"
        //cell.lblunitprice.text = String(format: "%@ %@",appDel.changeLanguage(key: "msg_language481”), strprice)
        
        //cell.txtplusminus.text = strqty
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {

    }
    
    //MARK: - Fetch Monthlymodel data Monthly exist or not
    func fetchDataMonthlymodelTable()
    {
        if self.arrMDateBlock.count > 0 {
            self.arrMDateBlock.removeAllObjects()
        }
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
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
                    
                    self.arrMDateBlock.add(dictemp)
                    
                }
            }
            else{
                self.claculateDatetimeMonthly()
            }
        }catch {
            print("err")
        }
        
        self.colmonthlycalendar.reloadData()
    }
    
    //MARK: - fetch refresh Monthly model table on Selection Click method
    func fetchDataMonthlymodelTableREFRESH()
    {
        if self.arrMDateBlock.count > 0 {
            self.arrMDateBlock.removeAllObjects()
        }
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
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
                    
                    self.arrMDateBlock.add(dictemp)
                    
                }
            }
            else{
            }
        }catch {
            print("err")
        }
        print("self.arrMDateBlock",self.arrMDateBlock)
        self.colmonthlycalendar.reloadData()
    }
    
    
    //MARK: - Fetch SubscriptionmodelTable data Monthly AUTONENEW exist or not
    func fetchDataMONTHLYSubscriptionmodelTableAUTORENEW()
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,"Monthly")
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
                    }
                    else{
                        self.btnautorenew.isSelected = true
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
    //MARK: - Update SubscriptionmodelTable data Monthly AUTONENEW exist or not
    func updateDataMONTHLYSubscriptionmodelTableAUTORENEW(strselectedautorenew:String)
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,"Monthly")
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
    
    //MARK: - fetch monthly date counter method
    func fetchselecteddatecountfromMonthlyModelTable()
    {
        monthlydatecounter = 0
        for x in 0 ..< self.arrMDateBlock.count
        {
            let dict = self.arrMDateBlock.object(at: x)as? NSMutableDictionary
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            if strselected == "1"{
                monthlydatecounter = monthlydatecounter + 1
            }
        }
        print("monthlydatecounter",monthlydatecounter)
    }
}
