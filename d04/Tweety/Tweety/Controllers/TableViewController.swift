//
//  TableViewController.swift
//  Tweety
//
//  Created by Ryan DE KWAADSTENIET on 2019/10/12.
//  Copyright © 2019 Ryan DE KWAADSTENIET. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "TweetyCell"
private let token = "AAAAAAAAAAAAAAAAAAAAACxLAQEAAAAA3e1hR1XXxwMQx1lLTRgNKAD7UyM%3DsnmfkPJ0YZEF5TpFmQoWOTVSdnqXR7hoEYDvoI8Fy0uwY2E9in"

class TableViewController: UITableViewController, APITwitterDelegate, UISearchBarDelegate {
    
    @IBOutlet var searchy: UISearchBar!
    
    func ear(tweet: [Tweet]) {
        DispatchQueue.main.async {
            self.data = tweet
            self.tableView.reloadData()
        }
    }
    
    func exception(err: NSError) {
        let alert = AlertHelper()
        alert.showAlert(fromController: self)
    }
    
    var data = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(TweetyCell.self, forCellReuseIdentifier: reuseIdentifier)

        self.tableView.alwaysBounceVertical = true
        tion(query: "school 42")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TweetyCell
        
        cell.sizeToFit()
        cell.name = data[indexPath.row].name
        cell.tweet = data[indexPath.row].tweet
        cell.date = data[indexPath.row].date
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tion(query: String) {
        let api = APIController(delegate: self, token: token)
        api.tweetBirdiesTweet(query: query) {
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.estimatedRowHeight = 80
            self.tableView.reloadData()
            searchy.resignFirstResponder()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tion(query: searchBar.text ?? "school 42")
    }

}

class AlertHelper {
    
        func showAlert(fromController controller: UIViewController) {
            DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "JSON text did not start with array or object. Code=3840", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    
        }
    }
}
