//
//  ChatTBCell.swift
//  sample
//
//  Created by KenNguyen 06/10/2021.
//

import UIKit

class ChatTBCell: UITableViewCell {

    @IBOutlet private var lbName: UILabel!
    @IBOutlet private var lbUser: UILabel!
    @IBOutlet private var imgViewAvatar: UIImageView!
    @IBOutlet private var viewVerify: UIView!

    private var viewModel: UserViewModel!
    
    func fill(with viewModel: UserViewModel) {
        self.viewModel = viewModel
        lbName.text = viewModel.name
        lbUser.text = viewModel.username
        imgViewAvatar.kfImageURL(viewModel.avatar, placeHolder: Asset.ic_chat_avatar_default.image)
        viewVerify.isHidden = !viewModel.isverify
    }
}
