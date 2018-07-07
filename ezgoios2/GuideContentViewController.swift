//
//  GuideContentViewController.swift
//  Guide_test
//
//  Created by vickyliao on 2018/1/31.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import UIKit

class GuideContentViewController: UIViewController {
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    static var uuid = ""
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        switch index{
        case 3:
            UserDefaults.standard.set(true, forKey: "hasViewedGuide")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    @IBOutlet var startImage: UIImageView!
    var imageFile = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        switch index{
        case 0...2:
            startImage.isHidden = true
        case 3:
            startImage.isHidden = false
        default:
            break
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
