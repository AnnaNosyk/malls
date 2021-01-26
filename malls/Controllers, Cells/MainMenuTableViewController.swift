//
//  MainMenuTableViewController.swift
//  malls
//
//  Created by Anna Nosyk on 19.01.2021.
//

import UIKit
import RealmSwift

class MainMenuTableViewController: UITableViewController {
    

    var malls: Results<Malls>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        malls = realm.objects(Malls.self)

       
    }

    // MARK: - tableView data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return malls.isEmpty ? 0 :  malls.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        let mall = malls[indexPath.row]
        cell.nameLabel.text = mall.name
        cell.locationLabel.text = mall.location
        cell.imageOfMall.image = UIImage(data: mall.imageData!)
       
        cell.imageOfMall.layer.cornerRadius = cell.imageOfMall.frame.size.height/2
        cell.imageOfMall.clipsToBounds = true
        return cell
    }
    // MARK: - tableView Delegate

    //delete rows
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //delete rows from tableView and Database
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let mall = malls[indexPath.row]
            StorageManager.deleteObject(mall)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

    
    //save new value for  items
    @IBAction func unwidSegue(_ segue: UIStoryboardSegue) {
        
        guard let newMallVC = segue.source as? NewMallController else { return }
        
        newMallVC.saveNewMall()
        tableView.reloadData()
    }
}
