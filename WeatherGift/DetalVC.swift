//
//  DetalVC.swift
//  WeatherGift
//
//  Created by Joseph Marasco on 10/14/19.
//  Copyright © 2019 Joseph Marasco. All rights reserved.
//

import UIKit

class DetalVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = locationsArray[currentPage].name
       
    }
    

  
}
