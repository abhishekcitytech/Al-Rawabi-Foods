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
        
        
        
        self.webcontent.uiDelegate = self
        self.webcontent.navigationDelegate = self
        self.webcontent.scrollView.minimumZoomScale = CGFloat(100)
        self.webcontent.scrollView.maximumZoomScale = CGFloat(500)
        self.webcontent.scrollView.zoomScale = CGFloat(100)
        
        
        
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
        
        let font = "<font size='21' color= 'black'>%@"
        let html = String(format: font, htmlString)
        webcontent.loadHTMLString(html, baseURL: nil)
    }
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!)
    {
        print("finish to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation)
    {
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
extension NSAttributedString {

    convenience init(htmlString html: String, font: UIFont? = nil, useDocumentFontSize: Bool = true) throws {
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
            return
        }

        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(.font, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)

                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitBold)!
                }

                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitItalic)!
                }

                attr.addAttribute(.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
            }
        }

        self.init(attributedString: attr)
    }

}
