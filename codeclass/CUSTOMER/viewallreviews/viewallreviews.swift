//
//  viewallreviews.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/06/22.
//

import UIKit

class viewallreviews: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvreviewlist: UITableView!
    var reuseIdentifier3 = "tabvcellreview"

    var arrmreviews = NSMutableArray()
    
    var strproductid = ""


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
        
        self.postListReviewApIMethod()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language184")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvreviewlist.register(UINib(nibName: "tabvcellreview", bundle: nil), forCellReuseIdentifier: reuseIdentifier3)
        tabvreviewlist.separatorStyle = .none
        tabvreviewlist.backgroundView=nil
        tabvreviewlist.backgroundColor=UIColor.clear
        tabvreviewlist.separatorColor=UIColor.clear
        tabvreviewlist.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrmreviews.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3, for: indexPath) as! tabvcellreview
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dictmep = arrmreviews.object(at: indexPath.section)as! NSDictionary
        let strnickname = String(format: "%@", dictmep.value(forKey: "nickname")as? String ?? "")
        let strtitle = String(format: "%@", dictmep.value(forKey: "title")as? String ?? "")
        let strdetail = String(format: "%@", dictmep.value(forKey: "detail")as? String ?? "")
        let strrating = String(format: "%@", dictmep.value(forKey: "rating")as! CVarArg)
        
        if strrating == "null" || strrating == ""
        {
            cell.viewrating.isHidden = true
        }else{
            cell.viewrating.isHidden = false
        }
        
        cell.imgvuser.image = UIImage(named: "graycircle")
        cell.lblname.text = strnickname
        cell.lbltime.text = strtitle
        if strrating.contains("20"){
            cell.viewrating.rating = 1
        }
        else if strrating.contains("40"){
            cell.viewrating.rating = 2
        }
        else if strrating.contains("60"){
            cell.viewrating.rating = 3
        }
        else if strrating.contains("80"){
            cell.viewrating.rating = 4
        }
        else if strrating.contains("100"){
            cell.viewrating.rating = 5
        }
        
        cell.txtvdesc.text = strdetail
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

    }
    
    
    //MARK: - post List Review API method
    func postListReviewApIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        let parameters = ["productId": strproductid,"language": strLangCode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod15)
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
                            let arrmproducts = json.value(forKey: "all review") as? NSArray ?? []
                            self.arrmreviews = NSMutableArray(array: arrmproducts)
                            print("arrmreviews --->",self.arrmreviews)
                            
                            if self.arrmreviews.count > 0{
                                self.tabvreviewlist.reloadData()
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
}
