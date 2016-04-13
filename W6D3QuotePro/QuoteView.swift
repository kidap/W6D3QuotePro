//
//  QuoteView.swift
//  W6D3QuotePro
//
//  Created by Karlo Pagtakhan on 04/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import UIKit

class QuoteView: UIView {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var quoteTextLabel: UILabel!
  @IBOutlet var quoteByLabel: UILabel!
  @IBOutlet var cancelButton: UIButton!
  @IBOutlet var saveButton: UIButton!
  @IBOutlet var quoteButton: UIButton!
  @IBOutlet var imageButton: UIButton!
  @IBOutlet var textColorButton: UIButton!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  override func drawRect(rect: CGRect) {
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
