//
//  renewsubscriptionaddproduct.swift
//  AlRawabi
//
//  Created by Admin on 01/04/23.
//

import UIKit
import CoreData

class renewsubscriptionaddproduct: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet var viewoverall: UIView!
    
    @IBOutlet var viewtopsearch: UIView!
    @IBOutlet var txtsearchbar: UITextField!
    @IBOutlet var btncrosssearch: UIButton!
    
    
    @IBOutlet weak var colproductlist: UICollectionView!
    var reuseIdentifier1 = "colcellproductonly"
    var msg = ""
    
    var arrMCategorywiseProductlist = NSMutableArray()
    
    var strselecteddate = ""
    var strselectedday = ""
    var strselecteddayname = ""
    var strselectedsubscriptionplanid = ""
    
    var strpagefrom = ""
    
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
        
       
        setupRTLLTR()
        
        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: "")
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language265"))
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        txtsearchbar.layer.cornerRadius = 16.0
        txtsearchbar.layer.masksToBounds = true
        txtsearchbar.setLeftPaddingPoints(10.0)
        
        colproductlist.backgroundColor = .clear
        let layout = colproductlist.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2.0 - 15, height: 294)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        colproductlist.register(UINib(nibName: "colcellproductonly", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colproductlist.showsVerticalScrollIndicator = false
        colproductlist.showsHorizontalScrollIndicator = false
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Cross Search Method
    @IBAction func pressCrossSearch(_ sender: Any)
    {
        self.txtsearchbar.text = ""
        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: txtsearchbar.text!)
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        txtsearchbar.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language80"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.btncrosssearch.frame = CGRect(x: self.viewtopsearch.frame.size.width - self.btncrosssearch.frame.size.width - 8, y: self.btncrosssearch.frame.origin.y, width: self.btncrosssearch.frame.size.width, height: self.btncrosssearch.frame.size.height)
            
            self.txtsearchbar.frame = CGRect(x: 8, y: self.txtsearchbar.frame.origin.y, width: self.txtsearchbar.frame.size.width, height: self.txtsearchbar.frame.size.height)
            self.txtsearchbar.textAlignment = .left
        }
        else{
            
            self.btncrosssearch.frame = CGRect(x: 8, y: self.btncrosssearch.frame.origin.y, width: self.btncrosssearch.frame.size.width, height: self.btncrosssearch.frame.size.height)
            
            self.txtsearchbar.frame = CGRect(x: self.btncrosssearch.frame.maxX + 5, y: self.txtsearchbar.frame.origin.y, width: self.txtsearchbar.frame.size.width, height: self.txtsearchbar.frame.size.height)
            self.txtsearchbar.textAlignment = .right
        }
    }
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true;
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
        self.getProductListingFromCategoryIDAPIMethod(strkeywrod: self.txtsearchbar.text!)
        
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if arrMCategorywiseProductlist.count == 0 {
            self.colproductlist.setEmptyMessage(msg)
        } else {
            self.colproductlist.restore()
        }
        return arrMCategorywiseProductlist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellproductonly
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 8.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        
        let dict = arrMCategorywiseProductlist.object(at: indexPath.row)as? NSDictionary
        
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strname = String(format: "%@", dict!.value(forKey: "name") as? String ?? "")
        let strsku = String(format: "%@", dict!.value(forKey: "sku") as? String ?? "")
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        let strsize = String(format: "%@", dict!.value(forKey: "size") as? String ?? "")
        let strbrand = String(format: "%@", dict!.value(forKey: "brand") as? String ?? "")
        let strstatus = String(format: "%@", dict!.value(forKey: "productStatus") as? String ?? "")
        
        var strcurrent_currencecode = String(format: "%@", dict!.value(forKey: "current_currencecode") as? String ?? "")
        strcurrent_currencecode = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
        
        
        let arrmedia = dict!.value(forKey: "media")as? NSArray ?? []
        if arrmedia.count > 0 {
            let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")
            let strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
           
            cellA.imgvproduct.contentMode = .scaleAspectFit
            cellA.imgvproduct.imageFromURL(urlString: strFinalurl)
        }
        else{
            cellA.imgvproduct.contentMode = .scaleAspectFit
            cellA.imgvproduct.image = UIImage(named: "productplaceholder")
        }
        
        
        cellA.lblname.text = strname
        cellA.lblsku.text = strbrand
        
        print("strprice",strprice)
        if strprice != ""{
            let fltprice = Float(strprice)
            cellA.lblprice.text = String(format: "%@ %.2f",strcurrent_currencecode,fltprice!)
        }
        
        cellA.viewcell.backgroundColor = .white
        cellA.viewcell.layer.cornerRadius = 8.0
        cellA.viewcell.layer.masksToBounds = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = colproductlist.cellForItem(at: indexPath)as! colcellproductonly
        cell.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        let dict = arrMCategorywiseProductlist.object(at: indexPath.row)as? NSDictionary
        let strproductid = String(format: "%@", dict!.value(forKey: "id") as! CVarArg)
        let strname = String(format: "%@", dict!.value(forKey: "name") as? String ?? "")
        let strprice = String(format: "%@", dict!.value(forKey: "price") as? String ?? "")
        
        var strFinalurl = ""
        let arrmedia = dict!.value(forKey: "media")as? NSArray ?? []
        if arrmedia.count > 0 {
            let strimageurl = String(format: "%@", arrmedia.object(at: 0)as? String ?? "")
            strFinalurl = strimageurl.replacingOccurrences(of: " ", with: "%20")
            print("strFinalurl",strFinalurl)
        }
        
        
        print("strproductid",strproductid)
        print("strname",strname)
        print("strFinalurl",strFinalurl)
        print("strprice",strprice)
        
        print("strselecteddate",strselecteddate)
        print("strselectedday",strselectedday)
        print("strselecteddayname",strselecteddayname)
        print("strselectedsubscriptionplanid",strselectedsubscriptionplanid)
        
        
        //-------FETCH CHECK PRODUCTID SPEFICIC DATE IS AVAILABLE OR NOT-------//
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
        fetchData1.predicate = NSPredicate(format: "productid == %@ && date = %@", strproductid,strselecteddate)
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
                            
                            let intsubtotalprice = Float(strprice)! * 1
                            print("intsubtotalprice",intsubtotalprice)
                            
                            //------------------- INSERT INTO Dailyproduct TABLE ---------------- //
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                            let manageContent = appDelegate.persistentContainer.viewContext
                            let userEntity = NSEntityDescription.entity(forEntityName: "Renewmodelproduct", in: manageContent)!
                            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                            users.setValue(strselecteddate, forKeyPath: "date")
                            users.setValue(strselectedday, forKeyPath: "day")
                            users.setValue(strselecteddayname, forKeyPath: "dayname")
                            users.setValue(strproductid, forKeyPath: "productid")
                            users.setValue(strFinalurl, forKeyPath: "productimage")
                            users.setValue(strname, forKeyPath: "productname")
                            users.setValue(strprice, forKeyPath: "productprice")
                            users.setValue("0", forKeyPath: "qtyall")
                            users.setValue("1", forKeyPath: "qtyonce")
                            users.setValue(self.strselectedsubscriptionplanid, forKeyPath: "subscriptionid")
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
                
                let intsubtotalprice = Float(strprice)! * 1
                print("intsubtotalprice",intsubtotalprice)
                
                //------------------- INSERT INTO product TABLE ---------------- //
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent = appDelegate.persistentContainer.viewContext
                let userEntity = NSEntityDescription.entity(forEntityName: "Renewmodelproduct", in: manageContent)!
                let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
                users.setValue(strselecteddate, forKeyPath: "date")
                users.setValue(strselectedday, forKeyPath: "day")
                users.setValue(strselecteddayname, forKeyPath: "dayname")
                users.setValue(strproductid, forKeyPath: "productid")
                users.setValue(strFinalurl, forKeyPath: "productimage")
                users.setValue(strname, forKeyPath: "productname")
                users.setValue(strprice, forKeyPath: "productprice")
                users.setValue("0", forKeyPath: "qtyall")
                users.setValue("1", forKeyPath: "qtyonce")
                users.setValue(self.strselectedsubscriptionplanid, forKeyPath: "subscriptionid")
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
        
        self.navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
    
    //MARK: - get Product Listing From Category ID API method
    func getProductListingFromCategoryIDAPIMethod(strkeywrod:String)
    {
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if self.arrMCategorywiseProductlist.count > 0{
            self.arrMCategorywiseProductlist.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let strkeywrodfinal = strkeywrod.replacingOccurrences(of: " ", with: "%20")
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?categoryId=%@&product_name=%@&subCategoryId=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod10,"",strkeywrodfinal,"",strLangCode)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        if strbearertoken != ""{
            request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        }
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
                            let arrmproducts = json.value(forKey: "product") as? NSArray ?? []
                            self.arrMCategorywiseProductlist = NSMutableArray(array: arrmproducts)
                            //print("arrMCategorywiseProductlist --->",self.arrMCategorywiseProductlist)
                            
                            if self.arrMCategorywiseProductlist.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language150")
                            }
                            self.colproductlist.reloadData()
                            
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
