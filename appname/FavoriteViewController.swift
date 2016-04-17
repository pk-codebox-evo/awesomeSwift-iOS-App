//
//  FavoriteViewController.swift
//  AwesomeSwift
//
//  Created by Matteo Crippa on 17/04/2016.
//  Copyright © 2016 boostco.de. All rights reserved.
//

import CacheManager
import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var favoriteManager = RepositoryManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteManager.delegate = self

        let predicate = NSPredicate(format: "favorite = true")
        favoriteManager.filter = predicate

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath) as! RepositoryCell
        cell.configCellWithRepository(favoriteManager.itemAt(indexPath.row)!)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //arrYears.removeObjectAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteManager.count
    }
}

extension FavoriteViewController: CacheManagerDelegate {
    func cacheHasUpdate() {
        tableView.reloadData()
    }
}