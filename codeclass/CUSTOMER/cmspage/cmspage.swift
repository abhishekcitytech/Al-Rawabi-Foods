//
//  cmspage.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 23/12/22.
//

import UIKit
import WebKit

class cmspage: UIViewController,UIWebViewDelegate,WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate
{

    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var webcontent: WKWebView!
    
    var strPageUrl = String()
    var strPagename = String()
    var strcmsidentifier = String()
    
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
        
        if strcmsidentifier == "1001"
        {
            //About Us
            self.getCMSmethod(strmethodname: Constants.methodname.apimethod92)
        }
        else if strcmsidentifier == "1002"
        {
            //Privacy Policy
            self.getCMSmethod(strmethodname: Constants.methodname.apimethod93)
        }
        else if strcmsidentifier == "1003"
        {
            //Delivery Policy
            self.getCMSmethod(strmethodname: Constants.methodname.apimethod94)
        }
        else if strcmsidentifier == "1004"
        {
            //Refund/ Return & Cancellation
            self.getCMSmethod(strmethodname: Constants.methodname.apimethod95)
        }
        else if strcmsidentifier == "1005"
        {
            //Terms & Conditions
            self.getCMSmethod(strmethodname: Constants.methodname.apimethod96)
        }
        else if strcmsidentifier == "1006"
        {
            //Disclaimer
            self.getCMSmethod(strmethodname: Constants.methodname.apimethod97)
        }
        
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = strPagename
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        
        webcontent.uiDelegate = self
        webcontent.navigationDelegate = self
        
        
        
        
        //strPageUrl = "https://alrawabidairy.com/contact-us/"
        //let url = URL.init(string: strPageUrl) //URL (string: TNC)
        //let request = URLRequest(url: url!)
        //webcontent.load(request)
        //00306D
        
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: -  WkWebView Delegate Method
    func loadHTMLStringImage(strpagecontent:String)
    {
        let htmlString = strpagecontent
        webcontent.loadHTMLString(htmlString, baseURL: nil)
    }
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!)
    {
        print("finish to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation)
    {
        let contentSize:CGSize = self.webcontent.scrollView.contentSize
        let viewSize:CGSize = self.view.bounds.size
        let rw:Float = Float(viewSize.width / contentSize.width)
        print("rw",rw)
        self.webcontent.scrollView.minimumZoomScale = CGFloat(rw)
        self.webcontent.scrollView.maximumZoomScale = CGFloat(rw)
        self.webcontent.scrollView.zoomScale = CGFloat(rw)
    }
   
    
    //MARK: - get About Us API method
    func getCMSmethod(strmethodname:String)
    {
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        //let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        //print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?&language=%@", Constants.conn.ConnUrl, strmethodname,strLangCode)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        //request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
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
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let strpage_content = dictemp.value(forKey: "page_content")as? String ?? ""
                            print("strpage_content",strpage_content)
                            self.loadHTMLStringImage(strpagecontent: strpage_content)
                            
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
