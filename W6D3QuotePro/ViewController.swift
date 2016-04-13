//
//  ViewController.swift
//  W6D3QuotePro
//
//  Created by Karlo Pagtakhan on 04/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  var sourceArray = [Quote]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  @IBAction func createNew(sender: AnyObject) {
    let destinationVC = QuoteViewController()
    destinationVC.quote = Quote()
    destinationVC.delegate = self
    presentViewController(destinationVC, animated: true, completion: nil)
  }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sourceArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
    cell.textLabel?.text = sourceArray[indexPath.row].text
    cell.detailTextLabel?.text = sourceArray[indexPath.row].by
    cell.accessoryView = UIImageView(image: sourceArray[indexPath.row].photo!.image)
    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let activitiesToShare:[AnyObject] = [(sourceArray[indexPath.row].photo?.image)!, sourceArray[indexPath.row].text]
    let shareAlert = UIActivityViewController(activityItems: activitiesToShare, applicationActivities: nil)
    presentViewController(shareAlert, animated: true, completion: nil)
  }
}

extension ViewController:QuoteProtocol{
  func save(quote:Quote){
    sourceArray.append(quote)
    print(sourceArray.count)
    tableView.reloadData()
  }
}

