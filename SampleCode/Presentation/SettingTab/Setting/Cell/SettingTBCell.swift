//
//  SettingTBCell.swift
//  sample
//
//  Created by KenNguyen 21/10/2021.
//

import UIKit

class SettingTBCell: UITableViewCell {

    @IBOutlet weak var imgViewRight: UIImageView!
    @IBOutlet weak var lbSubName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgViewIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(with name: String, image: UIImage?, sub_name: String?, isRight: Bool) {
        if let image = image {
            imgViewIcon.image = image
            imgViewIcon.isHidden = false

        }else {
            imgViewIcon.isHidden = true
        }
        
        if let sub = sub_name {
            lbSubName.text = sub
            lbSubName.isHidden = false

        }else {
            lbSubName.isHidden = true
        }
        imgViewRight.isHidden = !isRight
        lbName.text = name
    }
}
