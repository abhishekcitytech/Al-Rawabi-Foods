//
//  menuclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 20/06/22.
//

import UIKit

class menuclass: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var btnmenu: UIButton!
    @IBOutlet weak var imgvmenu: UIImageView!
    @IBOutlet weak var btnaccount: UIButton!
    @IBOutlet weak var imgvaccount: UIImageView!
    
    @IBOutlet weak var tabvlist: UITableView!
    var reuseIdentifier1 = "tabvcelllist"
    
    var arrMenu = NSMutableArray()
    var arrmAccount = NSMutableArray()
    
    var arrMenuimage = NSMutableArray()
    var arrmAccountimage = NSMutableArray()

    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        tabvlist.register(UINib(nibName: "tabvcelllist", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvlist.separatorStyle = .none
        tabvlist.backgroundView=nil
        tabvlist.backgroundColor=UIColor.clear
        tabvlist.separatorColor=UIColor.clear
        tabvlist.showsVerticalScrollIndicator = false
        
        btnmenu.backgroundColor =  UIColor(named: "themecolor")!
        btnmenu.setTitleColor(.white, for: .normal)
        imgvmenu.image = UIImage(named: "mn1")
        
        btnaccount.backgroundColor =  UIColor.white
        btnaccount.setTitleColor(.black, for: .normal)
        imgvaccount.image = UIImage(named: "acc1")
        
        self.tabvlist.isHidden = true
        self.postAllCategoryHomepageAPImethod()
        
        self.createAccountArraylist()
        
    }
    
    //MARK: - press Menu Button Method
    @IBAction func pressmenu(_ sender: Any) {
        
        btnmenu.backgroundColor =  UIColor(named: "themecolor")!
        btnmenu.setTitleColor(.white, for: .normal)
        imgvmenu.image = UIImage(named: "mn1")
        
        btnaccount.backgroundColor =  UIColor.white
        btnaccount.setTitleColor(.black, for: .normal)
        imgvaccount.image = UIImage(named: "acc1")
        
        tabvlist.tag = 100
        tabvlist.reloadData()
    }
    
    //MARK: - press Account Button Method
    @IBAction func pressaccount(_ sender: Any) {
        
        btnaccount.backgroundColor =  UIColor(named: "themecolor")!
        btnaccount.setTitleColor(.white, for: .normal)
        imgvaccount.image = UIImage(named: "acc2")
        
        btnmenu.backgroundColor =  UIColor.white
        btnmenu.setTitleColor(.black, for: .normal)
        imgvmenu.image = UIImage(named: "mn2")
        
        tabvlist.tag = 200
        tabvlist.reloadData()
    }
    
    
    //MARK: - create Account Tab Array List Method
    @objc func createAccountArraylist()
    {
        var arr1 = NSMutableArray()
        var arr2 = NSMutableArray()
        
        arr1 = ["View edit profile","My Wish List","View order history","View up-coming deliveries","Pause/restart recurring orders","Add/edit/delete sub-accounts","Top up/view balance","Re-order from old orders","Vacation/time-off settings","Loyalty point balance","Upgrade/downgrade/cancel membership","Returns/refunds","Manage multiple shipping address","Change Password"]
        
        arr2 = ["acc01.png","fav1.png","acc02.png","acc3.png","acc4.png","acc5.png","acc6.png","acc7.png","acc8.png","acc9.png","acc10.png","acc11.png","acc12.png","acc13.png"]
        
        for x in 0 ..< arr1.count
        {
            let dic1 = NSMutableDictionary()
            let str1 = String(format: "%@", arr1.object(at: x)as? String ?? "")
            dic1.setValue("", forKey: "id")
            dic1.setValue(str1, forKey: "value")
            
            let str2 = String(format: "%@", arr2.object(at: x)as? String ?? "")
            dic1.setValue(str2, forKey: "image")
            
            self.arrmAccount.add(dic1)
        }
        print("self.arrmAccount",self.arrmAccount)
    }
    
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tabvlist.tag == 100{
            return arrMenu.count
        }
        return arrmAccount.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tabvlist.tag == 200{
            return 44
        }
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tabvlist.tag == 200{
            
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
            headerView.backgroundColor = UIColor.white
            
            
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:  (tableView.frame.size.width)/2, height: 44))
            title1.textAlignment = .right
            title1.textColor = UIColor.black
            title1.text = "Current Subscription:"
            title1.backgroundColor = UIColor.clear
            title1.font = UIFont(name: "NunitoSans-Bold", size: 14)
            headerView.addSubview(title1)
            
            let title2 = UILabel(frame: CGRect(x: title1.frame.maxX + 10, y: 0, width:  (tableView.frame.size.width)/2 - 20, height: 44))
            title2.textAlignment = .left
            title2.textColor = UIColor(named: "greencolor")!
            title2.text = "Monthly"
            title2.backgroundColor = UIColor.clear
            title2.font = UIFont(name: "NunitoSans-Bold", size: 14)
            headerView.addSubview(title2)
            
            return headerView
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! tabvcelllist
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        if tabvlist.tag == 100
        {
            let dic = arrMenu.object(at: indexPath.row) as! NSDictionary
            let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
            let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
            
            cell.lblname.text = strplanname
            
            if strplanimage.contains("https")
            {
                cell.imgvicon.contentMode = .scaleAspectFit
                cell.imgvicon.imageFromURL(urlString: strplanimage)
            }
            else{
                cell.imgvicon.contentMode = .scaleAspectFit
                cell.imgvicon.image = UIImage(named: strplanimage)
            }
            
        }
        else{
            
            let dic = arrmAccount.object(at: indexPath.row) as! NSDictionary
            let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
            let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
            
            cell.lblname.text = strplanname
            cell.imgvicon.image = UIImage(named: strplanimage)
            
        }
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 53.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tabvlist.tag == 100
        {
            let dic = arrMenu.object(at: indexPath.row) as! NSDictionary
            let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
            let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
            
            if strplanname == "Home"
            {
                self.tabBarController?.selectedIndex = 0
            }
            else if strplanname == "Order by Subscription"
            {
                self.tabBarController?.selectedIndex = 1
            }
            else if strplanname == "Order Once"
            {
                
            }
            else if strplanname == "Dairy"
            {
                
            }
            else if strplanname == "Juice"
            {
                
            }
            else if strplanname == "Bakery"
            {
                
            }
            else if strplanname == "Meat"
            {
                
            }
            else if strplanname == "Offers"
            {
                
            }
            else if strplanname == "Review Order"
            {
                
            }
            else if strplanname == "Cart"
            {
                let ctrl = shoppingcart(nibName: "shoppingcart", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == "Contact"
            {
                
            }
        }
        else
        {
            let dic = arrmAccount.object(at: indexPath.row) as! NSDictionary
            let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
            let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
            
            if strplanname == "View edit profile"
            {
            }
            else if strplanname == "View order history"
            {
                let ctrl = myorderhistory(nibName: "myorderhistory", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == "View up-coming deliveries"
            {
            }
            else if strplanname == "Pause/restart recurring orders"
            {
            }
            else if strplanname == "Add/edit/delete sub-accounts"
            {
            }
            else if strplanname == "Top up/view balance"
            {
                let ctrl = mywallet(nibName: "mywallet", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == "Re-order from old orders"
            {
            }
            else if strplanname == "Vacation/time-off settings"
            {
            }
            else if strplanname == "Loyalty point balance"
            {
            }
            else if strplanname == "Upgrade/downgrade/cancel membership"
            {
            }
            else if strplanname == "Returns/refunds"
            {
            }
            else if strplanname == "Manage multiple shipping address"
            {
                let ctrl = myaddresslist(nibName: "myaddresslist", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == "Change Password"
            {
            }
            else if strplanname == "My Wish List"
            {
                let ctrl = mywishlist(nibName: "mywishlist", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
    }

    
    //MARK: - post All Category Home Page method
    func postAllCategoryHomepageAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        //let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        //print("strbearertoken",strbearertoken)
        
        let parameters = ["categoryCount": "none",
                          "categoryImage": "all",
                          "categoryName": "none",
                          "categoryId": "none"] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod9)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        //request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_networkerror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                            print("strbearertoken",strbearertoken)
                            
                            if strbearertoken != ""
                            {
                                //Loggedin
                                self.tabvlist.isHidden = false
                                
                                self.btnaccount.isHidden = false
                                self.imgvaccount.isHidden = false
                                
                                let dic1 = NSMutableDictionary()
                                dic1.setValue("sl1.png", forKey: "image")
                                dic1.setValue("Home", forKey: "value")
                                dic1.setValue("", forKey: "id")
                                self.arrMenu.add(dic1)
                                
                                let dic2 = NSMutableDictionary()
                                dic2.setValue("sl2.png", forKey: "image")
                                dic2.setValue("Order by Subscription", forKey: "value")
                                dic2.setValue("", forKey: "id")
                                self.arrMenu.add(dic2)
                                
                                let dic3 = NSMutableDictionary()
                                dic3.setValue("sl3.png", forKey: "image")
                                dic3.setValue("Order Once", forKey: "value")
                                dic3.setValue("", forKey: "id")
                                self.arrMenu.add(dic3)
                                
                                let arrmcategorytree = dictemp.value(forKey: "categoryTree") as? NSArray ?? []
                                let arrm1 = NSMutableArray(array: arrmcategorytree)
                                
                                for x in 0 ..< arrm1.count
                                {
                                    let dic = NSMutableDictionary()
                                    
                                    let dictemp = arrm1.object(at: x)as? NSDictionary
                                    let strname = String(format: "%@", dictemp?.value(forKey: "text") as? String ?? "")
                                    let strid = String(format: "%@", dictemp?.value(forKey: "id") as! CVarArg)
                                    let strimage = String(format: "%@", dictemp?.value(forKey: "categoryImage") as? String ?? "")
                                    
                                    let arrm11 = dictemp?.value(forKey: "children")as? NSArray ?? []
                                    
                                    dic.setValue(strimage, forKey: "image")
                                    dic.setValue(strname, forKey: "value")
                                    dic.setValue(strid, forKey: "id")
                                    dic.setValue(arrm11, forKey: "children")
                                    self.arrMenu.add(dic)
                                }
                                
                                let dic4 = NSMutableDictionary()
                                dic4.setValue("sl10.png", forKey: "image")
                                dic4.setValue("Cart", forKey: "value")
                                dic4.setValue("", forKey: "id")
                                self.arrMenu.add(dic4)
                                
                                let dic5 = NSMutableDictionary()
                                dic5.setValue("sl11.png", forKey: "image")
                                dic5.setValue("Contact", forKey: "value")
                                dic5.setValue("", forKey: "id")
                                self.arrMenu.add(dic5)
                            }
                            else
                            {
                                //not loggedin
                                self.tabvlist.isHidden = false
                                
                                self.btnaccount.isHidden = true
                                self.imgvaccount.isHidden = true
                                
                                let dic1 = NSMutableDictionary()
                                dic1.setValue("sl1.png", forKey: "image")
                                dic1.setValue("Home", forKey: "value")
                                dic1.setValue("", forKey: "id")
                                self.arrMenu.add(dic1)
                                
                                let dic2 = NSMutableDictionary()
                                dic2.setValue("sl2.png", forKey: "image")
                                dic2.setValue("Order by Subscription", forKey: "value")
                                dic2.setValue("", forKey: "id")
                                self.arrMenu.add(dic2)
                                
                                let dic3 = NSMutableDictionary()
                                dic3.setValue("sl3.png", forKey: "image")
                                dic3.setValue("Order Once", forKey: "value")
                                dic3.setValue("", forKey: "id")
                                self.arrMenu.add(dic3)
                                
                                let arrmcategorytree = dictemp.value(forKey: "categoryTree") as? NSArray ?? []
                                let arrm1 = NSMutableArray(array: arrmcategorytree)
                                
                                for x in 0 ..< arrm1.count
                                {
                                    let dic = NSMutableDictionary()
                                    
                                    let dictemp = arrm1.object(at: x)as? NSDictionary
                                    let strname = String(format: "%@", dictemp?.value(forKey: "text") as? String ?? "")
                                    let strid = String(format: "%@", dictemp?.value(forKey: "id") as! CVarArg)
                                    let strimage = String(format: "%@", dictemp?.value(forKey: "categoryImage") as? String ?? "")
                                    let arrm11 = dictemp?.value(forKey: "children")as? NSArray ?? []
                                    
                                    dic.setValue(strimage, forKey: "image")
                                    dic.setValue(strname, forKey: "value")
                                    dic.setValue(strid, forKey: "id")
                                    dic.setValue(arrm11, forKey: "children")
                                    self.arrMenu.add(dic)
                                }
                                
                                let dic5 = NSMutableDictionary()
                                dic5.setValue("sl11.png", forKey: "image")
                                dic5.setValue("Contact", forKey: "value")
                                dic5.setValue("", forKey: "id")
                                self.arrMenu.add(dic5)
                                
                            }
                            
                            self.tabvlist.tag = 100
                            self.tabvlist.reloadData()
                            
                            print("self.arrMenu",self.arrMenu)
     
                        }
                        else{
                            
                            self.errorchecklistarray()
                            
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.errorchecklistarray()
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    func errorchecklistarray()
    {
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        if strbearertoken != ""
        {
            //Loggedin
            let dic1 = NSMutableDictionary()
            dic1.setValue("sl1.png", forKey: "image")
            dic1.setValue("Home", forKey: "value")
            dic1.setValue("", forKey: "id")
            self.arrMenu.add(dic1)
            
            let dic2 = NSMutableDictionary()
            dic2.setValue("sl2.png", forKey: "image")
            dic2.setValue("Order by Subscription", forKey: "value")
            dic2.setValue("", forKey: "id")
            self.arrMenu.add(dic2)
            
            let dic3 = NSMutableDictionary()
            dic3.setValue("sl3.png", forKey: "image")
            dic3.setValue("Order Once", forKey: "value")
            dic3.setValue("", forKey: "id")
            self.arrMenu.add(dic3)
            
            let dic4 = NSMutableDictionary()
            dic4.setValue("sl10.png", forKey: "image")
            dic4.setValue("Cart", forKey: "value")
            dic4.setValue("", forKey: "id")
            self.arrMenu.add(dic4)
            
            let dic5 = NSMutableDictionary()
            dic5.setValue("sl11.png", forKey: "image")
            dic5.setValue("Contact", forKey: "value")
            dic5.setValue("", forKey: "id")
            self.arrMenu.add(dic5)
        }
        else{
            //not loggedin
            
            let dic1 = NSMutableDictionary()
            dic1.setValue("sl1.png", forKey: "image")
            dic1.setValue("Home", forKey: "value")
            dic1.setValue("", forKey: "id")
            self.arrMenu.add(dic1)
            
            let dic2 = NSMutableDictionary()
            dic2.setValue("sl2.png", forKey: "image")
            dic2.setValue("Order by Subscription", forKey: "value")
            dic2.setValue("", forKey: "id")
            self.arrMenu.add(dic2)
            
            let dic3 = NSMutableDictionary()
            dic3.setValue("sl3.png", forKey: "image")
            dic3.setValue("Order Once", forKey: "value")
            dic3.setValue("", forKey: "id")
            self.arrMenu.add(dic3)
            
            let dic5 = NSMutableDictionary()
            dic5.setValue("sl11.png", forKey: "image")
            dic5.setValue("Contact", forKey: "value")
            dic5.setValue("", forKey: "id")
            self.arrMenu.add(dic5)
        }
    }
}
