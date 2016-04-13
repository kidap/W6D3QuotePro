//
//  Photo.swift
//  W6D3QuotePro
//
//  Created by Karlo Pagtakhan on 04/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import UIKit


class Photo{
  var image: UIImage?
  var imageURL = ""
  
  init(image: UIImage?, imageURL:String){
    self.image = image
    self.imageURL = imageURL
  }
  convenience init(){
    self.init(image: nil,imageURL: "")
  }
}