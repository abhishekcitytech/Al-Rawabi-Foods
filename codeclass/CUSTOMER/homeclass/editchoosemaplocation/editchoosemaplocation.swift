//
//  editchoosemaplocation.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/01/23.
//

import UIKit

import Alamofire
import MapKit
import CoreLocation

import GoogleMaps
import GooglePlaces
import GoogleMapsCore
import GoogleMapsUtils

import Nominatim

class MyPointAnnotation1 : MKPointAnnotation {
    var pinTintColor: UIColor?
    var image: UIImage?
}

class editchoosemaplocation: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var viewoverall: UIView!
    
    
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var btncross: UIButton!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var lblalertstatus: UILabel!
    @IBOutlet weak var btnConfirmLocation: UIButton!
    
    var locationManager = CLLocationManager()
    var circle: MKOverlay?
    
    let ENTERED_REGION_MESSAGE = "Inside Geo fence area."
    let EXITED_REGION_MESSAGE = "Outside Geo fence area."
    
    class LocationModel
    {
        var name:String!
        var lat:Double!
        var long:Double!
        var radious:Double!
    }
    
    var ary : [LocationModel] = []
    var arrMGList = NSMutableArray()
    
    var strcurrentlat = ""
    var strcurrentlong = ""
    
    var arrMautocompletesearch = NSMutableArray()
    
    
    var isBoolDropdown = Bool()
    let cellReuseIdentifier = "cell"
    var tblViewDropdownList: UITableView? = UITableView()
    var arrMGlobalDropdownFeed = NSMutableArray()
    
    var strSelectedplacename = ""
    var strSelectedplaceid = ""
    
    var strsearchlat = Double()
    var strsearchlng = Double()
    
    var polyg1 = MKPolygon()
    var polyg2 = MKPolygon()
    
    var boolcheck = false
    
    var arrmPolygonlist = NSMutableArray()
    var arrmpolygonobject = NSMutableArray()
    
    var strFrompageMap = ""
    
    var strlocationname = ""
    var strcityname = ""
    
    var strSelectedRowAddress = ""

    // MARK: - viewWillDisappear Method
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        //self.txtsearch.text = "Al Karama,Dubai"
        //self.txtsearch.text = "Dubai Investments Park"
        //self.txtsearch.text = "Media One Hotel,Dubai"
        //self.txtsearch.text = "Jebel Ali Village,Dubai"
        
        //self.txtsearch.text = "Dubai Internet City"
        //self.txtsearch.text = "JLT - Dubai - United Arab Emirates"
        
        //self.getboundariescoordinates(strseachtext: self.txtsearch.text!)
        
        if txtsearch.text == ""
        {
            self.btnConfirmLocation.backgroundColor = UIColor.lightGray
            self.btnConfirmLocation.titleLabel?.textColor = UIColor.black
            self.btnConfirmLocation.isUserInteractionEnabled = false
        }
        
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = myAppDelegate.changeLanguage(key: "msg_language258")
        
        self.lblalertstatus.text = ""
        self.lblalertstatus.isHidden = true
        self.lblalertstatus.layer.cornerRadius = 8.0
        self.lblalertstatus.layer.masksToBounds = true
        
        self.btnConfirmLocation.layer.cornerRadius = 12.0
        self.btnConfirmLocation.layer.masksToBounds = true
        
        self.txtsearch.placeholder = myAppDelegate.changeLanguage(key: "msg_language259")
        btnConfirmLocation.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language256")), for: .normal)
        
       
        //self.btnsearch.isHidden = true
        
        self.mapview.delegate = self
        self.mapview.showsUserLocation = true
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
        }
        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        //locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.activityType = .otherNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        self.mapview.mapType = .standard
        
        //self.setUpGeofenceForPlayaGrandeBeachMultiple()
        self.addPolygonZoneArea()
        
        self.createMultiPolygon()
        
    }
    
    //MARK: - Add All Polygon Zone Area Method
    func addPolygonZoneArea()
    {
        let dict1 = NSMutableDictionary()
        dict1.setValue("JLT Dubai", forKey: "name")
        let arrm1 = NSMutableArray()
        arrm1.add(String(format: "%@", "25.060434, 55.137123"))
        arrm1.add(String(format: "%@", "25.069423, 55.146558"))
        arrm1.add(String(format: "%@", "25.070085, 55.146663"))
        arrm1.add(String(format: "%@", "25.072293, 55.144330"))
        arrm1.add(String(format: "%@", "25.076550, 55.148299"))
        arrm1.add(String(format: "%@", "25.075951, 55.149378"))
        arrm1.add(String(format: "%@", "25.078505, 55.156899"))
        arrm1.add(String(format: "%@", "25.081168, 55.154189"))
        arrm1.add(String(format: "%@", "25.081480, 55.149907"))
        arrm1.add(String(format: "%@", "25.076452, 55.143786"))
        arrm1.add(String(format: "%@", "25.072730, 55.140333"))
        arrm1.add(String(format: "%@", "25.068414, 55.136748"))
        arrm1.add(String(format: "%@", "25.064652, 55.136311"))
        arrm1.add(String(format: "%@", "25.060533, 55.137054"))
        dict1.setValue(arrm1, forKey: "coordinates")
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("Dubai Internet City", forKey: "name")
        let arrm2 = NSMutableArray()
        arrm2.add(String(format: "%@", "25.089044, 55.152976"))
        arrm2.add(String(format: "%@", "25.090310, 55.154730"))
        arrm2.add(String(format: "%@", "25.088804, 55.156203"))
        arrm2.add(String(format: "%@", "25.090896, 55.158728"))
        arrm2.add(String(format: "%@", "25.092057, 55.159706"))
        arrm2.add(String(format: "%@", "25.092333, 55.160226"))
        arrm2.add(String(format: "%@", "25.097117, 55.165989"))
        arrm2.add(String(format: "%@", "25.102277, 55.172210"))
        arrm2.add(String(format: "%@", "25.103539, 55.171471"))
        arrm2.add(String(format: "%@", "25.103927, 55.171719"))
        arrm2.add(String(format: "%@", "25.102512, 55.170457"))
        arrm2.add(String(format: "%@", "25.102154, 55.170484"))
        arrm2.add(String(format: "%@", "25.099925, 55.167756"))
        arrm2.add(String(format: "%@", "25.100210, 55.167142"))
        arrm2.add(String(format: "%@", "25.100752, 55.167032"))
        arrm2.add(String(format: "%@", "25.101764, 55.167378"))
        arrm2.add(String(format: "%@", "25.102691, 55.167174"))
        arrm2.add(String(format: "%@", "25.104602, 55.167332"))
        arrm2.add(String(format: "%@", "25.104209, 55.168576"))
        arrm2.add(String(format: "%@", "25.106007, 55.170437"))
        arrm2.add(String(format: "%@", "25.106809, 55.169573"))
        arrm2.add(String(format: "%@", "25.104688, 55.167153"))
        arrm2.add(String(format: "%@", "25.104874, 55.165944"))
        arrm2.add(String(format: "%@", "25.102765, 55.165609"))
        arrm2.add(String(format: "%@", "25.102505, 55.164689"))
        arrm2.add(String(format: "%@", "25.103144, 55.164247"))
        arrm2.add(String(format: "%@", "25.102267, 55.162742"))
        arrm2.add(String(format: "%@", "25.101575, 55.163578"))
        arrm2.add(String(format: "%@", "25.100586, 55.162966"))
        arrm2.add(String(format: "%@", "25.097416, 55.162147"))
        arrm2.add(String(format: "%@", "25.096885, 55.161819"))
        arrm2.add(String(format: "%@", "25.096255, 55.160881"))
        arrm2.add(String(format: "%@", "25.096000, 55.159060"))
        arrm2.add(String(format: "%@", "25.094896, 55.157238"))
        arrm2.add(String(format: "%@", "25.094284, 55.156551"))
        arrm2.add(String(format: "%@", "25.092515, 55.158430"))
        arrm2.add(String(format: "%@", "25.091927, 55.157633"))
        arrm2.add(String(format: "%@", "25.093538, 55.155932"))
        arrm2.add(String(format: "%@", "25.093316, 55.155518"))
        arrm2.add(String(format: "%@", "25.090705, 55.152697"))
        arrm2.add(String(format: "%@", "25.089887, 55.151953"))
        arrm2.add(String(format: "%@", "25.089429, 55.152449"))
        arrm2.add(String(format: "%@", "25.089024, 55.152970"))
        dict2.setValue(arrm2, forKey: "coordinates")
        
        
        let dict3 = NSMutableDictionary()
        dict3.setValue("Al Khawaneej", forKey: "name")
        let arrm3 = NSMutableArray()
        arrm3.add(String(format: "%@", "25.267297, 55.471900"))
        arrm3.add(String(format: "%@", "25.253270, 55.511848"))
        arrm3.add(String(format: "%@", "25.234973, 55.563339"))
        arrm3.add(String(format: "%@", "25.212336, 55.552654"))
        arrm3.add(String(format: "%@", "25.191936, 55.532475"))
        arrm3.add(String(format: "%@", "25.193568, 55.526613"))
        arrm3.add(String(format: "%@", "25.198362, 55.521766"))
        arrm3.add(String(format: "%@", "25.212336, 55.508689"))
        arrm3.add(String(format: "%@", "25.222844, 55.503526"))
        arrm3.add(String(format: "%@", "25.226087, 55.482496"))
        arrm3.add(String(format: "%@", "25.228755, 55.464619"))
        arrm3.add(String(format: "%@", "25.249593, 55.468673"))
        arrm3.add(String(format: "%@", "25.255094, 55.468673"))
        arrm3.add(String(format: "%@", "25.267283, 55.471931"))
        dict3.setValue(arrm3, forKey: "coordinates")
        
        arrmPolygonlist.add(dict1)
        arrmPolygonlist.add(dict2)
        arrmPolygonlist.add(dict3)
        
        print("arrmPolygonlist",arrmPolygonlist)
    }
    
    //MARK: - create multi Polygon from Arraylist Method
    func createMultiPolygon()
    {
        for x in 0 ..< arrmPolygonlist.count
        {
            let dictemp = arrmPolygonlist.object(at: x)as? NSMutableDictionary
            let strname = String(format: "%@", dictemp?.value(forKey: "name")as? String ?? "")
            print("strname",strname)
            let arrm = dictemp?.value(forKey: "coordinates")as? NSMutableArray
            
            var polygon = MKPolygon()
            var coordinateArray: [CLLocationCoordinate2D] = []
            
            for xx in 0 ..< arrm!.count
            {
                let strcoordinate = String(format: "%@", arrm?.object(at: xx)as? String ?? "")
                
                let items = strcoordinate.components(separatedBy: ", ")
                let str1 = items[0]
                let str2 = items[1]
                
                let point = CLLocationCoordinate2DMake(Double(str1)!,Double(str2)!)
                coordinateArray.append(point)
            }
            polygon = MKPolygon(coordinates:&coordinateArray, count:arrm!.count)
            arrmpolygonobject.add(polygon)
            self.mapview.addOverlay(polygon)
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
        if let text = txtsearch.text,
        let textRange = Range(range, in: text)
        {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            
            print("updatedText",updatedText)
            
            if updatedText.count >= 5 {
                print("Call the Search Autocomplete Function")
                self.googlePlacesResult(input: updatedText)
            }
            else{
                
                if updatedText.count == 0
                {
                    self.handleTap1()
                }
                return true
            }
        }
        
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
    
    //MARK: - Google autocomplete place API request
    func googlePlacesResult(input: String)
    {
        //let searchWordProtection = input.replacingOccurrences(of: " ", with: "");
        
        let currentLocationLatitude1 = String(format: "%@", self.strcurrentlat)
        let currentLocationLongtitude1 = String(format: "%@", self.strcurrentlong)
        print("lat------",currentLocationLatitude1)
        print("lat------",currentLocationLongtitude1)
        
        //25.0709434,55.1287182 - JLT DUBAI
        
        let urlString = NSString(format: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=establishment|geocode&location=%@,%@&radius=20000&language=en&key=AIzaSyBJAhGdm5k7WgmHUkWX_4w5DY0uA88e4Hk",input,"\(25.0709434)","\(55.1287182)")
        print(urlString)
        
        let url = NSURL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
        print(url!)
        let defaultConfigObject = URLSessionConfiguration.default
        let delegateFreeSession = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
        let request = NSURLRequest(url: url! as URL)
        let task =  delegateFreeSession.dataTask(with: request as URLRequest, completionHandler:{(data, response, error) -> Void in
            if let data = data
            {
                do {
                    let jSONresult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let results:NSArray = jSONresult["predictions"] as! NSArray
                    let status = jSONresult["status"] as! String
                    print("results",results)
                    print("status",status)
                    
                    if status == "NOT_FOUND" || status == "REQUEST_DENIED"
                    {
                        //let userInfo:NSDictionary = ["error": jSONresult["status"]!]
                        //let newError = NSError(domain: "API Error", code: 666, userInfo: userInfo as [NSObject : AnyObject])
                        //let arr:NSArray = [newError]
                        //print("arr",arr)
                        //return
                        
                        if self.arrMautocompletesearch.count > 0{
                            self.arrMautocompletesearch.removeAllObjects()
                        }
                        self.handleTap1()
                        
                        let uiAlert = UIAlertController(title: "", message: "Address not found, please try again later", preferredStyle: UIAlertController.Style.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                    }
                    else
                    {
                        print("results",results)
                        
                        if self.arrMautocompletesearch.count > 0{
                            self.arrMautocompletesearch.removeAllObjects()
                        }
                        
                        let aarrm1 = NSMutableArray(array: results)
                        self.arrMautocompletesearch = aarrm1
                        print("arrMMyExpenselist >>",self.arrMautocompletesearch)
                        
                        if self.arrMautocompletesearch.count > 0
                        {
                            if self.isBoolDropdown == true {
                                self.handleTap1()
                            }else{
                                self.popupDropdown(arrFeed: self.arrMautocompletesearch, txtfld: self.txtsearch, tagTable: 100)
                            }
                        }
                        else
                        {
                            let uiAlert = UIAlertController(title: "", message: "Address not found, please try again later", preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
                catch
                {
                    print("json error: \(error)")
                    
                    if self.arrMautocompletesearch.count > 0{
                        self.arrMautocompletesearch.removeAllObjects()
                    }
                    self.handleTap1()
                }
            }
            else if let error = error
            {
                print(error)
                
                if self.arrMautocompletesearch.count > 0{
                    self.arrMautocompletesearch.removeAllObjects()
                }
                self.handleTap1()
            }
        })
        task.resume()
    }
    
    //MARK: - get Boundaries polygon method
    @objc func getboundariescoordinates(strseachtext:String)
    {
        //https://nominatim.openstreetmap.org/search.php?q=Warsaw+Poland&polygon_geojson=1&format=json
        
        /*var strconnurl = strseachtext
         strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
         print("strconnurl",strconnurl)
         
         Nominatim.getLocation(fromAddress: strconnurl, completion: {(error) -> Void in
         print("Geolocation of the Royal Palace of Stockholm:")
         print("lat = " + (location?.latitude)! + "   lon = " + (location?.longitude)!)
         })*/
        
        /*var strconnurl = String(format: "https://nominatim.openstreetmap.org/search.php?q=%@&polygon_geojson=1&format=json", strseachtext)
         strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
         print("strconnurl",strconnurl)
         let url = URL(string: strconnurl)!
         
         let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
         let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
         let array = jsonResult as? Array<Dictionary<String, Any>>
         print("array",array)
         }
         task.resume()*/
        
        var strconnurl = String(format: "https://nominatim.openstreetmap.org/search.php?q=%@&polygon_geojson=1&format=json", strseachtext)
        strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
        print("strconnurl",strconnurl)
        AF.request(strconnurl,method: .get,encoding: JSONEncoding.default).responseJSON {
            response in
            //print(response.result)
            
            switch response.result{
            case .success(let JSON):
                
                print("Success with JSON: \(String(describing: JSON))")
                
                let array = JSON as? NSArray
                print("array",array as Any)
                
                //let dic = JSON as? NSDictionary
                //print("dic",dic as Any)
                
                break
            case .failure:
                print("failure")
            }
        }
    }
    
    //MARK: - press cross method
    @IBAction func pressCross(_ sender: Any)
    {
        //REMOVE ANNOTATION PIN
        self.removeAppleMapOverlays()
        
        //RECREATE POLYGON AGAIN AFTER CLEAR MAPVIEW ANNOTATION PIN
        self.createMultiPolygon()
        //self.drawpolygon1()
        //self.drawpolygon2()
        
        self.txtsearch.text = ""
        self.txtsearch.becomeFirstResponder()
    }
    
    //MARK: - remove all annotations method
    func removeAppleMapOverlays()
    {
        let overlays = self.mapview.overlays
        self.mapview.removeOverlays(overlays)
        let annotations = self.mapview.annotations.filter {
            $0 !== self.mapview.userLocation
        }
        self.mapview.removeAnnotations(annotations)
    }
    
    //MARK: -  press Search method
    @IBAction func pressSearch(_ sender: Any)
    {
        let address = String(format: "%@", txtsearch.text!)
        print("address",address)
        
        self.performGoogleSearch(for: address)
        
        /*getLocation(from: address) { location in
         print("Location is", location.debugDescription)
         // Location is Optional(__C.CLLocationCoordinate2D(latitude: 39.799372, longitude: -89.644458))
         
         print(location!.latitude) // result 39.799372
         print(location!.longitude) // result -89.64445
         
         var latdouble = Double()
         var longdouble = Double()
         latdouble = (location?.latitude)!
         longdouble = (location?.longitude)!
         self.checkdistanceradiousZone(lat: latdouble, lng: longdouble)
         }*/
    }
    
    
    //MARK: - check Distance from Radius ZONE Coordinate method
    @objc func checkdistanceradiousZone(lat:Double,lng:Double)
    {
        var latdouble = Double()
        var longdouble = Double()
        latdouble = lat
        longdouble = lng
        
        for x in 0 ..< arrMGList.count
        {
            let newString = String(format: "%@", arrMGList.object(at: x) as? String ?? "")
            let strValue = newString.replacingOccurrences(of: " ", with: "")
            
            let items = strValue.split(separator: ",")
            let str1 = String(items.first!)
            let str2 = String(items.last!)
            let latdouble1 = Double(str1)!
            let longdouble1 = Double(str2)!
            print("latdouble111",latdouble1 as Any)
            print("longdouble111",longdouble1 as Any)
            
            let coordinate1 = CLLocation(latitude: latdouble, longitude: longdouble)
            let coordinate2 = CLLocation(latitude: latdouble1, longitude: longdouble1)
            
            //print("coordinate1",coordinate1)
            //print("coordinate2",coordinate2)
            
            let distanceInMeters = coordinate1.distance(from: coordinate2)
            print("distanceInMeters",distanceInMeters)
            
            if(distanceInMeters <= 1800)
            {
                print("under 1800 meter")
                boolcheck = true
                
            }
            else
            {
                print("away 1800 meter")
                //boolcheck = false
            }
        }
        
        self.alertViewFunction()
        
    }
    
    //MARK: - alert View Checking Method
    func alertViewFunction()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        //ALERT VIEW CHECKING
        if boolcheck == true{
            
            DispatchQueue.main.async {
                
                /*let alert = UIAlertController(title: "Alert", message: "You are inside our delivery area!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    self.boolcheck = false
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)*/
                
                self.lblalertstatus.isHidden = false
                self.lblalertstatus.backgroundColor = .blue
                self.lblalertstatus.text = myAppDelegate.changeLanguage(key: "msg_language262")
                self.boolcheck = false
                
                self.btnConfirmLocation.backgroundColor = UIColor(named: "greencolor")!
                self.btnConfirmLocation.titleLabel?.textColor = UIColor.white
                self.btnConfirmLocation.isUserInteractionEnabled = true
            }
        }
        else
        {
            DispatchQueue.main.async {
                
                /*let alert = UIAlertController(title: "Alert", message: "We do not deliver to this area!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    self.boolcheck = false
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)*/
                
                self.lblalertstatus.isHidden = false
                self.lblalertstatus.backgroundColor = .red
                self.lblalertstatus.text = myAppDelegate.changeLanguage(key: "msg_language263")
                self.boolcheck = false
                
                self.btnConfirmLocation.backgroundColor = UIColor.lightGray
                self.btnConfirmLocation.titleLabel?.textColor = UIColor.black
                self.btnConfirmLocation.isUserInteractionEnabled = false
            }
        }
    }
    
    
    
    //MARK: - Multiple feofence method
    func setUpGeofenceForPlayaGrandeBeachMultiple()
    {
        arrMGList = ["25.0709248,55.1379023","25.0918405,55.1572275"]
        
        for x in 0 ..< arrMGList.count
        {
            let newString = String(format: "%@", arrMGList.object(at: x) as? String ?? "")
            let strValue = newString.replacingOccurrences(of: " ", with: "")
            
            let items = strValue.split(separator: ",")
            let str1 = String(items.first!)
            let str2 = String(items.last!)
            let latdouble = Double(str1)!
            let longdouble = Double(str2)!
            print("latdouble",latdouble as Any)
            print("longdouble",longdouble as Any)
            
            let locationModel = LocationModel()
            if x == 0{
                locationModel.name = "JLT - Dubai - United Arab Emirates"
            }else if x == 1{
                locationModel.name = "Dubai Internet City - Dubai - United Arab Emirates"
            }
            locationModel.lat = latdouble
            locationModel.long = longdouble
            locationModel.radious = 1800
            
            ary.append(locationModel)
            
        }
        print("ary count",ary.count)
        
        
        for mdl in ary {
            
            let geofenceRegionCenter = CLLocationCoordinate2DMake(mdl.lat, mdl.long);
            let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: mdl.radious, identifier: mdl.name);
            geofenceRegion.notifyOnExit = true;
            geofenceRegion.notifyOnEntry = true;
            
            let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
            let mapRegion = MKCoordinateRegion(center: geofenceRegionCenter, span: span)
            self.mapview.setRegion(mapRegion, animated: true)
            
            let regionCircle = MKCircle(center: geofenceRegionCenter, radius: mdl.radious)
            self.mapview.addOverlay(regionCircle)
            
            // Drop a pin at geofence location
            /*let hello = MyPointAnnotation1()
            hello.coordinate = CLLocationCoordinate2D(latitude: mdl.lat, longitude: mdl.long)
            hello.pinTintColor = .blue
            hello.image = UIImage(named: "pinblue1")
            self.mapview.addAnnotation(hello)*/
            
            self.mapview.showsUserLocation = false;
            //locationManager.startMonitoring(for: geofenceRegion)
        }
        
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: - CLLocationManager Authorization Delegate method
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.authorizedAlways)
        {
            print("authorizedAlways")
            
            self.setUpGeofenceForPlayaGrandeBeachMultiple()
        }
        else if (status == CLAuthorizationStatus.authorizedWhenInUse)
        {
            print("authorizedWhenInUse")
            
            self.setUpGeofenceForPlayaGrandeBeachMultiple()
        }
        else
        {
            print("denied")
        }
    }
    func locationManager(_ manager: CLLocationManager,didDetermineState state: CLRegionState,for region: CLRegion)
    {
        if state == CLRegionState.inside {
            print("inside")
            self.enterGeofence(manager, geofence: region)
        }
        else if state == CLRegionState.outside {
            print("outside")
            self.exitGeofence(manager, geofence: region)
        }
        else if state == CLRegionState.unknown {
            print("unknown")
        }
        
    }
    
    
    //MARK: - CLLocationManager Geofence Delegate method
    func enterGeofence(_ manager: CLLocationManager, geofence:CLRegion)
    {
        //whatever is required when entered
        print(ENTERED_REGION_MESSAGE)
        //self.showAleart(msg: "You are inside of geofence area.")
        
        
        //let circleCenter = CLLocationCoordinate2DMake(doublelat, doublelong)//change to your center point
        //let circ = MKCircle(center: circleCenter, radius: 50)//radius in meters
        //self.mapView.addOverlay(circ)
        self.createCircle(location: manager.location!)
        
    }
    func exitGeofence(_ manager: CLLocationManager, geofence:CLRegion)
    {
        //whatever is required when entered
        print(EXITED_REGION_MESSAGE)
        //self.showAleart(msg: "You are outside of geofence area.")
        
        //let circleCenter = CLLocationCoordinate2DMake(doublelat, doublelong)//change to your center point
        //let circ = MKCircle(center: circleCenter, radius: 50)//radius in meters
        //self.mapView.addOverlay(circ)
        
        self.createCircle(location: manager.location!)
        
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion)
    {
        print("Started Monitoring Region: \(region.identifier)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.locationManager.requestState(for: region)
        }
        
        //self.locationManager .perform(#selector(requestState), with: region, afterDelay: 1)
        
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
    {
        print(ENTERED_REGION_MESSAGE)
        //print("ENTERED_REGION_MESSAGE",ENTERED_REGION_MESSAGE)
        
        print("latitde",manager.location?.coordinate.latitude as Any)
        print("longitude",manager.location?.coordinate.longitude as Any)
        
        //let circleCenter = CLLocationCoordinate2DMake(doublelat, doublelong)//change to your center point
        //let circ = MKCircle(center: circleCenter, radius: 50)//radius in meters
        //self.mapView.addOverlay(circ)
        
        self.createCircle(location: manager.location!)
        
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    {
        print(EXITED_REGION_MESSAGE)
        //print("EXITED_REGION_MESSAGE",EXITED_REGION_MESSAGE)
        //self.createLocalNotification(message: EXITED_REGION_MESSAGE, identifier: EXITED_REGION_NOTIFICATION_ID)
        
        //self.showAleart(msg: "You are outside of geofence area.")
        
        print("latitde",manager.location?.coordinate.latitude as Any)
        print("longitude",manager.location?.coordinate.longitude as Any)
        
        //let circleCenter = CLLocationCoordinate2DMake(doublelat, doublelong)//change to your center point
        //let circ = MKCircle(center: circleCenter, radius: 50)//radius in meters
        //self.mapView.addOverlay(circ)
        
        self.createCircle(location: manager.location!)
        
    }
    
    //MARK: - CLLocationManager did Update location changes delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("Current Location Updating...")
        
         var latdouble = Double()
         var longdouble = Double()
         latdouble = (manager.location?.coordinate.latitude)!
         longdouble = (manager.location?.coordinate.longitude)!
        
        self.strcurrentlat = String(format: "%0.10f", latdouble)
        self.strcurrentlong = String(format: "%0.10f", longdouble)
        print("self.strcurrentlat",self.strcurrentlat)
        print("self.strcurrentlong",self.strcurrentlong)
        
         /*self.checkdistanceradiousZone(lat: latdouble, lng: longdouble)*/
        
    }
    
    
    //MARK: - Mapview Annotation PIN  delegate method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        if annotation.isKind(of: MKUserLocation.self)
        {
            return nil
        }
        
        if (annotation is MyPointAnnotation1)
        {
            let reuseId = "Zone"
            var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.canShowCallout = true
                
                anView?.isDraggable = false

                let drag = UILongPressGestureRecognizer(target: self, action: #selector(handleDrag))
                drag.minimumPressDuration = 0 // set this to whatever you want
                anView?.addGestureRecognizer(drag)

            }else {
                anView!.annotation = annotation
            }
            
            
            
            let restaurantAnnotation = annotation as! MyPointAnnotation1
            print("restaurantAnnotation.image",restaurantAnnotation.pinTintColor as Any)
            
            if restaurantAnnotation.pinTintColor == .blue{
                print("Zone pin")
                anView!.image = UIImage(named: "pinblue1")
            }
            else
            {
                print("Search location selected pin")
                anView!.image = UIImage(named: "pingreen")
                
            }
            
            /*if (restaurantAnnotation.image != nil) {
                anView!.image = UIImage(named: "pinblue1")
            }else{
                // Perhaps set some default image
                //anView!.image = UIImage(named: "pingreen")
            }*/
            
            return anView
            
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
        annotationView.image = UIImage(named: "")
        return annotationView
    }
    
    
    
    //MARK: - Draggable PIN ANNOTATION LONG PRESS GESTURE METHOD
    private var startLocation = CGPoint.zero
    @objc func handleDrag(gesture: UILongPressGestureRecognizer)
    {
        let location = gesture.location(in: mapview)

        if gesture.state == .began
        {
            startLocation = location
        }
        else if gesture.state == .changed
        {
            gesture.view?.transform = CGAffineTransform(translationX: location.x - startLocation.x, y: location.y - startLocation.y)
        }
        else if gesture.state == .ended || gesture.state == .cancelled
        {
            let annotationView = gesture.view as! MKAnnotationView
            let annotation = annotationView.annotation as! MyPointAnnotation1

            let translate = CGPoint(x: location.x - startLocation.x, y: location.y - startLocation.y)
            let originalLocation = mapview.convert(annotation.coordinate, toPointTo: mapview)
            let updatedLocation = CGPoint(x: originalLocation.x + translate.x, y: originalLocation.y + translate.y)
            annotationView.transform = CGAffineTransform.identity
            annotation.coordinate = mapview.convert(updatedLocation, toCoordinateFrom: mapview)
            
            print("latitude",annotation.coordinate.latitude)
            print("longitude",annotation.coordinate.longitude)
            
            self.getAddressFromLatLong(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        }
    }
    /*func removeAppleMapOverlays()
     {
     let overlays = self.mapView.overlays
     self.mapView.removeOverlays(overlays)
     let annotations = self.mapView.annotations.filter {
     $0 !== self.mapView.userLocation
     }
     self.mapView.removeAnnotations(annotations)
     }*/
    
    //MARK:  - MKMapView Circle Delegate
    func createCircle(location: CLLocation)
    {
        self.removeCircle()
        self.circle = MKCircle(center: location.coordinate, radius: 1800 as CLLocationDistance)
        self.mapview.addOverlay(circle!)
    }
    func removeCircle()
    {
        if let circle = self.circle {
            self.mapview.removeOverlay(circle)
            self.circle = nil
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        
        var colorFill = UIColor()
        colorFill = UIColor(red: 237/255.0, green: 230/255.0, blue: 232/255.0, alpha: 0.2)
        
        // Get the all overlays from map view
        /*if let overlays = self.mapView?.overlays {
         for overlay in overlays {
         // remove all MKCircle-Overlays
         if overlay is MKCircleRenderer {
         self.mapView?.removeOverlay(overlay)
         }
         }
         }*/
        
        /*
         let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
         overlayRenderer.lineWidth = 1.0
         overlayRenderer.strokeColor = UIColor.lightText
         overlayRenderer.fillColor = colorFill
         return overlayRenderer*/
        
        if overlay is MKPolygon{
            
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.fillColor = UIColor.red.withAlphaComponent(0.3)
            renderer.strokeColor = UIColor.yellow
            renderer.lineWidth = 0.5
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    
    
    
    // MARK: - SearchAutocomplete List dropdown Method
    func popupDropdown(arrFeed:NSMutableArray,txtfld:UITextField, tagTable:Int)
    {
        let point = (txtfld.superview?.convert(txtfld.frame.origin, to: self.view))! as CGPoint
        print(point.y)
        
        isBoolDropdown = true
        tblViewDropdownList = UITableView(frame: CGRect(x: 0, y: point.y + self.txtsearch.frame.size.height + 4, width: self.viewoverall.frame.size.width, height: 0))
        tblViewDropdownList?.delegate = self
        tblViewDropdownList?.dataSource = self
        tblViewDropdownList?.tag = tagTable
        tblViewDropdownList?.backgroundView = nil
        tblViewDropdownList?.backgroundColor = UIColor.white
        tblViewDropdownList?.separatorColor = UIColor.clear
        self.view.addSubview(tblViewDropdownList!)
        
        arrMGlobalDropdownFeed = arrFeed
        
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewDropdownList?.frame)!
            frame.size.height =  UIScreen.main.bounds.size.height/2.0-64
            self.tblViewDropdownList?.frame = frame
            //print(self.tblViewDropdownList?.frame as Any)
        }, completion: nil)
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMGlobalDropdownFeed.count
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let title1 = UILabel(frame: CGRect(x: 15, y: 0, width:  (tblViewDropdownList?.frame.size.width)! - 15, height: 40))
        title1.textAlignment = .left
        title1.textColor = UIColor.black
        title1.backgroundColor = UIColor.clear
        title1.font = UIFont.systemFont(ofSize: 14)
        cell.contentView.addSubview(title1)
      
        let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
        
        let  str1 = String(format: "%@", dictemp.value(forKey: "description") as? String ?? "")
        //let  str2 = String(format: "%@", dictemp.value(forKey: "place_id") as? String ?? "")
        
        title1.text = String(format: "%@",str1) as String
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 39, width: tableView.frame.size.width, height: 1))
        lblSeparator.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
        let  str1 = String(format: "%@", dictemp.value(forKey: "description") as? String ?? "")
        let  str2 = String(format: "%@", dictemp.value(forKey: "place_id") as? String ?? "")
        
        self.strSelectedplacename = str1
        self.strSelectedplaceid = str2
        
        if self.txtsearch.text!.count > 0{
            self.txtsearch.text = ""
        }
        self.txtsearch.text = str1
        
        //self.btnsearch.isHidden = true
        self.txtsearch.resignFirstResponder()
        
        self.handleTap1()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performGoogleSearchPlaceID(strplaceid: self.strSelectedplaceid)
        }
    }
    func handleTap1()
    {
        isBoolDropdown = false
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewDropdownList?.frame)!
            frame.size.height = 0
            self.tblViewDropdownList?.frame = frame
        }, completion: { (nil) in
            self.tblViewDropdownList?.removeFromSuperview()
            self.tblViewDropdownList = nil
        })
    }
    
    //MARK: - redirect popup page
    @objc func redirectPopPreviousPage(straddress:String,strlocation:String,strcity:String,strcountry:String)
    {
        if strFrompageMap == "addnewaddress"
        {
            print("From Page --> ADD NEW ADDRESS")
            
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
               if controller.isKind(of: addnewaddress.self) {
                  let tabVC = controller as! addnewaddress
                   tabVC.strstreetaddressfrommap = String(format: "%@", straddress)
                   tabVC.strstreetaddressfrommapLocation = strlocation
                   tabVC.strstreetaddressfrommapCity = strcity
                  self.navigationController?.popToViewController(tabVC, animated: true)
               }
            }
        }
        else if strFrompageMap == "updatemyaddress"
        {
            print("From Page --> UPDATE ADDRESS")
            
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
               if controller.isKind(of: updatemyaddress.self) {
                  let tabVC = controller as! updatemyaddress
                   tabVC.strstreetaddressfrommap = String(format: "%@", straddress)
                   tabVC.strstreetaddressfrommapLocation = strlocation
                   tabVC.strstreetaddressfrommapCity = strcity
                  self.navigationController?.popToViewController(tabVC, animated: true)
               }
            }
        }
        else if strFrompageMap == "subscriptionorderreview"
        {
            print("From Page --> SUBSCRIPTION ORDER REVIEW")
            
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
               if controller.isKind(of: subscriptionorderreview.self) {
                  let tabVC = controller as! subscriptionorderreview
                   tabVC.strFulladdress = String(format: "%@", straddress)
                   tabVC.strFulladdressLocationname = strlocation
                   tabVC.strFulladdressCityname = strcity
                  self.navigationController?.popToViewController(tabVC, animated: true)
               }
            }
        }
        else if strFrompageMap == "orderonceclass"
        {
            print("From Page --> ORDER ONCE TAB PAGE")
            
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
               if controller.isKind(of: orderonceclass.self) {
                  let tabVC = controller as! orderonceclass
                   tabVC.strstreetaddressfrommapORDERONCE = String(format: "%@", straddress)
                   tabVC.strstreetaddressfrommapLocationORDERONCE = strlocation
                   tabVC.strstreetaddressfrommapCityORDERONCE = strcity
                  self.navigationController?.popToViewController(tabVC, animated: true)
               }
            }
        }
        else if strFrompageMap == "subsriptionclass"
        {
            print("From Page --> SUBSCRIPTION TAB PAGE")
            
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
               if controller.isKind(of: subsriptionclass.self) {
                  let tabVC = controller as! subsriptionclass
                   tabVC.strstreetaddressfrommapSUBSCRIPTION = String(format: "%@", straddress)
                   tabVC.strstreetaddressfrommapLocationSUBSCRIPTION = strlocation
                   tabVC.strstreetaddressfrommapCitySUBSCRIPTION = strcity
                  self.navigationController?.popToViewController(tabVC, animated: true)
               }
            }
        }
    }
    
    //MARK: -  GET Lat Long by PlaceID - Google API
    func  performGoogleSearchPlaceID(strplaceid:String)
    {
        //https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJ5Rw5v9dCXz4R3SUtcL5ZLMk&key=AIzaSyBJAhGdm5k7WgmHUkWX_4w5DY0uA88e4Hk
        
        var strconnurl = String(format: "https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyBJAhGdm5k7WgmHUkWX_4w5DY0uA88e4Hk", strplaceid)
        strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
        print("strconnurl",strconnurl)
        AF.request(strconnurl,method: .get,encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            
            switch response.result{
            case .success(let JSON):
                
                //print("Success with JSON: \(String(describing: JSON))")
                
                //let array = JSON as? NSArray
                //print("array",array)
                
                let dic = JSON as? NSDictionary
                //print("dic",dic as Any)
                
                let dic1 = dic?.value(forKey: "result") as? NSDictionary
                print("dic1",dic1 as Any)
                
                let dic2 = dic1?.value(forKey: "geometry") as? NSDictionary
                let dic3 = dic2?.value(forKey: "location") as? NSDictionary
                
                //FIXME_____ FETCH CITY AND LOCATION NAME ______//
                let arraddress_components = dic1?.value(forKey: "address_components")as! NSArray
                for xx in 0 ..< arraddress_components.count
                {
                    let dicaddress = arraddress_components.object(at: xx)as! NSDictionary
                    let strlong_name = String(format: "%@", dicaddress.value(forKey: "long_name")as? String ?? "")
                    
                    let arrmtypes = dicaddress.value(forKey: "types")as! NSArray
                    for yy in 0 ..< arrmtypes.count
                    {
                        let strtype = String(format: "%@", arrmtypes.object(at: yy)as? String ?? "")
                        if strtype == "sublocality" || strtype == "neighborhood" || strtype == "sublocality_level_1"
                        {
                            //THEN FETCH LOCATION NAME
                            print("strlong_name1",strlong_name)
                            //self.strlocationname = strlong_name
                        }
                        
                        if strtype == "administrative_area_level_1"
                        {
                            //THEN FETCH REGION NAME
                            print("strlong_name2",strlong_name)
                            self.strlocationname = strlong_name
                        }
                        
                        if strtype == "locality"
                        {
                            //THEN FETCH CITY NAME
                            print("strlong_name3",strlong_name)
                            self.strcityname = strlong_name
                        }
                    }
                }
                
                let strformatted_address =  String(format: "%@", dic1?.value(forKey: "formatted_address")as? String ?? "")
                print("strformatted_address Fetch",strformatted_address)
                
                print("location name",self.strlocationname)
                print("city name",self.strcityname)
                
                
                
                let strlatselected = String(format: "%@", dic3?.value(forKey: "lat")as! CVarArg)
                let strlngselected = String(format: "%@", dic3?.value(forKey: "lng")as! CVarArg)
                print("strlatselected",strlatselected)
                print("strlngselected",strlngselected)
                
                DispatchQueue.main.async {
                    
                    self.strsearchlat = Double(strlatselected)!
                    self.strsearchlng = Double(strlngselected)!
                    print("strsearchlat",self.strsearchlat)
                    print("strsearchlng",self.strsearchlng)
                    
                    if self.txtsearch.text!.count > 0{
                        self.txtsearch.text = ""
                    }
                    self.txtsearch.text = strformatted_address
                    
                    // Drop a pin at searched location
                    let hello = MyPointAnnotation1()
                    hello.coordinate = CLLocationCoordinate2D(latitude: self.strsearchlat, longitude: self.strsearchlng)
                    hello.pinTintColor = .green
                    hello.image = UIImage(named: "pingreen")
                    hello.title = "My Delivery Location"
                    self.mapview.addAnnotation(hello)
                    
                    self.mapview.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.strsearchlat, longitude: self.strsearchlng), latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)

                    
                    //self.checkdistanceradiousZone(lat: self.strsearchlat, lng: self.strsearchlng)
                    
                    //self.checkpolygon1Point(lat: self.strsearchlat, long: self.strsearchlng)
                    //self.checkpolygon2Point(lat: self.strsearchlat, long: self.strsearchlng)
                    
                    self.checkpolygonPointMultiple(lat: self.strsearchlat, long: self.strsearchlng)
                    
                    self.alertViewFunction()
                    
                    
                }
                
                
                break
            case .failure:
                print("failure")
            }
        }
    }
    
    //MARK: - Check MULTIPLE Coordinate WITHIN POLYGON OR NOT
    func checkpolygonPointMultiple(lat:Double,long:Double)
    {
        for xx in 0 ..< arrmpolygonobject.count
        {
            let polyobj = arrmpolygonobject.object(at: xx)as? MKPolygon
            let polygonRenderer = MKPolygonRenderer(polygon: polyobj!)
            let mapPoint: MKMapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: lat, longitude: long))
            let polygonViewPoint: CGPoint = polygonRenderer.point(for: mapPoint)
            
            if polygonRenderer.path.contains(polygonViewPoint)
            {
                print("Your location was inside your polygon1.")
                boolcheck = true
            }else{
                print("Your location was outside your polygon1.")
            }
        }
    }
    
    //MARK: - Check Search Coordinate WITHIN POLYGON OR NOT
    /*func checkpolygon1Point(lat:Double,long:Double)
    {
        let polygonRenderer = MKPolygonRenderer(polygon: polyg1)
        let mapPoint: MKMapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: lat, longitude: long))
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: mapPoint)

        if polygonRenderer.path.contains(polygonViewPoint)
        {
            print("Your location was inside your polygon1.")
            boolcheck = true
        }else{
            print("Your location was outside your polygon1.")
        }
    }
    func checkpolygon2Point(lat:Double,long:Double)
    {
        let polygonRenderer = MKPolygonRenderer(polygon: polyg2)
        let mapPoint: MKMapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: lat, longitude: long))
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: mapPoint)

        if polygonRenderer.path.contains(polygonViewPoint)
        {
            print("Your location was inside your polygon1.")
            boolcheck = true
        }else{
            print("Your location was outside your polygon1.")
        }
    }*/
    
    //MARK: - GET Address by Lat Long - Google API
    func getAddressFromLatLong(latitude: Double, longitude : Double)
    {
        var strconnurl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=AIzaSyBJAhGdm5k7WgmHUkWX_4w5DY0uA88e4Hk"
        strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
        print("strconnurl",strconnurl)
        AF.request(strconnurl,method: .get,encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            
            switch response.result{
            case .success(let JSON):
                
                //print("Success with JSON: \(String(describing: JSON))")
                
                //let array = JSON as? NSArray
                //print("array",array)
                
                let dic = JSON as? NSDictionary
                print("dic",dic as Any)
                
                let strstatus = String(format: "%@", dic?.value(forKey: "status")as? String ?? "")
                if strstatus == "OK"
                {
                    print("success")
                    
                    DispatchQueue.main.async {
                        
                        let arrmresults = dic?.value(forKey: "results")as? NSArray ?? []
                        print("arrmresults",arrmresults)
                        
                        let dic = arrmresults.object(at: 0)as? NSDictionary
                        
                        
                        //FIXME_____ FETCH CITY AND LOCATION NAME ______//
                        
                        let arraddress_components = dic?.value(forKey: "address_components")as! NSArray
                        for xx in 0 ..< arraddress_components.count
                        {
                            let dicaddress = arraddress_components.object(at: xx)as! NSDictionary
                            let strlong_name = String(format: "%@", dicaddress.value(forKey: "long_name")as? String ?? "")
                            
                            let arrmtypes = dicaddress.value(forKey: "types")as! NSArray
                            for yy in 0 ..< arrmtypes.count
                            {
                                let strtype = String(format: "%@", arrmtypes.object(at: yy)as? String ?? "")
                                if strtype == "sublocality" || strtype == "neighborhood" || strtype == "sublocality_level_1"
                                {
                                    //THEN FETCH LOCATION NAME
                                    print("strlong_name1",strlong_name)
                                    //self.strlocationname = strlong_name
                                }
                                
                                if strtype == "administrative_area_level_1"
                                {
                                    //THEN FETCH REGION NAME
                                    print("strlong_name2",strlong_name)
                                    self.strlocationname = strlong_name
                                }
                                
                                if strtype == "locality"
                                {
                                    //THEN FETCH CITY NAME
                                    print("strlong_name3",strlong_name)
                                    self.strcityname = strlong_name
                                }
                            }
                        }
                        
                       
                        let strformattedaddress = String(format: "%@", dic?.value(forKey: "formatted_address")as? String ?? "")
                        print("strformattedaddress",strformattedaddress)
                        print("location name",self.strlocationname)
                        print("city name",self.strcityname)
                        
                        
                        if self.txtsearch.text!.count > 0{
                            self.txtsearch.text = ""
                        }
                        self.txtsearch.text = strformattedaddress
                        
                        //self.checkpolygon1Point(lat: latitude, long: longitude)
                        //self.checkpolygon2Point(lat: latitude, long: longitude)
                        
                        self.checkpolygonPointMultiple(lat: latitude, long: longitude)
                        
                        self.alertViewFunction()
                    }
                    
                }
                else{
                    print("failure")
                }
                
                break
            case .failure:
                print("failure")
            }
        }
        
    }
    
    //MARK: - GET Lat Long by Address - Google API
    func performGoogleSearch(for string: String)
    {
        var components = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")!
        let key = URLQueryItem(name: "key", value: "AIzaSyBJAhGdm5k7WgmHUkWX_4w5DY0uA88e4Hk") // use your key
        let address = URLQueryItem(name: "address", value: string)
        components.queryItems = [key, address]
        
        let task = URLSession.shared.dataTask(with: components.url!) { [self] data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                print(String(describing: response))
                print(String(describing: error))
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
                print("not JSON format expected")
                print(String(data: data, encoding: .utf8) ?? "Not string?!?")
                return
            }
            
            guard let results = json["results"] as? [[String: Any]],
                  let status = json["status"] as? String,
                  status == "OK" else {
                print("no results")
                print(String(describing: json))
                return
            }
            
            let result = results[0]
            
            // first check that locality exists
            let resultTypes = result["types"] as? [String]
            let addressComponents = result["address_components"] as? [[String:AnyObject]]
            print("addressComponents",addressComponents as Any)
            print("resultTypes",resultTypes as Any)
            
            let formattedAddress = result["formatted_address"] as? String
            print("formattedAddress",formattedAddress as Any)
            let geometry = result["geometry"] as? [String:AnyObject]
            let location = geometry!["location"] as? [String:Double]
            strsearchlat = location!["lat"]!
            strsearchlng = location!["lng"]!
            print("strsearchlat",strsearchlat)
            print("strsearchlng",strsearchlng)
            
            DispatchQueue.main.async {
                self.checkdistanceradiousZone(lat: self.strsearchlat, lng: self.strsearchlng)
            }
        }
        
        task.resume()
    }
    
    
    //MARK: - press Confirm Location Method
    @IBAction func pressConfirmLocation(_ sender: Any)
    {
        if txtsearch.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please choose your location address", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            
            print("strsearchlat",self.strsearchlat)
            print("strsearchlng",self.strsearchlng)
            print("strlocationname",self.strlocationname)
            print("strcityname",self.strcityname)
            
            if strFrompageMap == "popupsubscriptionorderonce"
            {
                print("From Page --> HOME POPUP")
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                   if controller.isKind(of: homeclass.self) {
                      let tabVC = controller as! homeclass
                       tabVC.strPOPUPstreetaddressfrommap = String(format: "%@", txtsearch.text!)
                       tabVC.strPOPUPstreetaddressfrommapLocation = strlocationname
                       tabVC.strPOPUPstreetaddressfrommapCity = strcityname
                       tabVC.strPOPUPSelectedLATITUDE = String(self.strsearchlat)
                       tabVC.strPOPUPSelectedLONGITUDE = String(self.strsearchlng)
                      self.navigationController?.popToViewController(tabVC, animated: true)
                   }
                }
            }
        }
    }

}
