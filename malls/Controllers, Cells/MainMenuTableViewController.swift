//
//  MainMenuTableViewController.swift
//  malls
//
//  Created by Anna Nosyk on 19.01.2021.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    

    let malls = [Malls(name: "Posnania", location: "Poznan", image: "posnania"),
                 Malls(name: "King Cross", location: "Poznan", image: "kingcross"),
                 Malls(name: "Galeria Malta", location: "Poznan", image: "malta"),
                 Malls(name: "Avenida", location: "Poznan", image: "aveninda"),
                 Malls(name: "Galeria A2", location: "Poznan", image: "a2"),
                 Malls(name: "Galeria MM", location: "Poznan", image: "mm"),
                 Malls(name: "Galeria Pestka", location: "Poznan", image: "pestka"),
                 Malls(name: "Galeria Arkada", location: "Poznan", image: "arkady"),
                 Malls(name: "Stary Browar", location: "Poznan", image: "stary browar")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return malls.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        cell.nameLabel.text = malls[indexPath.row].name
        cell.locationLabel.text = malls[indexPath.row].location
        cell.imageOfMall.image = UIImage(named: malls[indexPath.row].image)
        cell.imageOfMall?.layer.cornerRadius = cell.imageOfMall.frame.size.height / 2
        cell.imageOfMall?.clipsToBounds = true

        return cell
    }
    
    @IBAction func cancelButton(_ segue: UIStoryboardSegue) {}
}
