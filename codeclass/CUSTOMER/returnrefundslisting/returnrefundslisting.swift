//
//  returnrefundslisting.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/11/22.
//

import UIKit

class returnrefundslisting: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvmyorders: UITableView!
    var reuseIdentifier1 = "cellreturnrefund"
    var msg = ""
    
    var arrMmyorders = NSMutableArray()
    
    
    @IBOutlet var viewpopupedititems: UIView!
    @IBOutlet weak var lbleditpopupDateDay: UILabel!
    @IBOutlet weak var btncrosseditpopup: UIButton!
    @IBOutlet weak var tabveditpopupitems: UITableView!
    var reuseIdentifier2 = "cellproductitemrefunded"
    var viewPopupAddNewExistingBG2 = UIView()
    var arrMProductItems = NSMutableArray()

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
        
        self.getCreditRefundMemoList()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language404")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvmyorders.register(UINib(nibName: "cellreturnrefund", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyorders.separatorStyle = .none
        tabvmyorders.backgroundView=nil
        tabvmyorders.backgroundColor=UIColor.clear
        tabvmyorders.separatorColor=UIColor.clear
        tabvmyorders.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        
        if arrMmyorders.count == 0 {
            self.tabvmyorders.setEmptyMessage(msg)
        } else {
            self.tabvmyorders.restore()
        }
        return arrMmyorders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tabveditpopupitems{
            return arrMProductItems.count
        }
        
        let dic = self.arrMmyorders.object(at: section)as! NSDictionary
        let arrm1 = dic.value(forKey: "creditMemoDetails") as? NSArray ?? []
        return arrm1.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tabveditpopupitems{
            return 84
        }
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        return 80
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == tabveditpopupitems{
            return 1
        }
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if tableView == tabveditpopupitems{
            
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            headerView.backgroundColor = .white
            return headerView
        }
        
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80)
        headerView.backgroundColor = UIColor(named: "plate7")!
        
        let dic = self.arrMmyorders.object(at: section)as! NSDictionary
        
        let strorderNumber = String(format: "%@", dic.value(forKey: "orderNumber")as? String ?? "")
        let strorderDate = String(format: "%@", dic.value(forKey: "orderDate")as? String ?? "")
        
        let title1 = UILabel(frame: CGRect(x: 8, y: 0, width:headerView.frame.self.width - 16, height: 30))
        title1.textAlignment = .left
        title1.textColor = .darkGray
        title1.backgroundColor = .clear
        title1.numberOfLines = 10
        title1.font = UIFont (name: "NunitoSans-Regular", size: 14)
        title1.text = String(format: "%@%@",myAppDelegate.changeLanguage(key: "msg_language308") ,"#")
        headerView.addSubview(title1)
        
        let title2 = UILabel(frame: CGRect(x: 8, y: title1.frame.maxY, width:headerView.frame.self.width - 16, height: 30))
        title2.textAlignment = .left
        title2.textColor = UIColor(named: "themecolor")!
        title2.backgroundColor = .clear
        title2.numberOfLines = 10
        title2.font = UIFont (name: "NunitoSans-Bold", size: 14)
        title2.text = String(format: "%@", strorderNumber)
        headerView.addSubview(title2)
        
        let title3 = UILabel(frame: CGRect(x: 8, y: title1.frame.maxY, width:headerView.frame.self.width - 16, height: 30))
        title3.textAlignment = .right
        title3.textColor = .black
        title3.backgroundColor = .clear
        title3.numberOfLines = 10
        title3.font = UIFont (name: "NunitoSans-Regular", size: 14)
        title3.text = String(format: "%@", strorderDate)
        headerView.addSubview(title3)
        

        headerView.backgroundColor = UIColor.white
        headerView.layer.masksToBounds = false
        headerView.layer.cornerRadius = 6.0
        headerView.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        headerView.layer.borderWidth = 1.0
        headerView.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        headerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        headerView.layer.shadowOpacity = 1.0
        headerView.layer.shadowRadius = 6.0
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if tableView == tabveditpopupitems{
            
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
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as! cellproductitemrefunded
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor = .clear
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            let dic = self.arrMProductItems.object(at: indexPath.section)as! NSDictionary
            
            let strproduct_name = String(format: "%@", dic.value(forKey: "product_name")as? String ?? "")
            let strproduct_qty = String(format: "%@", dic.value(forKey: "product_qty")as? String ?? "")
            
            let flt11 = Float(strproduct_qty)
            cell.lblname.text = String(format: "%@", strproduct_name)
            cell.lblqty.text = String(format: "%@: %0.0f", myAppDelegate.changeLanguage(key: "msg_language214"),flt11!)
            
            /*cell.viewcell.tag = indexPath.section
            cell.viewcell.backgroundColor = UIColor(named: "plate7")!
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 0.0
            cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cell.viewcell.layer.borderWidth = 0.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0*/
            
            return cell;
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellreturnrefund
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMmyorders.object(at: indexPath.section)as! NSDictionary
        let arrm1 = dic.value(forKey: "creditMemoDetails") as? NSArray ?? []
        
        let dic1 = arrm1.object(at: indexPath.row)as! NSDictionary
        
        let strincrementId = String(format: "%@", dic1.value(forKey: "incrementId")as? String ?? "")
        let strcreditMemoCreatedDate = String(format: "%@", dic1.value(forKey: "creditMemoCreatedDate")as? String ?? "")
        let strgrandTotal = String(format: "%@", dic1.value(forKey: "grandTotal")as? String ?? "")
        let strorderCurrencyCode = String(format: "%@", dic1.value(forKey: "orderCurrencyCode")as? String ?? "")
        
        cell.lblorderno.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language480"))
        cell.lblordernovalue.text = String(format: "%@", strincrementId)
        cell.lbldatevalue.text = strcreditMemoCreatedDate
        
        let flt11 = Float(strgrandTotal)
        cell.lblamount.text = String(format: "%@ %0.2f", myAppDelegate.changeLanguage(key: "msg_language481"),flt11!)
        
        cell.btnViewDetails.layer.cornerRadius = 14.0
        cell.btnViewDetails.layer.masksToBounds = true
        
        cell.btnViewDetails.tag = indexPath.row
        cell.btnViewDetails.setTitle(myAppDelegate.changeLanguage(key: "msg_language497"), for: .normal)
        cell.btnViewDetails.addTarget(self, action: #selector(pressviewdetails), for: .touchUpInside)
        
        cell.viewcell.tag = indexPath.section
        cell.viewcell.backgroundColor = UIColor(named: "plate7")!
        cell.viewcell.layer.masksToBounds = false
        cell.viewcell.layer.cornerRadius = 0.0
        cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.borderWidth = 0.0
        cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.viewcell.layer.shadowOpacity = 1.0
        cell.viewcell.layer.shadowRadius = 6.0
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tabveditpopupitems
        {
            
        }
        else
        {
            let cell = tabvmyorders.cellForRow(at: indexPath)as! cellreturnrefund
            
            let dic = self.arrMmyorders.object(at: cell.viewcell.tag)as! NSDictionary
            let arrm1 = dic.value(forKey: "creditMemoDetails") as? NSArray ?? []
            
            let dic1 = arrm1.object(at: indexPath.row)as! NSDictionary
            let arrm2 = dic1.value(forKey: "product") as? NSArray ?? []
            print("arrm2",arrm2)
            
            if arrMProductItems.count > 0 {
                arrMProductItems.removeAllObjects()
            }
            self.arrMProductItems = NSMutableArray(array: arrm2)
            print("arrMProductItems --->",self.arrMProductItems)
            
            self.createEditpopupProductItems()
        }
    }
    @objc func pressviewdetails(sender:UIButton)
    {
        let dic = self.arrMmyorders.object(at: sender.tag)as! NSDictionary
        let arrm1 = dic.value(forKey: "creditMemoDetails") as? NSArray ?? []
        
        let dic1 = arrm1.object(at: sender.tag)as! NSDictionary
        let arrm2 = dic1.value(forKey: "product") as? NSArray ?? []
        print("arrm2",arrm2)
        
        if arrMProductItems.count > 0 {
            arrMProductItems.removeAllObjects()
        }
        self.arrMProductItems = NSMutableArray(array: arrm2)
        print("arrMProductItems --->",self.arrMProductItems)
        
        self.createEditpopupProductItems()
    }
    
    
    //MARK: - create POPUP PROCUT ITEMS SHIPPMENT WISE method
    func createEditpopupProductItems()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewpopupedititems.layer.cornerRadius = 6.0
        self.viewpopupedititems.layer.masksToBounds = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        self.lbleditpopupDateDay.text = appDel.changeLanguage(key: "msg_language147")
        
        tabveditpopupitems.register(UINib(nibName: "cellproductitemrefunded", bundle: nil), forCellReuseIdentifier: reuseIdentifier2)
        tabveditpopupitems.separatorStyle = .none
        tabveditpopupitems.backgroundView=nil
        tabveditpopupitems.backgroundColor=UIColor.clear
        tabveditpopupitems.separatorColor=UIColor.clear
        tabveditpopupitems.showsVerticalScrollIndicator = false
        tabveditpopupitems.sectionHeaderHeight = 0.0
        tabveditpopupitems.sectionFooterHeight = 0.0
        
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
    }
   
    //MARK: - get Refund Credit Memo List API method
    func getCreditRefundMemoList()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod103)
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
                        
                        if strsuccess == true
                        {
                            let arrmproducts = json.value(forKey: "creditMemoData") as? NSArray ?? []
                            self.arrMmyorders = NSMutableArray(array: arrmproducts)
                            print("arrMmyorders --->",self.arrMmyorders)
                            
                            if self.arrMmyorders.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language150")
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
