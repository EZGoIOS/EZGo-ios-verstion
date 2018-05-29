//
//  ViewController.swift
//  ezgo1
//
//  Created by vickyliao on 2017/10/31.
//  Copyright © 2017年 vickyliao. All rights reserved.
//

import UIKit
import MapKit
//import ezgo1

class ViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet var mapView: MKMapView!
    var aa:Int = 0
    let anns = [MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation()]
    public var tileRenderer: MKTileOverlayRenderer!
    //public parameters=[:]
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "hasViewedGuide"){
            getWorksheet()
            getRecordDone()
        }
        
        //setupTileRenderer()
        // Do any additional setup after loading the view, typically from a nib.
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        let location = CLLocationCoordinate2DMake(24.995, 121.584167)
        //設置地圖範圍（越小越精準）
        let span = MKCoordinateSpanMake(0.01, 0.01)
        
        //設置顯示區域
        let region = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region , animated: true)
        print("finish map setup")
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Taipei Zoo"
        annotation.subtitle = "Welcome!"
        //self.mapView.addAnnotation(annotation)
        //print("finish set pin")
        
        self.mapView.showsUserLocation = true
        print("show location")
        
        //可以在 mapView　中畫出一些額外的東西
        self.mapView.delegate = self
        print("set delegate")
        //虎的maker
        
        
        anns[0].coordinate = CLLocationCoordinate2D(latitude: 24.9946605, longitude: 121.5887605)
        anns[0].title = "斑點鬣狗"
        
        anns[1].coordinate = CLLocationCoordinate2D(latitude: 24.9975801, longitude: 121.5799735)
        anns[1].title = "臺灣黑熊"
        
        anns[2].coordinate = CLLocationCoordinate2D(latitude: 24.9932772, longitude: 121.5900815)
        anns[2].title = "北美灰狼"
        
        anns[3].coordinate = CLLocationCoordinate2D(latitude: 24.9921553, longitude: 121.5890408)
        anns[3].title = "黑尾草原犬鼠"
        
        anns[4].coordinate = CLLocationCoordinate2D(latitude: 24.995106, longitude: 121.583514)
        anns[4].title = "笑翠鳥"
        
        anns[5].coordinate = CLLocationCoordinate2D(latitude: 24.9978621, longitude: 121.5818524)
        anns[5].title = "教育中心"
        
        anns[6].coordinate = CLLocationCoordinate2D(latitude: 24.9977223, longitude: 121.5810719)
        anns[6].title = "山羌"
        
        mapView.addAnnotations(anns)
        
        
        //device id 確認
        //let defaults = UserDefaults.standard
        //let name = defaults.string(forKey: "device id")
        //print("====device id 確定相同？：",name!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(_ mapkitView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("mapview")
        
        return tileRenderer
    }
    @IBAction func clickbutton(sender: UIButton){
        if sender.tag == 1{//hyena
            print("success")
            //   performSegue(withIdentifier: "aaaa", sender: self)
            //performSegue(withIdentifier: "aaaa", sender: Any?.self)
            aa = 1
            performSegue(withIdentifier: "gotoDetail", sender: self)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var xx:KnowledgeDetailViewController = segue.destination as! KnowledgeDetailViewController
        xx.whichOne = self.aa
        
    }
    
    //虎的func
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->MKAnnotationView?{
        if annotation is MKUserLocation{
            //如果標記是user所在位置，就不做處理
            return nil
        }
        
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier:"Pin")
            //dequeueReusableAnnotationView 是用來配置記憶體池位置的  當pin有在螢幕顯示範圍內 再顯示 避免浪費記憶體資源
        }
        let rightButton = UIButton(type: .detailDisclosure)
        rightButton.tag = annotation.hash
        if (annotation.title)! == "斑點鬣狗" {
            annView?.image = UIImage(named:"circle_hyena")
            annView?.canShowCallout = true
            
            annView?.rightCalloutAccessoryView = rightButton
            rightButton.addTarget(self,action: #selector(self.clickbutton),for: .touchUpInside)
            rightButton.tag = 1
        }
        else if (annotation.title)! == "臺灣黑熊"{
            annView?.image = UIImage(named:"circle_bear")
        }
        else if (annotation.title)! == "北美灰狼"{
            annView?.image = UIImage(named:"circle_wolf")
        }
        else if (annotation.title)! == "黑尾草原犬鼠"{
            annView?.image = UIImage(named:"circle_prairiedog")
        }
        else if (annotation.title)! == "笑翠鳥"{
            annView?.image = UIImage(named:"circle_kookaburra")
        }
        else if (annotation.title)! == "教育中心"{
            annView?.image = UIImage(named:"gift")
        }
        else if (annotation.title)! == "山羌"{
            annView?.image = UIImage(named:"circle_deer")
        }
        
        annView?.canShowCallout = true
        
        return annView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        /*  if anns[0].title == "斑點鬣狗"{
         print("1")
         }
         else if anns[1].title == "臺灣黑熊"{
         print("2")
         }
         else if anns[2].title == "北美灰狼"{
         print("3")
         }
         else if anns[3].title == "黑尾草原犬鼠"{
         print("4")
         }
         else if anns[4].title == "笑翠鳥"{
         print("5")
         }
         else if anns[5].title == "教育中心"{
         print("6")
         }
         else if anns[6].title == "山羌"{
         print("7")
         }
         */
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "hasViewedGuide") {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "GuideController") as? GuidePageViewController {
            
            present(pageViewController, animated: true, completion: nil)
        }
    }
    
    
}

