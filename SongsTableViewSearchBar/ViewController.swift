//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // outlets and variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allSongs = [Song]()
    {
        didSet{
            tableView.reloadData()
            // if this is found nil then that means you haven't connected the tableView....
        }
    }
    
//    var searchQuerey = "" {
//        didSet{
//            ta
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    func loadData() {
        allSongs = Song.loveSongs
    }
    
    func filterHeadline(_ searchText: String) {
        
        guard !searchText.isEmpty else {
            return
        }
        
        allSongs = Song.loveSongs.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsViewController = segue.destination as? DetailsViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // assigns the detailsController variable the selected variable from the view controller...
        detailsViewController.selectedSong = allSongs[indexPath.row]
    }
    

}
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //to take away the keep board
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        
        filterHeadline(searchText)
        
        //searchQuerey = searchText
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
       let selectedSong = allSongs[indexPath.row]
        
        cell.textLabel?.text = selectedSong.name
        
        cell.detailTextLabel?.text = selectedSong.artist
        
        return cell
        
        
    }
    
}
