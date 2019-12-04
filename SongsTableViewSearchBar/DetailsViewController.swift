//
//  DetailsViewController.swift
//  SongsTableViewSearchBar
//
//  Created by World Domination a Brand on 12/4/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    var selectedSong: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: what is the default image. 
        
        artistNameLabel.text = selectedSong?.artist
        songNameLabel.text = selectedSong?.name
      //  imageView.image = selectedSong?.image
        
    }
    
    
   
}
