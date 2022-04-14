//
//  NavigationBarView.swift
//  SampleCode
//
//  Created by  KenNguyen on 25/09/2021.
//

import UIKit

class NavigationBarView: UIView {
    
    // Properties
    var didTapBackButton: (() -> ())?
    var didTapRightButton: (() -> ())?
    var didTapCameraButton: (() -> ())?
    var didTapQrButton: (() -> ())?

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: Component UI
    lazy var backButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.icNavigationBack.image
        
        return imageView
    }()
    
    lazy var rightButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.login_more_action.image
        
        return imageView
    }()
    
    lazy var cameraButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.profile_camera_big.image
        
        return imageView
    }()
    
    lazy var qrButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.profile_qr.image
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.setFontName(fontName: .regular, fontSize: 20.asDesigned)
        label.textAlignment = .left
        
        return label
    }()
    

    var isHasRightButton: Bool = false {
        didSet {
            rightButton.isHidden = !isHasRightButton
        }
    }
    
    var isHasRightProfileButton: Bool = false {
        didSet {
            cameraButton.isHidden = !isHasRightProfileButton
            qrButton.isHidden = !isHasRightProfileButton

        }
    }
    
    // MARK: System
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addTapGesture()
        addTapRightGesture()
        addTapQrGesture()
        addTapCameraGesture()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function
    private func setupUI() {
        //Default
        isHasRightButton = false
        isHasRightProfileButton = false

        addSubview(backButton)
        addSubview(rightButton)
        addSubview(qrButton)
        addSubview(cameraButton)
        
        addSubview(titleLabel)
        
        // Back button
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(39.asDesigned)
            make.left.equalToSuperview().offset(12.asDesigned)
            make.bottom.equalToSuperview().offset(-16.asDesigned)
        }
        rightButton.snp.makeConstraints { make in
            make.height.width.equalTo(28.asDesigned)
            make.right.equalToSuperview().offset(-12.asDesigned)
            make.bottom.equalToSuperview().offset(-16.asDesigned)
        }
        
        qrButton.snp.makeConstraints { make in
            make.height.width.equalTo(24.asDesigned)
            make.right.equalToSuperview().offset(-12.asDesigned)
            make.centerY.equalTo(backButton)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.height.width.equalTo(33.asDesigned)
            make.right.equalTo(qrButton.snp.left).offset(-28.asDesigned)
            make.centerY.equalTo(backButton)
        }
       
        
        // Title label
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(8.asDesigned)
            make.centerY.equalTo(backButton)
        }
    }
    
    @objc private func didTapBackButtonEvent() {
        didTapBackButton?()
    }
    
    private func addTapGesture() {
        backButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackButtonEvent))
        backButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapRightButtonEvent() {
        didTapRightButton?()
    }
    
    private func addTapRightGesture() {
        rightButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRightButtonEvent))
        rightButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapCameratButtonEvent() {
        didTapCameraButton?()
    }
    
    private func addTapCameraGesture() {
        cameraButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCameratButtonEvent))
        cameraButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapQRButtonEvent() {
        didTapQrButton?()
    }
    
    private func addTapQrGesture() {
        qrButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapQRButtonEvent))
        qrButton.addGestureRecognizer(tapGesture)
    }
    
}
