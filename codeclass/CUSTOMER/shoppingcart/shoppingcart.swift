//
//  shoppingcart.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/06/22.
//

import UIKit

class shoppingcart: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvcart: UITableView!
    var reuseIdentifier1 = "celltabvaddress"
    var reuseIdentifier2 = "celltabvdateslot"
    var reuseIdentifier3 = "celltabvitems"
    var msg = ""
    
    @IBOutlet weak var btnpaycheckout: UIButton!
    
    
    //ADD UPDATE ADDRESS
    @IBOutlet var viewaddresspopup: UIView!
    @IBOutlet weak var btncrossaddresspopup: UIButton!
    @IBOutlet weak var btnsaveaddresspopup: UIButton!
    @IBOutlet weak var btnaddnewaddresspopup: UIButton!
    @IBOutlet weak var viewaddressscrollpopup: UIView!
    @IBOutlet weak var scrolladdresspopup: UIScrollView!
    
    @IBOutlet var viewfirstname: UIView!
    @IBOutlet var txtfirstname: UITextField!
    @IBOutlet var viewlastname: UIView!
    @IBOutlet var txtlastname: UITextField!
    @IBOutlet var viewemailaddress: UIView!
    @IBOutlet var txtemailaddress: UITextField!
    @IBOutlet var viewmobileno: UIView!
    @IBOutlet var txtmobileno: UITextField!
    @IBOutlet var viewlocation: UIView!
    @IBOutlet var txtlocation: UITextField!
    @IBOutlet var viewcountry: UIView!
    @IBOutlet var txtcountry: UITextField!
    @IBOutlet var viewcity: UIView!
    @IBOutlet var txtcity: UITextField!
    @IBOutlet var viewstreetaddress: UIView!
    @IBOutlet var txtstreetaddress: UITextField!
    @IBOutlet var viewbuilding: UIView!
    @IBOutlet var txtbuilding: UITextField!
    
    var viewPopupAddNewExistingBG2 = UIView()
    
    
    //DELIVERY SLOTS DATE
    @IBOutlet var viewdateslotsdeliverypopup: UIView!
    @IBOutlet weak var txtsubsriptionplanpopup2: UITextField!
    @IBOutlet weak var txtsubscriptionstartdatepopup2: UITextField!
    @IBOutlet weak var txtsubscriptionenddatepopup2: UITextField!
    @IBOutlet weak var viewsubsriptionshippingchargepopup2: UIView!
    var viewPopupAddNewExistingBG3 = UIView()
    @IBOutlet weak var btncrossdateslotspopup: UIButton!
    @IBOutlet weak var btnsavedateslotspopup: UIButton!
    
    
    
    
    var arrMcartitems = NSMutableArray()

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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Cart"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnpaycheckout.layer.cornerRadius = 16.0
        btnpaycheckout.layer.masksToBounds = true
        
        tabvcart.register(UINib(nibName: "celltabvaddress", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvcart.register(UINib(nibName: "celltabvdateslot", bundle: nil), forCellReuseIdentifier: reuseIdentifier2)
        tabvcart.register(UINib(nibName: "celltabvitems", bundle: nil), forCellReuseIdentifier: reuseIdentifier3)
        tabvcart.separatorStyle = .none
        tabvcart.backgroundView=nil
        tabvcart.backgroundColor=UIColor.clear
        tabvcart.separatorColor=UIColor.clear
        tabvcart.showsVerticalScrollIndicator = false
        
        tabvcart.layer.masksToBounds = false
        tabvcart.layer.shadowColor = UIColor.white.withAlphaComponent(0.4).cgColor // any value you want
        tabvcart.layer.shadowOpacity = 1 // any value you want
        tabvcart.layer.shadowRadius = 100 // any value you want
        tabvcart.layer.shadowOffset = .init(width: 0, height: 10)
        
        arrMcartitems = ["1","2","3","4","5"]
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Pay&Checkout method
    @IBAction func presspaycheckout(_ sender: Any)
    {
        let ctrl = paymentmethod(nibName: "paymentmethod", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        return arrMcartitems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0{
            return 100
        }
        else if indexPath.section == 1{
            return 100
        }
        return 120
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0{
            return 64
        }
        else if section == 1{
            return 64
        }
        return 64
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if section == 2
        {
            return 110
        }
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if section == 0
        {
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 64)
            headerView.backgroundColor = UIColor.clear
            
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width, height: headerView.frame.self.height))
            title1.textAlignment = .left
            title1.textColor = UIColor.black
            title1.backgroundColor = .clear
            title1.font = UIFont (name: "NunitoSans-Bold", size: 14)
            title1.text = "Delivery Address"
            headerView.addSubview(title1)
            
            return headerView
        }
        else if section == 1
        {
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 64)
            headerView.backgroundColor = UIColor.clear
            
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width, height: headerView.frame.self.height))
            title1.textAlignment = .left
            title1.textColor = UIColor.black
            title1.backgroundColor = .clear
            title1.font = UIFont (name: "NunitoSans-Bold", size: 14)
            title1.text = "Delivery Date and Slots"
            headerView.addSubview(title1)
            
            return headerView
        }
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 64)
        headerView.backgroundColor = UIColor.clear
        
        let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width, height: headerView.frame.self.height))
        title1.textAlignment = .left
        title1.textColor = UIColor.black
        title1.backgroundColor = .clear
        title1.font = UIFont (name: "NunitoSans-Bold", size: 14)
        title1.text = "Cart Items"
        headerView.addSubview(title1)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if section == 2
        {
            let footerView = UIView()
            footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 120)
            footerView.backgroundColor = UIColor(named: "greenlighter")!
            
            //SUBTOTAL
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:footerView.frame.self.width / 2, height: 30))
            title1.textAlignment = .left
            title1.textColor = UIColor.black
            title1.backgroundColor = .clear
            title1.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title1.text = "  Cart Subtotal"
            footerView.addSubview(title1)
            
            let title1value = UILabel(frame: CGRect(x: title1.frame.maxX, y: 0, width:footerView.frame.self.width / 2, height: 30))
            title1value.textAlignment = .right
            title1value.textColor = UIColor.black
            title1value.backgroundColor = .clear
            title1value.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title1value.text = "AED 93.00"
            footerView.addSubview(title1value)
            
            //SHIPPING
            let title2 = UILabel(frame: CGRect(x: 0, y: title1.frame.maxY, width:footerView.frame.self.width / 2, height: 50))
            title2.textAlignment = .left
            title2.textColor = UIColor.black
            title2.backgroundColor = .clear
            title2.numberOfLines = 3
            title2.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title2.text = "  Shipping \n Flat Rate - Fixed"
            footerView.addSubview(title2)
            
            let title2value = UILabel(frame: CGRect(x: title2.frame.maxX, y: title1.frame.maxY, width:footerView.frame.self.width / 2, height: 50))
            title2value.textAlignment = .right
            title2value.textColor = UIColor.black
            title2value.backgroundColor = .clear
            title2value.font = UIFont (name: "NunitoSans-Regular", size: 16)
            title2value.text = "AED 10.00"
            footerView.addSubview(title2value)
            
            //GRANDTOTAL
            let title3 = UILabel(frame: CGRect(x: 0, y: title2.frame.maxY, width:footerView.frame.self.width / 2, height: 30))
            title3.textAlignment = .left
            title3.textColor = UIColor.black
            title3.backgroundColor = .clear
            title3.numberOfLines = 3
            title3.font = UIFont (name: "NunitoSans-Bold", size: 16)
            title3.text = "  Grand Total"
            footerView.addSubview(title3)
            
            let title3value = UILabel(frame: CGRect(x: title3.frame.maxX, y: title2.frame.maxY, width:footerView.frame.self.width / 2, height: 30))
            title3value.textAlignment = .right
            title3value.textColor = UIColor.black
            title3value.backgroundColor = .clear
            title3value.font = UIFont (name: "NunitoSans-Bold", size: 16)
            title3value.text = "AED 103.00"
            footerView.addSubview(title3value)
            
            return footerView
        }
        
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvaddress
            
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor = .clear
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            cell.btnupdate.layer.borderWidth = 1.0
            cell.btnupdate.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cell.btnupdate.layer.cornerRadius = 14.0
            cell.btnupdate.layer.masksToBounds = true
            
            cell.viewcell.layer.cornerRadius = 10.0
            cell.viewcell.layer.masksToBounds = true
            
            cell.btnupdate.addTarget(self, action: #selector(pressupdateaddress), for: .touchUpInside)
            
            return cell;
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as! celltabvdateslot
            
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor = .clear
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            cell.viewcell.layer.cornerRadius = 10.0
            cell.viewcell.layer.masksToBounds = true
            
            cell.btnedit.addTarget(self, action: #selector(presseditslotsdate), for: .touchUpInside)
            
            return cell;
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3, for: indexPath) as! celltabvitems
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 119.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor(named: "graybordercolor")!
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.layer.masksToBounds = true
    }
    
    //MARK: - Create Address PopUp Method
    @objc func pressupdateaddress(sender:UIButton)
    {
        createAddressPopup()
    }
    func createAddressPopup()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewaddresspopup.layer.cornerRadius = 6.0
        self.viewaddresspopup.layer.masksToBounds = true
        
        btnsaveaddresspopup.layer.cornerRadius = 18.0
        btnsaveaddresspopup.layer.masksToBounds = true
        
        btnaddnewaddresspopup.layer.borderWidth = 1.0
        btnaddnewaddresspopup.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnaddnewaddresspopup.layer.cornerRadius = 18.0
        btnaddnewaddresspopup.layer.masksToBounds = true
        
        viewfirstname.layer.borderWidth = 1.0
        viewfirstname.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewfirstname.layer.cornerRadius = 6.0
        viewfirstname.layer.masksToBounds = true
        
        viewlastname.layer.borderWidth = 1.0
        viewlastname.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewlastname.layer.cornerRadius = 6.0
        viewlastname.layer.masksToBounds = true
        
        viewemailaddress.layer.borderWidth = 1.0
        viewemailaddress.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewemailaddress.layer.cornerRadius = 6.0
        viewemailaddress.layer.masksToBounds = true
        
        viewmobileno.layer.borderWidth = 1.0
        viewmobileno.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewmobileno.layer.cornerRadius = 6.0
        viewmobileno.layer.masksToBounds = true
        
        viewlocation.layer.borderWidth = 1.0
        viewlocation.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewlocation.layer.cornerRadius = 6.0
        viewlocation.layer.masksToBounds = true
        
        viewcountry.layer.borderWidth = 1.0
        viewcountry.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcountry.layer.cornerRadius = 6.0
        viewcountry.layer.masksToBounds = true
        
        viewcity.layer.borderWidth = 1.0
        viewcity.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcity.layer.cornerRadius = 6.0
        viewcity.layer.masksToBounds = true
        
        viewstreetaddress.layer.borderWidth = 1.0
        viewstreetaddress.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewstreetaddress.layer.cornerRadius = 6.0
        viewstreetaddress.layer.masksToBounds = true
        
        viewbuilding.layer.borderWidth = 1.0
        viewbuilding.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewbuilding.layer.cornerRadius = 6.0
        viewbuilding.layer.masksToBounds = true
        
        
        self.scrolladdresspopup.backgroundColor = .clear
        self.scrolladdresspopup.showsVerticalScrollIndicator = false
        self.scrolladdresspopup.contentSize=CGSize(width: self.viewaddressscrollpopup.frame.size.width, height: 570)
        
        viewPopupAddNewExistingBG2 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG2.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG2.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG2.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG2.addSubview(self.viewaddresspopup)
        self.viewaddresspopup.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG2)
    }
    @IBAction func presscrossaddresspopup(_ sender: Any) {
        
        self.viewaddresspopup.removeFromSuperview()
        viewPopupAddNewExistingBG2.removeFromSuperview()
    }
    @IBAction func presssaveaddresspopup(_ sender: Any) {
    }
    @IBAction func pressaddnewaddresspopup(_ sender: Any) {
    }
    
    
    
    
    //MARK: - Create Date slots PopUp Method
    @objc func presseditslotsdate(sender:UIButton)
    {
        createDateslotsPopup()
    }
    func createDateslotsPopup()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewdateslotsdeliverypopup.layer.cornerRadius = 6.0
        self.viewdateslotsdeliverypopup.layer.masksToBounds = true
        
        self.scrolladdresspopup.backgroundColor = .clear
        self.scrolladdresspopup.showsVerticalScrollIndicator = false
        self.scrolladdresspopup.contentSize=CGSize(width: self.viewdateslotsdeliverypopup.frame.size.width, height: self.viewdateslotsdeliverypopup.frame.size.height)
        
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
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
}
