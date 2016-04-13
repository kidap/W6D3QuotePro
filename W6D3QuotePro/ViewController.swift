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

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func createNew(sender: AnyObject) {
    let destinationVC = QuoteViewController()
    destinationVC.quote = Quote()
    presentViewController(destinationVC, animated: true, completion: nil)
  }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
    
    cell.textLabel?.text = "Quote text blah blah"
    cell.detailTextLabel?.text = "Mr blah"
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //Display alert
  }
}

