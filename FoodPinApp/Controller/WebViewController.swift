//
//  WebViewController.swift
//  FoodPinApp
//
//  Created by Jithin on 15/02/19.
//  Copyright © 2019 Jithin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView:WKWebView!
    var url = "http://www.appcoda.com/contact"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            webView.load(request)
        }
        // Do any additional setup after loading the view.
    }
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
