//
//  subscriptionmodelweekly.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 02/09/22.
//

import UIKit
import CoreData

class subscriptionmodelweekly: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var lblsubscriptionselected: UILabel!
    
    @IBOutlet weak var btnautorenew: UIButton!
    @IBOutlet weak var lblmessage: UILabel!
    
    @IBOutlet weak var colweeklycalendar: UICollectionView!
    var reuseIdentifier1 = "colcellsubmodelweekly"
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
    
    var weeklydatecounter = 0
    
    @IBOutlet weak var lblSelectedCounter: UILabel!
    var inSelectedDateCounter = 0
    
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
        
        self.fetchDataWEEKLYSubscriptionmodelTableAUTORENEW()
        
        self.fetchDataWeeklymodelTable()
        
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language74")
        
        self.lblSelectedCounter.isHidden = true
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        lblsubscriptionselected.text = String(format: "%@ - %@",myAppDelegate.changeLanguage(key: "msg_language74"), strplanname)
        
        lblmessage.text = myAppDelegate.changeLanguage(key: "msg_language65")
        lblautorenew.text = myAppDelegate.changeLanguage(key: "msg_language63")
        
        btnReviewPlaceOrder.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language67")), for: .normal)
        btnContinuetoAddProducts.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language382")), for: .normal)
        
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
            floatcellheight = 134.0
        }
        else
        {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            floatDevider = 3.0
            floatcellheight = 114.0
        }
        
        colweeklycalendar.backgroundColor = .clear
        let layout = colweeklycalendar.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/floatDevider - 15, height: floatcellheight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colweeklycalendar.register(UINib(nibName: "colcellsubmodelweekly", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colweeklycalendar.showsVerticalScrollIndicator = false
        colweeklycalendar.showsHorizontalScrollIndicator = false
        
        btnContinuetoAddProducts.layer.cornerRadius = 22.0
        btnContinuetoAddProducts.layer.masksToBounds = true
        
        btnReviewPlaceOrder.layer.borderWidth = 1.0
        btnReviewPlaceOrder.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnReviewPlaceOrder.layer.cornerRadius = 22.0
        btnReviewPlaceOrder.layer.masksToBounds = true
        
        self.lblSelectedCounter.layer.cornerRadius = 14.0
        self.lblSelectedCounter.layer.masksToBounds = true
    }
    
    //MARK: - press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press auto renew method
    @IBAction func pressautorenew(_ sender: Any)
    {
        if self.btnautorenew.isSelected == true
        {
            self.updateDataWEEKLYSubscriptionmodelTableAUTORENEW(strselectedautorenew: "0")
            self.btnautorenew.isSelected = false
        }
        else{
            self.updateDataWEEKLYSubscriptionmodelTableAUTORENEW(strselectedautorenew: "1")
            self.btnautorenew.isSelected = true
        }
    }
    
    //MARK: - checkinh Alert Days Minimum Selection
    @objc func checkingAlertMinimumSelectionDate()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language65"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - press Review & Place Order Method
    @IBAction func pressReviewPlaceOrder(_ sender: Any)
    {
        let ctrl = subscriptionorderreview(nibName: "subscriptionorderreview", bundle: nil)
        ctrl.strpageidentifier = "200"
        ctrl.strpageidentifierplanname = "Weekly"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Continue to Add Products Method
    @IBAction func pressContinuetoAddProducts(_ sender: Any)
    {
        self.fetchselecteddatecountfromWeeklyModelTable()
        
        if weeklydatecounter < 3
        {
            self.checkingAlertMinimumSelectionDate()
        }
        else{
            let ctrl = weeklyproductcatalogue(nibName: "weeklyproductcatalogue", bundle: nil)
            ctrl.strpageidentifier = "200"
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    
    //MARK: - calculate time date Weekly
    func claculateDatetimeWeekly()
    {
        var intdiff = 6
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let timestring = df.string(from: date)
        print("timestring",timestring)
        
        let s1 = timestring
        let s2 = "15:00:00"
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
            
            //------------------- INSERT INTO Dailymodel TABLE ---------------- //
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Weeklymodel", in: manageContent)!
            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
            users.setValue(strdate, forKeyPath: "date")
            users.setValue(dayname, forKeyPath: "day")
            users.setValue("0", forKeyPath: "isrenew")
            users.setValue("0", forKeyPath: "selected")
            users.setValue("2", forKeyPath: "subscriptionid")
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
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"2")
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
        self.colweeklycalendar.reloadData()
    }

    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.arrMDateBlock.count == 0 {
            print("msg ---",msg)
            self.colweeklycalendar.setEmptyMessage(msg)
        } else {
            self.colweeklycalendar.restore()
        }
        return self.arrMDateBlock.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellsubmodelweekly
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
        
        cell.lblname.text = String(format: "%@\n%@", strdate,strday)
        
       
        if strselected == "0"
        {
            cell.imgvcheckuncheck.image = UIImage(named: "uncheckbox")
        }
        else{
            cell.imgvcheckuncheck.image = UIImage(named: "checkbox")
        }
        
        
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
            cell.lbltotalprice.text = String(format: "AED %0.2f", flttotalprice)
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
            
            cell.btnedit.isHidden = true
            
            //Red Border for Empty BOX
            cell.viewcell.backgroundColor = UIColor.white
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 6.0
            cell.viewcell.layer.borderColor = UIColor(named: "darkredcolor")!.cgColor
            cell.viewcell.layer.borderWidth = 1.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0
        }
        else if flttotalprice >= 15.00
        {
            //GREEN
            
            cell.lblname.backgroundColor = .clear
            cell.lblname.textColor = .black
            cell.lbltotalprice.textColor = UIColor(named: "orangecolor")!
            
            cell.btnedit.isHidden = true

            
            cell.viewcell.backgroundColor = UIColor.white
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 6.0
            cell.viewcell.layer.borderColor = UIColor(named: "darkgreencolor")!.cgColor
            cell.viewcell.layer.borderWidth = 2.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0
        }
        else if flttotalprice < 15.00
        {
            //RED
            cell.lblname.backgroundColor = .clear
            cell.lblname.textColor = .black
            cell.lbltotalprice.textColor = .black
            
            cell.btnedit.isHidden = true
            
            cell.viewcell.backgroundColor = UIColor(named: "plate4")!
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 6.0
            cell.viewcell.layer.borderColor = UIColor(named: "darkmostredcolor")!.cgColor
            cell.viewcell.layer.borderWidth = 2.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0
        }
        
        cell.btnedit.tag = indexPath.section
        cell.btnedit.addTarget(self, action: #selector(pressEdit), for: .touchUpInside)
        
        cell.viewcell.layer.cornerRadius = 14.0
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
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
            fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && date = %@", strcustomerid,"2",strdate)
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
            self.fetchDataWeeklymodelTableREFRESH()
        }
        else
        {
            
            //Update date specific selection
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
            fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && date = %@", strcustomerid,"2",strdate)
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
            let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
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
            self.fetchDataWeeklymodelTableREFRESH()
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
        
        self.colweeklycalendar.reloadData()
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
        //self.lblsubtotaleditpopup.text = String(format: "AED %@", strtotalprice)
        
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
        //cell.lblunitprice.text = String(format: "AED %@", strprice)
        
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
    
    
    
    //MARK: - Fetch Weeklymodel data Weekly exist or not
    func fetchDataWeeklymodelTable()
    {
        if self.arrMDateBlock.count > 0 {
            self.arrMDateBlock.removeAllObjects()
        }
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"2")
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
                self.claculateDatetimeWeekly()
            }
        }catch {
            print("err")
        }
        
        self.colweeklycalendar.reloadData()
    }
    
    //MARK: - fetch refresh weekly model table on Selection Click method
    func fetchDataWeeklymodelTableREFRESH()
    {
        if self.arrMDateBlock.count > 0 {
            self.arrMDateBlock.removeAllObjects()
        }
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"2")
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
        self.colweeklycalendar.reloadData()
    }
    
    
    //MARK: - Fetch SubscriptionmodelTable data Weekly AUTONENEW exist or not
    func fetchDataWEEKLYSubscriptionmodelTableAUTORENEW()
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,"Weekly")
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
    //MARK: - Update SubscriptionmodelTable data Weekly AUTONENEW exist or not
    func updateDataWEEKLYSubscriptionmodelTableAUTORENEW(strselectedautorenew:String)
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,"Weekly")
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
    
    //MARK: - fetch weekly date counter method
    func fetchselecteddatecountfromWeeklyModelTable()
    {
        weeklydatecounter = 0
        for x in 0 ..< self.arrMDateBlock.count
        {
            let dict = self.arrMDateBlock.object(at: x)as? NSMutableDictionary
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            if strselected == "1"{
                weeklydatecounter = weeklydatecounter + 1
            }
        }
        print("weeklydatecounter",weeklydatecounter)
    }
}
