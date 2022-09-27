//
//  subscriptionmodel.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 23/06/22.
//

import UIKit
import CoreData
import DatePickerDialog

class subscriptionmodel: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblsubscriptionselected: UILabel!
    
    @IBOutlet weak var btnautorenew: UIButton!
    
    @IBOutlet weak var txtstartdate: UITextField!
    @IBOutlet weak var txtenddate: UITextField!
    
    @IBOutlet weak var btnRevieworder: UIButton!
    @IBOutlet weak var lblmessage: UILabel!
    
    
    @IBOutlet weak var tabvdates: UITableView!
    var reuseIdentifier1 = "tabvcellsubmodel"
    var msg = ""
    
    var strplanname = String()
    
    var arrMDateBlock = NSMutableArray()
    
    //POPUP EDIT PENCIL ITEMS DATE SPECIFIC
    @IBOutlet var viewpopupedititems: UIView!
    @IBOutlet weak var lbleditpopupDateDay: UILabel!
    @IBOutlet weak var btncrosseditpopup: UIButton!
    @IBOutlet weak var tabveditpopupitems: UITableView!
    @IBOutlet weak var lblsubtotaleditpopup: UILabel!
    var reuseIdentifier2 = "celltabvprodustitemsedit"
    var viewPopupAddNewExistingBG2 = UIView()
    
    
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
        
        self.fetchDataDailymodelTable()
        
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Subscription"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        txtstartdate.layer.cornerRadius = 4.0
        txtstartdate.layer.borderWidth = 1.0
        txtstartdate.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtstartdate.layer.masksToBounds = true
        
        txtenddate.layer.cornerRadius = 4.0
        txtenddate.layer.borderWidth = 1.0
        txtenddate.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtenddate.layer.masksToBounds = true
        
        btnRevieworder.layer.borderWidth = 1.0
        btnRevieworder.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnRevieworder.layer.cornerRadius = 22.0
        btnRevieworder.layer.masksToBounds = true
        
        
        txtstartdate.setLeftPaddingPoints(10)
        txtenddate.setLeftPaddingPoints(10)
        
        lblsubscriptionselected.text = String(format: "Subscription - %@", strplanname)
        
        tabvdates.register(UINib(nibName: "tabvcellsubmodel", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvdates.separatorStyle = .none
        tabvdates.backgroundView=nil
        tabvdates.backgroundColor=UIColor.clear
        tabvdates.separatorColor=UIColor.clear
        tabvdates.showsVerticalScrollIndicator = false
        msg = "no recods found!"
        
        //self.checkingAlertMinimumSelectionDate()
    }
    
    //MARK: - press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - checkinh Alert Days Minimum Selection
    @objc func checkingAlertMinimumSelectionDate()
    {
        let refreshAlert = UIAlertController(title: "", message: "You have to select 'Minimum 10 days orders OR more orders' for Daily subscription plan.", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - press auto renew method
    @IBAction func pressautorenew(_ sender: Any) {
    }
    
    //MARK: - calculate time date
    func claculateDatetime()
    {
        var intdiff = 9
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let timestring = df.string(from: date)
        print("timestring",timestring)
        
        //timestring = "09:27:30" //FIXME STATIC CUTOFF TIME CHECKINH
        
        /*if  timestring > "15:00:00"
         {
         print("Over 15:00:00 - Its over 3 PM")
         }else{
         print("Within 15:00:00 - Its within 3 PM")
         }*/
        
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
            
            self.txtstartdate.text = strdate
            self.txtenddate.text = enddate
            
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
            self.txtenddate.text = enddate
            
            self.listofdate(strdate: strdate, enddate: enddate)
        }
    }
    
    //MARK: - List of date and days Calculation method
    func listofdate(strdate:String,enddate:String)
    {
        //IF EXISTS ---- REMOVE DATE LIST FROM LOCAL DB DAILYMODEL TABLE -----//
        self.fetchRemoveRefreshDataDailymodelTable()
        
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
            let userEntity = NSEntityDescription.entity(forEntityName: "Dailymodel", in: manageContent)!
            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
            users.setValue(strdate, forKeyPath: "date")
            users.setValue(dayname, forKeyPath: "day")
            users.setValue("0", forKeyPath: "isrenew")
            users.setValue("0", forKeyPath: "selected")
            users.setValue("1", forKeyPath: "subscriptionid")
            users.setValue(strcustomerid, forKeyPath: "userid")
            do{
                try manageContent.save()
            }catch let error as NSError {
                print("could not save . \(error), \(error.userInfo)")
            }
        }
        
        
        //Ftch table data array
        if self.arrMDateBlock.count > 0 {
            self.arrMDateBlock.removeAllObjects()
        }
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
                    
                    self.arrMDateBlock.add(dictemp)
                    
                }
            }
        }catch {
            print("err")
        }
        self.tabvdates.reloadData()
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        if tableView == tabveditpopupitems{
            return 1
        }
        
        if self.arrMDateBlock.count == 0 {
            print("msg ---",msg)
            self.tabvdates.setEmptyMessage(msg)
        } else {
            self.tabvdates.restore()
        }
        return self.arrMDateBlock.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if tableView == tabveditpopupitems{
            
            let dict = appDel.arrMDATEWISEPRODUCTPLAN.object(at: tabveditpopupitems.tag)as? NSMutableDictionary
            let arrm = dict?.value(forKey: "items")as! NSMutableArray
            return arrm.count
        }
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tabveditpopupitems{
            return 1
        }
        return 2
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == tabveditpopupitems{
            return 1
        }
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == tabveditpopupitems{
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 2)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if tableView == tabveditpopupitems{
            let footerView = UIView()
            footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height:1)
            footerView.backgroundColor = UIColor.clear
            return footerView
        }
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 2)
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
            
            let dict = appDel.arrMDATEWISEPRODUCTPLAN.object(at: tabveditpopupitems.tag)as? NSMutableDictionary
            let arrm = dict?.value(forKey: "items")as! NSMutableArray
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! tabvcellsubmodel
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let dict = self.arrMDateBlock.object(at: indexPath.section)as? NSMutableDictionary
        
        let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
        let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
        var strisrenew = String(format: "%@", dict?.value(forKey: "isrenew")as? String ?? "")
        var strsubscriptionid = String(format: "%@", dict?.value(forKey: "subscriptionid")as? String ?? "")
        
        cell.lbldate.text = strdate
        cell.lblday.text = strday
        
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
            cell.lblprice.font = UIFont (name: "NunitoSans-Bold", size: 14)
            cell.lblprice.text = String(format: "AED %0.2f", flttotalprice)
        }
        else{
            cell.lblprice.font = UIFont (name: "NunitoSans-Bold", size: 14)
            cell.lblprice.text = String(format: "%@", "Choose Products")
        }
        
        if flttotalprice == 0.00
        {
            //no products
            cell.lbldate.textColor = .black
            cell.lblday.textColor = .darkGray
            cell.lblprice.textColor = UIColor(named: "orangecolor")!
            
            cell.btnaddplus.isHidden = false
            cell.btneditpencil.isHidden = true
            
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
            
            cell.lbldate.backgroundColor = UIColor(named: "darkgreencolor")!
            cell.lbldate.textColor = .white
            cell.lblday.textColor = .white
            cell.lblprice.textColor = .white
            
            cell.btnaddplus.isHidden = true
            cell.btneditpencil.isHidden = false

            
            cell.viewcell.backgroundColor = UIColor(named: "greencolor")!
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 6.0
            cell.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cell.viewcell.layer.borderWidth = 2.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0
        }
        else if flttotalprice < 15.00
        {
            //RED
            cell.lbldate.backgroundColor = UIColor(named: "darkmostredcolor")!
            cell.lbldate.textColor = .black
            cell.lblday.textColor = .darkGray
            cell.lblprice.textColor = .black
            
            cell.btnaddplus.isHidden = true
            cell.btneditpencil.isHidden = false
            
            cell.viewcell.backgroundColor = UIColor(named: "darkredcolor")!
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 6.0
            cell.viewcell.layer.borderColor = UIColor(named: "darkredcolor")!.cgColor
            cell.viewcell.layer.borderWidth = 2.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0
        }

        cell.btnaddplus.tag = indexPath.section
        cell.btneditpencil.tag = indexPath.section
        cell.btnaddplus.addTarget(self, action: #selector(pressaddplus), for: .touchUpInside)
        cell.btneditpencil.addTarget(self, action: #selector(presseditpencil), for: .touchUpInside)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tabveditpopupitems
        {
        }
        else
        {
            
            let dict = self.arrMDateBlock.object(at: indexPath.section)as? NSMutableDictionary
            let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
            let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
            let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
            var strisrenew = String(format: "%@", dict?.value(forKey: "isrenew")as? String ?? "")
            var strsubscriptionid = String(format: "%@", dict?.value(forKey: "subscriptionid")as? String ?? "")
            
            
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
            fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && date == %@", strcustomerid,"1",strdate)
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
            
            let ctrl = dailyproductcatalogue(nibName: "dailyproductcatalogue", bundle: nil)
            ctrl.strpageidentifier = "100"
            ctrl.strselecteddateindex = String(format: "%d", indexPath.section)
            ctrl.strselecteddateindexdate = strdate
            ctrl.strselecteddateindexday = strday
            self.navigationController?.pushViewController(ctrl, animated: true)
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        if tableView == tabveditpopupitems
        {
        }
        else
        {
        }
    }
    
    
    //MARK: - press ADD Product from Each Daily Date Method
    @objc func pressaddplus(sender:UIButton)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
    
        let dict = self.arrMDateBlock.object(at: sender.tag)as? NSMutableDictionary
        let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
        let strselected = String(format: "%@", dict?.value(forKey: "selected")as? String ?? "")
        var strisrenew = String(format: "%@", dict?.value(forKey: "isrenew")as? String ?? "")
        var strsubscriptionid = String(format: "%@", dict?.value(forKey: "subscriptionid")as? String ?? "")
        
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && date == %@", strcustomerid,"1",strdate)
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
        
        
        let ctrl = dailyproductcatalogue(nibName: "dailyproductcatalogue", bundle: nil)
        ctrl.strpageidentifier = "100"
        ctrl.strselecteddateindex = String(format: "%d", sender.tag)
        ctrl.strselecteddateindexdate = strdate
        ctrl.strselecteddateindexday = strday
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Edit Pencil for  Product from Each Daily Date Method
    @objc func presseditpencil(sender:UIButton)
    {
        self.createEditpopupDatewiseItems(selecteddateindex:sender.tag)
    }
    
    
    //MARK: - press review Your Order
    @IBAction func pressReviewOrder(_ sender: Any)
    {
        let ctrl = subscriptionorderreview(nibName: "subscriptionorderreview", bundle: nil)
        ctrl.strpageidentifier = "100"
        ctrl.strpageidentifierplanname = "Daily"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.isEqual(txtstartdate)
        {
            
        }
        else if textField.isEqual(txtenddate)
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
    let datePicker1 = DatePickerDialog()
    let datePicker2 = DatePickerDialog()
    func datePickerTappedStart()
    {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let timestring = df.string(from: date)
        print("timestring",timestring)
        
        let s1 = timestring
        let s2 = "15:00:00"
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
        dateComponents1.day = 18
        let next18days = Calendar.current.date(byAdding: dateComponents1, to: date111!)
        
        datePicker1.show("Select Start Date",
                         doneButtonTitle: "Done",
                         cancelButtonTitle: "Cancel",
                         minimumDate: date111,
                         maximumDate: next18days,
                         datePickerMode: .date) { (date) in
            if let dt = date
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                print("action")
                self.txtstartdate.text = formatter.string(from: dt)
                let nextdate = formatter.date(from: self.txtstartdate.text!)
                
                var intdiff = 0
                if self.strplanname == "Daily"{
                    intdiff = 9
                }
                let nextdate1 = Calendar.current.date(byAdding: .day, value: +intdiff, to: nextdate!)!
                let formatter2 = DateFormatter()
                formatter2.dateFormat = "dd/MM/yyyy"
                let enddate = formatter2.string(from: nextdate1)
                print("enddate date %@",enddate)
                
                self.txtenddate.text = enddate
                
                self.listofdate(strdate: self.txtstartdate.text!, enddate: self.txtenddate.text!)
            }
        }
    }
    func datePickerTappedEnd()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date111 = dateFormatter.date(from: self.txtstartdate.text!)
        
        var dateComponents = DateComponents()
        dateComponents.day = 28
        let next28days = Calendar.current.date(byAdding: dateComponents, to: date111!)
        
        var dateComponents1 = DateComponents()
        dateComponents1.day = 9
        let nexttendays = Calendar.current.date(byAdding: dateComponents1, to: date111!)
        
        let currentDate = Date()
        
        datePicker2.show("Select End Date",
                         doneButtonTitle: "Done",
                         cancelButtonTitle: "Cancel",
                         minimumDate: nexttendays,
                         maximumDate: next28days,
                         datePickerMode: .date) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                print("action")
                self.txtenddate.text = formatter.string(from: dt)
                
                self.listofdate(strdate: self.txtstartdate.text!, enddate: self.txtenddate.text!)
            }
        }
    }
    
    
    //MARK: - create POPUP EDIT ITEMS DATE WISE method
    func createEditpopupDatewiseItems(selecteddateindex:Int)
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let dict = appDel.arrMDATEWISEPRODUCTPLAN.object(at: selecteddateindex)as? NSMutableDictionary
        let strdate = String(format: "%@", dict?.value(forKey: "date")as? String ?? "")
        let strday = String(format: "%@", dict?.value(forKey: "day")as? String ?? "")
        
        let arrm = dict?.value(forKey: "items")as! NSMutableArray
        
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
    
    
    
    //MARK: - Fetch Dailymodel data Daily exist or not
    func fetchDataDailymodelTable()
    {
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
                    
                    self.arrMDateBlock.add(dictemp)
                    
                }
            }
            else{
                self.claculateDatetime()
            }
        }catch {
            print("err")
        }
        
        self.tabvdates.reloadData()
    }
    
    //MARK: - Fetch Remove Refresh Dailymodel data Daily exist or not
    func fetchRemoveRefreshDataDailymodelTable()
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"1")
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            
            if result.count > 0
            {
                for data in result as! [NSManagedObject]{
                    manageContent.delete(data as! NSManagedObject)
                }
            }
            else{

            }
            try manageContent.save()
        }catch {
            print("err")
        }
        
        self.tabvdates.reloadData()
    }
    
}
