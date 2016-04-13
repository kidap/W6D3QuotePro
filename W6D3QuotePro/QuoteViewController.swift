//
//  QuoteViewController.swift
//  W6D3QuotePro
//
//  Created by Karlo Pagtakhan on 04/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import UIKit

protocol QuoteProtocol:class {
  func save(quote:Quote)
}

class QuoteViewController: UIViewController {
  weak var delegate:QuoteProtocol?
  var photoDict = [[String:AnyObject]]()
  var photoCollection = [Photo]()
  var quote = Quote()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    getRandomQuote()
    getRandomImages()
    view.backgroundColor = UIColor.lightGrayColor()
  }
  //MARK: Actions
  @IBAction func save(sender: AnyObject) {
    if let delegate = self.delegate{
      if let currentView = self.view as? QuoteView{
        currentView.saveButton.alpha = 0
        currentView.cancelButton.alpha = 0
        currentView.imageButton.alpha = 0
        currentView.quoteButton.alpha = 0
        currentView.textColorButton.alpha = 0
      }
      UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0);
      view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
      let image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      quote.photo = Photo(image: image, imageURL: "")
    
      delegate.save(quote)
    } else{
      print("There is no delegate")
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func newImage(sender: AnyObject) {
    getRandomImage()
  }
  
  @IBAction func newQuote(sender: AnyObject) {
    getRandomQuote()
  }
  
  @IBAction func changeTextColor(sender: AnyObject) {
    if let currentView = self.view as? QuoteView{
      currentView.toggleTextColor()
    }
  }
  
  //MARK: Helper methods
  func setupWithQuote(quote:Quote){
    if let currentView = self.view as? QuoteView{
    currentView.quoteTextLabel.text = quote.text
    currentView.quoteByLabel.text = quote.by
    currentView.imageView.image = quote.photo?.image
    }
  }
  
  func getRandomQuote(){
    DataManager.getQuote { (quote) in
      dispatch_async(dispatch_get_main_queue(), {
        let currentView = self.view as?QuoteView
        if let quote = quote{
          currentView?.quoteTextLabel.text = quote.text
          currentView?.quoteByLabel.text = quote.by
          self.quote.text = quote.text
          self.quote.by = quote.by
        }
      })
    }
  }
  func getRandomImage(){
    if photoDict.count == 0{
      getRandomImages()
    }
    if photoDict.count > 0{
      let randomNumber = Int(arc4random_uniform(UInt32(photoDict.count) - 1))
      var imageURLString = photoDict[randomNumber]["post_url"] as? String
      
      imageURLString = "https://unsplash.it/200/300/?image=\(randomNumber)"
      print(imageURLString)
      
      DataManager.getImageUsingURL(NSURL(string:imageURLString!)!, completion: { (image) in
        dispatch_async(dispatch_get_main_queue(), {
          print("----printing image-----")
          let currentView = self.view as?QuoteView
          print(image)
          currentView?.imageView.image = image
          self.view.layoutIfNeeded()
        })
      })
    }
  }
  func getRandomImages(){
    DataManager.getImages { (imagesDict) in
      self.photoDict = imagesDict
      self.getRandomImage()
      
    }
  }
  
}
