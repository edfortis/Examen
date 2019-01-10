//
//  ProductoCell.swift
//  
//
//  Created by Eduardo Loyo Martinez on 1/3/19.
//

import UIKit

class ProductoCell: UITableViewCell {
   
    @IBOutlet weak var titulo: UITextView!
    @IBOutlet weak var precio: UITextField!
    @IBOutlet weak var descuento: UITextField!
    
    
    @IBOutlet weak var imagen: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
