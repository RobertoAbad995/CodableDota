//
//  CustomCell.swift
//  CodableDota
//
//  Created by Consultant on 6/20/22.
//
 
import UIKit

class CustomCell: UITableViewCell{
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("Init(coder: ) has not been implemented")
    }
    
    
}
