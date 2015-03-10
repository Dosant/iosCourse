//
//  FeedParser.swift
//  DosovRssParser
//
//  Created by Anton Dosov on 10.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

import UIKit

protocol FeedParserDelegate{
  func FeedParserDelegateParsingWasFinished(parser: FeedParser)
}



class FeedParser: NSObject, NSXMLParserDelegate {
  
  var parser:NSXMLParser!
  
  var rssData = [Dictionary<String, String>]()
  
  
  var currentDataDictionary = Dictionary<String, String>()
  var foundCharacters = ""
  var currentElement = ""
  
  var delegate : FeedParserDelegate?
  

  
  
  
  func startParsingWithContentsOfURL(URL: NSURL) {
    parser = NSXMLParser(contentsOfURL: URL)
    println(URL)
    parser.delegate = self
    
    parser.shouldResolveExternalEntities = false
    parser.shouldProcessNamespaces = false
    parser.shouldReportNamespacePrefixes = false
    
    
    parser.parse()
  }

  
  func parser(parser: NSXMLParser, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]) {
    
    currentElement = elementName
    
    
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String!) {
    if (currentElement == "title") || (currentElement == "link") || (currentElement == "description") || (currentElement == "pubDate") {
      
      foundCharacters += string
      
    }
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
    if !foundCharacters.isEmpty {
      
      if elementName == "link"{
        foundCharacters = (foundCharacters as NSString).substringFromIndex(4)
      }
      
      if elementName == "description"{
        foundCharacters = (foundCharacters as NSString).substringFromIndex(4)
      }
      
      currentDataDictionary[elementName] = foundCharacters
      
      
      foundCharacters = ""
      
      if currentElement == "pubDate" {
        if (!currentDataDictionary.isEmpty){
        rssData.append(currentDataDictionary)
        }
      }
    }
  }
  
  
  func parserDidEndDocument(parser: NSXMLParser) {
    rssData.removeAtIndex(0)
    delegate?.FeedParserDelegateParsingWasFinished(self)
  }
 

  
}
