//
//  SecondViewController.swift
//  Kanto
//
//  Created by Ryan de Kwaadsteniet on 10/14/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit
import MapKit

struct List {
    static var locations: [(Double, Double, String, String, String)] = [
        (48.8966, 2.3184, "42 School", "This is where it all began...", "Green"),
        (37.5485, -122.0592, "42 Silicon Valley", "Now partnering with Pied Piper!", "Cyan"),
        (-33.9070, 18.4173, "WeThinkCode_", "A place where people die a slow death...", "Blue")
    ]
    
    static var coord: [CLLocation] = [CLLocation(latitude: 48.8966, longitude: 2.3184), CLLocation(latitude: 37.5485, longitude: -122.0592), CLLocation(latitude: -33.9070, longitude: 18.4173)]
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableBookmarks: UITableView!
    var dataToPass: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableBookmarks.delegate = self
        self.tableBookmarks.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.locations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableBookmarks.dequeueReusableCell(withIdentifier: "BookmarkCell") as! BookmarkCell
        cell.textLabel?.text = List.locations[indexPath.row].2
        cell.detailTextLabel?.text = List.locations[indexPath.row].3
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        tableBookmarks.estimatedRowHeight = 80
        tableBookmarks.rowHeight = UITableView.automaticDimension

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dataToPass = indexPath.row
//        let mapVC : BaseTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rootNav") as! BaseTabBarController
//        mapVC.value = dataToPass!
        let tabbar = tabBarController as! BaseTabBarController
        tabbar.value = dataToPass!
        tabBarController!.selectedIndex = 0
        //self.present(mapVC, animated:false, completion:nil)
    }

}
