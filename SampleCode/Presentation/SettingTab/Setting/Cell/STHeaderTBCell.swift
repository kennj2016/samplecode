//
//  STHeaderTBCell.swift
//  sample
//
//  Created by KenNguyen 21/10/2021.
//

import UIKit

class STHeaderTBCell: UITableViewCell {
    @IBOutlet weak var btnProfile: CustomButton! {
        didSet {
            btnProfile.setTitle(nomarlString: "Profile".localized(), titleColor: ColorDr.blue.value)
        }
    }
    var callBackWithAction: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnProfile
            .reactive
            .tap
            .observeNext {  _ in
                if self.callBackWithAction != nil {
                    self.callBackWithAction!()
                }
            }.dispose(in: bag)
        
    }

    
    
}
