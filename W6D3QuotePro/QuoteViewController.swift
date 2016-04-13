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
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var quoteTextLabel: UILabel!
  @IBOutlet var quoteByLabel: UILabel!
  @IBOutlet var cancelButton: UIButton!
  @IBOutlet var saveButton: UIButton!
  @IBOutlet var quoteButton: UIButton!
  @IBOutlet var imageButton: UIButton!
  @IBOutlet var textColorButton: UIButton!
  
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
    
    setButtonProperties(saveButton)
    setButtonProperties(cancelButton)
    setButtonProperties(quoteButton)
    setButtonProperties(imageButton)
    setButtonProperties(textColorButton)
    
    cancelButton.layer.shadowColor = UIColor.redColor().CGColor
    cancelButton.layer.borderColor = UIColor.redColor().CGColor
    cancelButton.backgroundColor = UIColor.redColor()
    cancelButton.titleLabel?.textColor = UIColor.whiteColor()
  }
  //MARK: Actions
  @IBAction func save(sender: AnyObject) {
    if let delegate = self.delegate{
      saveButton.alpha = 0
      cancelButton.alpha = 0
      imageButton.alpha = 0
      quoteButton.alpha = 0
      textColorButton.alpha = 0
      
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
    toggleTextColor()
  }
  
  //MARK: Helper methods
  func setupWithQuote(quote:Quote){
    quoteTextLabel.text = quote.text
    quoteByLabel.text = quote.by
    imageView.image = quote.photo?.image
  }
  
  func getRandomQuote(){
    DataManager.getQuote { (quote) in
      dispatch_async(dispatch_get_main_queue(), {
        if let quote = quote{
          self.quoteTextLabel.text = quote.text
          self.quoteByLabel.text = quote.by
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
          print(image)
          self.imageView.image = image
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
  
  func setButtonProperties(button:UIButton){
    //button.titleLabel?.textColor = UIColor.blackColor()
    button.layer.cornerRadius = 3
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.whiteColor().CGColor
    button.layer.shadowRadius = 3
    button.layer.shadowColor = UIColor.grayColor().CGColor
    button.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.75)
  }
  
  func toggleTextColor(){
    if quoteTextLabel.textColor == UIColor.blackColor(){
      quoteTextLabel.textColor = UIColor.whiteColor()
      quoteByLabel.textColor = UIColor.whiteColor()
      quoteTextLabel.layer.shadowColor = UIColor.blackColor().CGColor
      quoteByLabel.layer.shadowColor = UIColor.blackColor().CGColor
    } else {
      quoteTextLabel.textColor = UIColor.blackColor()
      quoteByLabel.textColor = UIColor.blackColor()
      quoteTextLabel.layer.shadowColor = UIColor.whiteColor().CGColor
      quoteByLabel.layer.shadowColor = UIColor.whiteColor().CGColor
    }
  }
  
}



