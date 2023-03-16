//
//  myorderhistory.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class myorderhistory: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource
{

    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvmyorders: UITableView!
    var reuseIdentifier1 = "cellmyorders"
    var msg = ""
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var colstatus: UICollectionView!
    var reuseIdentifier2 = "cellcolorderstatus"
    var msg1 = ""
    
    var arrMorderstatus = NSMutableArray()
    var arrMmyorders = NSMutableArray()
    
    var strselectedindexstatus = ""
    
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
        
        self.getAllOrdersStatusAPIMethod()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language204")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        tabvmyorders.register(UINib(nibName: "cellmyorders", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyorders.separatorStyle = .none
        tabvmyorders.backgroundView=nil
        tabvmyorders.backgroundColor=UIColor.clear
        tabvmyorders.separatorColor=UIColor.clear
        tabvmyorders.showsVerticalScrollIndicator = false
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colstatus.frame.size.width / 3 - 10, height: 60)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        colstatus.collectionViewLayout = layout
        colstatus.register(UINib(nibName: "cellcolorderstatus", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
        colstatus.showsHorizontalScrollIndicator = false
        colstatus.showsVerticalScrollIndicator=false
        colstatus.backgroundColor = .clear
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMmyorders.count == 0 {
            self.tabvmyorders.setEmptyMessage(msg)
        } else {
            self.tabvmyorders.restore()
        }
        return arrMmyorders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 190
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellmyorders
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMmyorders.object(at: indexPath.section)as! NSDictionary
        
        let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        let strstatus = String(format: "%@", dic.value(forKey: "status")as? String ?? "")
        let strtotal_amount = String(format: "%@", dic.value(forKey: "total_amount")as? String ?? "")
        
        var strcurrency_code = String(format: "%@", dic.value(forKey: "currency_code")as? String ?? "")

        strcurrency_code = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
        
        let strcreated_at = String(format: "%@", dic.value(forKey: "created_at")as? String ?? "")
        let strordered_qty = String(format: "%@", dic.value(forKey: "ordered_qty")as? String ?? "")
        
        
        cell.lblorderno.text = myAppDelegate.changeLanguage(key: "msg_language207")
        cell.lblstartdate.text = myAppDelegate.changeLanguage(key: "msg_language208")
        cell.lblqty.text = myAppDelegate.changeLanguage(key: "msg_language209")
        cell.lbltotalamont.text = myAppDelegate.changeLanguage(key: "msg_language210")
      
        cell.lblordernovalue.text = String(format: "# %@", strorder_id)
        cell.lblstartdatevalue.text = strcreated_at
        cell.lblstatus.text = strstatus
        cell.lblquantityvalue.text = strordered_qty
        cell.lbltotalamountvalue.text = String(format: "%@ %@",strcurrency_code, strtotal_amount)
        
        cell.lblsubscriptionplanname.isHidden = true
        cell.lblpauseresume.isHidden = true
        cell.switchpauseresume.isHidden = true
        
        if strstatus == "ngenius_authorised" || strstatus == "processing"
        {
            cell.lblstatus.textColor = UIColor(named: "greencolor")!
            //cell.switchpauseresume.isOn = false
            //cell.lblpauseresume.text = "Pause"
        }
        else if strstatus == "complete"
        {
            cell.lblstatus.textColor = UIColor(named: "greencolor")!
            //cell.switchpauseresume.isOn = false
            //cell.lblpauseresume.text = "Pause"
        }
        else if strstatus == "pending"
        {
            cell.lblstatus.textColor = UIColor(named: "orangecolor")!
            //cell.switchpauseresume.isOn = true
            //cell.lblpauseresume.text = "Start"
        }
        else if strstatus == "canceled"
        {
            cell.lblstatus.textColor = UIColor(named: "darkredcolor")!
            //cell.switchpauseresume.isOn = false
            //cell.lblpauseresume.text = "Pause"
        }
        else{
            cell.lblstatus.textColor = UIColor.darkGray
        }
        
        cell.btndetails.layer.borderWidth = 1.0
        cell.btndetails.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cell.btndetails.layer.cornerRadius = 16.0
        cell.btndetails.layer.masksToBounds = true
        
        
        cell.viewcell.backgroundColor = UIColor.white
        cell.viewcell.layer.masksToBounds = false
        cell.viewcell.layer.cornerRadius = 6.0
        cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.borderWidth = 1.0
        cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.viewcell.layer.shadowOpacity = 1.0
        cell.viewcell.layer.shadowRadius = 6.0
        
        cell.btndetails.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language91")), for: .normal)
        cell.btndetails.tag = indexPath.section
        cell.btndetails.addTarget(self, action: #selector(pressDetails), for: .touchUpInside)
        
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.arrMmyorders.object(at: indexPath.section)as! NSDictionary
        let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        
        let ctrl = myorderhistorydetails(nibName: "myorderhistorydetails", bundle: nil)
        ctrl.strorder_id = strorder_id
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    @objc func pressDetails(sender:UIButton)
    {
        let dic = self.arrMmyorders.object(at: sender.tag)as! NSDictionary
        let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        
        let ctrl = myorderhistorydetails(nibName: "myorderhistorydetails", bundle: nil)
        ctrl.strorder_id = strorder_id
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if arrMorderstatus.count == 0 {
            self.colstatus.setEmptyMessage(msg1)
        } else {
            self.colstatus.restore()
        }
        return arrMorderstatus.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! cellcolorderstatus
        cellA.contentView.backgroundColor = .clear
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let dictemp = arrMorderstatus.object(at: indexPath.row)as? NSDictionary
        let strvalue  = String(format: "%@", dictemp?.value(forKey: "value")as? String ?? "")
        let strlabel  = String(format: "%@", dictemp?.value(forKey: "label")as? String ?? "")
       
        cellA.lblname.text = strlabel
        
        if self.strselectedindexstatus ==  String(format: "%d", indexPath.row)
        {
            cellA.viewcell.layer.cornerRadius = 18
            cellA.viewcell.layer.borderWidth = 2.0
            cellA.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        else{
         
            cellA.viewcell.layer.cornerRadius = 18
            cellA.viewcell.layer.borderWidth = 2.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: colstatus.frame.size.width / 3 , height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dictemp = arrMorderstatus.object(at: indexPath.row)as? NSDictionary
        let strvalue  = String(format: "%@", dictemp?.value(forKey: "value")as? String ?? "")
        let strlabel  = String(format: "%@", dictemp?.value(forKey: "label")as? String ?? "")
        
        self.strselectedindexstatus = String(format: "%d", indexPath.row)
        
        self.colstatus.reloadData()
        
        self.getAllOrdersAPIMethod(stratstus: strvalue)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    
    
    
    //MARK: - get All Orders Staus API method
    func getAllOrdersStatusAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod27)
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
                    //print("dictemp --->",dictemp)
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            if self.arrMorderstatus.count > 0{
                                self.arrMorderstatus.removeAllObjects()
                            }
                            
                            let arrmorderstatus = json.value(forKey: "options") as? NSArray ?? []
                            
                            let dicall = NSMutableDictionary()
                            dicall.setValue("all", forKey: "value")
                            dicall.setValue("All", forKey: "label")
                            self.arrMorderstatus.add(dicall)
                            print("arrMorderstatus --->",self.arrMorderstatus)
                            
                            let arrm1 = NSMutableArray(array: arrmorderstatus)
                            
                            self.arrMorderstatus.addObjects(from: arrm1 as! [Any])
                            
                            print("arrMorderstatus --->",self.arrMorderstatus)
                            
                            if self.arrMorderstatus.count == 0{
                                self.msg1 = "No orders status found!"
                            }
                            
                            //By Default ALL
                            let dictemp = self.arrMorderstatus.object(at: 0)as? NSDictionary
                            let strvalue  = String(format: "%@", dictemp?.value(forKey: "value")as? String ?? "")
                            self.getAllOrdersAPIMethod(stratstus: strvalue)
                            self.strselectedindexstatus = "0"
                            self.colstatus.reloadData()
                            
                            
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
    
    //MARK: - get All Orders API method
    func getAllOrdersAPIMethod(stratstus:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?status=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod20,stratstus,strLangCode)
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
                    //print("dictemp --->",dictemp)
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            if self.arrMmyorders.count > 0{
                                self.arrMmyorders.removeAllObjects()
                            }
                            
                            let arrmorder = json.value(forKey: "orderdetail") as? NSArray ?? []
                            self.arrMmyorders = NSMutableArray(array: arrmorder)
                            print("arrMmyorders --->",self.arrMmyorders)
                            
                            if self.arrMmyorders.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language206")
                            }
                            
                            self.tabvmyorders.reloadData()
                            
                            
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

}
