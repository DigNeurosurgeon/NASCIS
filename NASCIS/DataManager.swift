//
//  DataManager.swift
//  
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Source: RayWenderlich.com
//  Modified by Pieter Kubben on 4/25/15.
//

import Foundation

class DataManager {
  
    class func getStatusDataWithSuccess(success: ((statusData: NSData!) -> Void)) {
    
    let statusURL = "http://dign.eu/apps/nascis/status.json"
    
    loadDataFromURL(NSURL(string: statusURL)!, completion:{(data, error) -> Void in
        if let urlData = data {
          success(statusData: urlData)
        }
    })
  }
  
    
  class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
    var session = NSURLSession.sharedSession()
    
    let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
      if let responseError = error {
        completion(data: nil, error: responseError)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
          var statusError = NSError(domain:"eu.dign", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion(data: nil, error: statusError)
        } else {
          completion(data: data, error: nil)
        }
      }
    })
    
    loadDataTask.resume()
  }
}