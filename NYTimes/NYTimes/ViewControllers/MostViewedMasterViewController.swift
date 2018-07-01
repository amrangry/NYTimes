//
//  MostViewedMasterViewController.swift
//  NYTimes
//
//  Created by Amr ELghadban on 6/30/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

class MostViewedMasterViewController: UITableViewController {
    var detailViewController: DetailViewController?
    var dataSourceObjects = [MostViewed]()
    let segueIdentiferForDetailsView = "showDetail"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        navigationItem.leftBarButtonItem = editButtonItem
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            let topViewController = (controllers[controllers.count - 1] as? UINavigationController)?.topViewController
            detailViewController = topViewController as? DetailViewController
        }

        // load Articles from Webservice
        DataManager.getNYTimesArticles { isSuccess, _, result in
            if isSuccess {
                guard let mostViewedResult = result as? [MostViewed] else {
                    return
                }
                self.dataSourceObjects = mostViewedResult
                self.tableView.reloadData()
            } else {
                let msg = "No Data Found"
                UIAlertController().show(message: msg)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentiferForDetailsView {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = dataSourceObjects[indexPath.row]
                guard let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController else {
                    return
                }
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
    // MARK: - Table View

 extension MostViewedMasterViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCustomTableViewCell", for: indexPath) as? MasterCustomTableViewCell else {
            return UITableViewCell()
        }

        let object = dataSourceObjects[indexPath.row]
        cell.bindData(object: object)
        // cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentiferForDetailsView, sender: nil)
    }
}
