//
//  MainMenuTableViewController.swift
//  malls
//
//  Created by Anna Nosyk on 19.01.2021.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    
    let malls = ["Posnania", "King Cross", "Galeria Malta", "Avenida","Galeria A2", "Galeria MM", "Galeria Pestka", "Galeria Arkada", "Stary Browar"]
    
    let imagesNames = ["posnania", "kingcross", "malta", "aveninda","Galeria A2", "mm", "pestka", "arkady", "stary browar"]

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return malls.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = malls[indexPath.row]
        cell.imageView?.image = UIImage(named: imagesNames[indexPath.row])

        return cell
    }
    


}
