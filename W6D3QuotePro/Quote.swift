//
//  Quote.swift
//  W6D3QuotePro
//
//  Created by Karlo Pagtakhan on 04/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import UIKit


class Quote{
  var text = ""
  var by = ""
  var photo: Photo?
  
  init(text: String, by:String, photo:Photo?){
    self.text = text
    self.by = by
    self.photo = photo
  }
  convenience init(){
    self.init(text: "",by: "",photo: nil)
  }
}