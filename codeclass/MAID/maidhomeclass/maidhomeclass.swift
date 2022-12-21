//
//  maidhomeclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 16/05/22.
//

import UIKit

class maidhomeclass: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var colmaidhome: UICollectionView!
    var reuseIdentifier1 = "colcellmaidhome"
    
    var arrMmaidhome = NSMutableArray()
    
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
      
        self.getOrderOnceCartCountAPIMethod()
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillDisappear(_ animated: Bool)
    {
        self.tabBarController?.tabBar.isHidden = true
        super.viewWillDisappear(true)
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        self.title = "Maid Home"
        
        let searchicon = UIImage(named: "slidemenuB")
        let search = UIBarButtonItem(image: searchicon, style: .plain, target: self, action: #selector(pressMenu))
        search.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = search
        
        arrMmaidhome = ["View Subscriptions","Paused Subscriptions","Order Once","Wallet Balance"]
        
        colmaidhome.backgroundColor = .clear
        let layout = colmaidhome.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2.0 - 15, height: 190)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colmaidhome.register(UINib(nibName: "colcellmaidhome", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colmaidhome.showsVerticalScrollIndicator = false
        colmaidhome.showsHorizontalScrollIndicator = false
        
        self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
    }
    
    //MARK: - press Menu method
    @objc func pressMenu()
    {
        let obj = maidmenuclass(nibName: "maidmenuclass", bundle: nil)
        self.navigationController?.pushViewController(obj, animated: false)
    }
    
    //MARK: - Set Up Right Bar Cart Bag Item UI Design Method
    @objc func setupRightBarCartBagDesignMethod(intcountOrder:Int)
    {
        let badgeCount = UILabel(frame: CGRect(x: 20, y: -4, width: 20, height: 20))
        badgeCount.layer.borderColor = UIColor.clear.cgColor
        badgeCount.layer.borderWidth = 0
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = UIFont(name: "NunitoSans-Regular", size: 12.5)
        badgeCount.backgroundColor = UIColor(red: 239/255, green: 53/255, blue: 48/255, alpha: 1.0)
        badgeCount.text = String(format: "%d", intcountOrder)
        
        let rightBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        rightBarButton.setBackgroundImage(UIImage(named: "cartbag"), for: .normal)
        //rightBarButton.tintColor = .black
        rightBarButton.addTarget(self, action: #selector(presscartbag), for: .touchUpInside)
        rightBarButton.addSubview(badgeCount)
        let rightBarButtomItem = UIBarButtonItem(customView: rightBarButton)
        
        let stackViewAppearance = UIStackView.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        stackViewAppearance.spacing = 1
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            navigationItem.rightBarButtonItems = [rightBarButtomItem]
        }
        else{
            navigationItem.leftBarButtonItems = [rightBarButtomItem]
        }
        
    }
    
    //MARK: - press Cartbag method
    @objc func presscartbag()
    {
        let ctrl = maidcartlist(nibName: "maidcartlist", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrMmaidhome.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellmaidhome
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 8.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let strname = String(format: "%@", arrMmaidhome.object(at: indexPath.row)as? String ?? "")
        
        if strname == "View Subscriptions"
        {
            cellA.imgvicon.image = UIImage(named: "acc4.png")
            cellA.viewcell.backgroundColor = UIColor(named: "colorviewsubscription")!
        }
        else if strname == "Paused Subscriptions"
        {
            cellA.imgvicon.image = UIImage(named: "acc10.png")
            cellA.viewcell.backgroundColor = UIColor(named: "colorpausedsubscription")!
        }
        else if strname == "Order Once"
        {
            cellA.imgvicon.image = UIImage(named: "sl3.png")
            cellA.viewcell.backgroundColor = UIColor(named: "colormaidorderonce")!
        }
        else if strname == "Wallet Balance"
        {
            cellA.imgvicon.image = UIImage(named: "acc6.png")
            cellA.viewcell.backgroundColor = UIColor(named: "colormaidwallet")!
        }
        
        cellA.lblname.text = strname
        
        cellA.viewcell.layer.borderWidth = 1.0
        cellA.viewcell.layer.borderColor = UIColor.clear.cgColor
        cellA.viewcell.layer.cornerRadius = 8.0
        cellA.viewcell.layer.masksToBounds = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let strname = String(format: "%@", arrMmaidhome.object(at: indexPath.row)as? String ?? "")
        
        if strname == "View Subscriptions"
        {
            let obj = maidviewsubscriptions(nibName: "maidviewsubscriptions", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else if strname == "Paused Subscriptions"
        {
            let obj = maidpausedsubscriptions(nibName: "maidpausedsubscriptions", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else if strname == "Order Once"
        {
            let obj = maidorderonce(nibName: "maidorderonce", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else if strname == "Wallet Balance"
        {
            let obj = maidwalletdetails(nibName: "maidwalletdetails", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        
    }
    
    //MARK: - get Order Once Cart Count API method
    func getOrderOnceCartCountAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        /*let parameters = ["productid": strSelectedProductID
         ] as [String : Any]*/
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod29)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                            if let total_quantity = json["total_quantity"]
                            {
                                print("found!")
                                
                                let strqty = dictemp.value(forKey: "total_quantity")as! CVarArg
                                UserDefaults.standard.set(strqty, forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                
                                let strcount = UserDefaults.standard.value(forKey: "orderoncecartcount")as? Int ?? 0
                                print("strcount",strcount)
                                self.setupRightBarCartBagDesignMethod(intcountOrder: strcount)
                            }
                            else{
                                print("Not found!")
                                
                                UserDefaults.standard.set("0", forKey: "orderoncecartcount")
                                UserDefaults.standard.synchronize()
                                self.setupRightBarCartBagDesignMethod(intcountOrder: 0)
                                
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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

                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
