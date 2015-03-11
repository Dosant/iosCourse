//
//  MainTableViewController.swift
//  DosovRssParser
//
//  Created by Anton Dosov on 10.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, FeedParserDelegate {
  
  
  
  let cityDogURL = "http://citydog.by/rss"
  var parser:FeedParser!
  
  // MARK: - Logic
  
  func request(urlString:String?){
    
    if let urlStringNotOptional = urlString{
      
      let url = NSURL(string: urlStringNotOptional)
      parser = FeedParser()
      parser.delegate = self
      parser.startParsingWithContentsOfURL(url!)
      
      
    }
    
  }
  
  func FeedParserDelegateParsingWasFinished(parser: FeedParser) {
    tableView.reloadData();
    self.refreshControl?.endRefreshing()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.sharedApplication().keyWindow?.tintColor = UIColor.blackColor()
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    var refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
    self.refreshControl = refreshControl
    
    
    request(cityDogURL)

  }
  
  
 
  func refresh(){
    request(cityDogURL)
  }
  
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
   
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return parser.rssData.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("showFeed", forIndexPath: indexPath) as RssFeedTableViewCell
    
    let feed = parser.rssData[indexPath.row] as Dictionary<String, String>
    
    cell.titleField.text = feed["title"]
    cell.descriptionField.text = feed["description"]
    
    
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMM yyyy"
    let date = (dateFormatter.dateFromString(feed["pubDate"]!))
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    
    
    if let d = date{
    cell.dateField.text = dateFormatter.stringFromDate(d)
    } else {
      cell.dateField.text = ""
    }
    
    cell.feedUrl = feed["link"]
    
    cell.titleField.adjustsFontSizeToFitWidth = true
    
    return cell
  }
  
  
  
  
  
  
  
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "showDetails"){
      let vc = segue.destinationViewController as DetailsViewController
      
      let cellSender = sender as RssFeedTableViewCell
      
      vc.feedTitle = cellSender.titleField.text!
      vc.feedStringUrl = cellSender.feedUrl
    }
    
  }
  
  
}
