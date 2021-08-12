//
//  ToDoListCell.swift
//  ToDoListApp
//
//  Created by Ahmed Awaga on 5/22/21.
//

import UIKit

class ToDoListCell: UITableViewCell {
    @IBOutlet weak var backview: UIView!{
        didSet{
            backview.layer.cornerRadius = backview.frame.height / 5
            backview.layer.borderColor = #colorLiteral(red: 0.1972967982, green: 0.26913324, blue: 0.3522819877, alpha: 1)
            backview.layer.borderWidth = 2 
        }
    }
    @IBOutlet weak var ToDolbl: UILabel!
    @IBOutlet weak var upbtn: UIButton!
    @IBOutlet weak var downbtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
