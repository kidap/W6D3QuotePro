//
//  QuoteViewController.swift
//  W6D3QuotePro
//
//  Created by Karlo Pagtakhan on 04/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import UIKit

protocol QuoteViewProtocol:class {
  func save(quote:Quote)
}

class QuoteViewController: UIViewController {
  weak var delegate:QuoteViewProtocol?
  var photoCollection = [Photo]()
  var quote = Quote()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    getRandomImages()
    quote = getRandomQuote()
    quote.photo = getRandomImage()
    view.backgroundColor = UIColor.greenColor()
  }
  
  @IBAction func save(sender: AnyObject) {
    if let delegate = self.delegate{
      delegate.save(quote)
    } else{
      print("There is no delegate")
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  func getRandomQuote()->Quote{
    return Quote()
  }
  func getRandomImage()->Photo{
    let randomNumber = Int(arc4random_uniform(UInt32(photoCollection.count)))
    return photoCollection[randomNumber]
  }
  func getRandomImages(){
    //    photoCollection
  }
  
}
