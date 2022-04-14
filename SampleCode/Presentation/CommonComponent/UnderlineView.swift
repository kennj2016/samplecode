//
//  UnderlineView.swift
//  SampleCode
//
//  Created by  KenNguyen on 26/09/2021.
//

import UIKit

class UnderlineView: UIView {

    // MARK: System
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Function
    private func setupUI() {
        self.backgroundColor = ColorDr.gray_text.value
        self.snp.makeConstraints { make in
            make.height.equalTo(1.asDesigned)
        }
    }

}
