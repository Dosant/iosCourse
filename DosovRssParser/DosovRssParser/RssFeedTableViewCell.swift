//
//  RssFeedTableViewCell.swift
//  DosovRssParser
//
//  Created by Anton Dosov on 10.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

import UIKit

class RssFeedTableViewCell: UITableViewCell {

  @IBOutlet weak var titleField: UILabel!
  @IBOutlet weak var descriptionField: UILabel!
  @IBOutlet weak var dateField: UILabel!
  
  var feedUrl:String!
  

}
