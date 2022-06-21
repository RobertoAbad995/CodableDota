//
//  DetailViewController.swift
//  CodableDota
//
//  Created by Admin on 6/15/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var attributesLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var legsLbl: UILabel!
    @IBOutlet weak var attakType: UILabel!
    var hero: Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = hero.name
        attributesLbl.text =  hero?.primaryAttribute
        attackLbl.text = hero?.primaryAttribute
        attakType.text = hero.attackType
        
        for i in hero.roles
        {
            legsLbl.text! += i + " | "
        }
        
        
        
        
        image.downloaded(from: URL(string: "https://api.opendota.com\((hero.image))")!)
    }

}
