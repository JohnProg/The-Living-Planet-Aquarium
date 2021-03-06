//
//  HomeWebViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/8/17.
//  Copyright © 2017 Forrest Syrett. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeWebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var requestString = ""
    var titleLabelString = ""
    var buttonHidden = true
    var scaleToFit = true
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aquaWaveColor = UIColor(red:0.20, green:0.35, blue:0.54, alpha:1.00)
        
        self.view.backgroundColor = aquaWaveColor
        
        webView.delegate = self
        
     //   gradient(self.view)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        transparentNavigationBar(self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        activityIndicator.startAnimating()
        webView.scalesPageToFit = self.scaleToFit
        webView.loadRequest(URLRequest(url: URL(string: requestString)!))
        
        self.titleLabel.text = titleLabelString
        
        IndexController.shared.index = 2
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        print("start load")
        // activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        print("stop load")
        activityIndicator.stopAnimating()
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
