//
//  DataManager.swift
//  W6D3QuotePro
//
//  Created by Karlo Pagtakhan on 04/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import Foundation
import Alamofire
import Nuke


class DataManager{
  static var quoteUrlString = "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json"
  static var imageUrlString = "https://unsplash.it/list"
  
  class func getQuote(completion: (Quote?)->Void ){
    print(quoteUrlString)
    let request = NSURLRequest(URL: NSURL(string: quoteUrlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!)
    let aRequest = Alamofire.request(request)
    aRequest.responseJSON { (response) in
      print("Print quote response: \(response)")
      
      guard let _ = response.result.value as? [String:AnyObject], let quoteText = response.result.value!["quoteText"] as? String else{
        print(response.result.error)
        return
      }
      
      let quoteAuthor = response.result.value?["quoteAuthor"] as? String ?? ""
      
      completion(Quote(text: quoteText, by: quoteAuthor, photo: nil))
    }
  }
  
  class func getImages(completion: ([[String:AnyObject]])->Void){
    let request = NSURLRequest(URL: NSURL(string: imageUrlString)!)
    let aRequest = Alamofire.request(request)
    aRequest.responseJSON { (response) in
      guard let returnValue = response.result.value as? [[String:AnyObject]] else{
        return
      }
      completion(returnValue)
    }
  }
  
  class func getImageUsingURL(url:NSURL, completion: (UIImage)->Void){
    var request = ImageRequest(URLRequest: NSURLRequest(URL: url))
    // Control memory caching
    request.memoryCacheStorageAllowed = true // true is default
    request.memoryCachePolicy = .ReloadIgnoringCachedImage // Force reload
    
    // Change the priority of the underlying NSURLSessionTask
    request.priority = NSURLSessionTaskPriorityHigh
    
    Nuke.taskWith(request) { response in
      switch response {
      case let .Success(image, info):
        if (info.isFastResponse) {
          // Image was returned from the memory cache
        }
        print("Image retrieved")
        completion(image)
      case let .Failure(error):
        print(error)
        break
      }
      }.resume()
  }
}