//
//  CountryTBCell.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import UIKit

class CountryTBCell: UITableViewCell {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillData(_ model: CountryModelView) {
        lbName.text = model.name
        lbCode.text = model.code
    }
}
