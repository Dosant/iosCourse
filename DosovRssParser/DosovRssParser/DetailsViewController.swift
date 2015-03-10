//
//  DetailsViewController.swift
//  DosovRssParser
//
//  Created by Anton Dosov on 10.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

  @IBOutlet weak var webView: UIWebView!
  var feedStringUrl:String!
  var feedTitle:String!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = feedTitle
        let request = NSURLRequest(URL: NSURL(string: feedStringUrl)!)
        webView.loadRequest(request)
    }

}
