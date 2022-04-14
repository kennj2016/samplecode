//
//  SampleCodePopUpViewController.swift
//  SampleCode
//
//  Created by  KenNguyen on 27/09/2021.
//

import UIKit

class PopUpType1ViewController: UIViewController {
    
    // MARK: Properties
    var primaryButtonTapCallback: (() -> ())?
    
    var secondaryButtonTapCallback: (() -> ())?

    var isDismissable: Bool? = false

    var popupTitleColor: UIColor = .black {
        didSet {
            popupTitleLabel.textColor = popupTitleColor
        }
    }
    
    var popupTitle: String = "" {
        didSet {
            popupTitleLabel.text = popupTitle
        }
    }
    
    var popupDescriptionColor: UIColor = ColorDr.gray_text.value {
        didSet {
            popupDescriptionLabel.textColor = popupDescriptionColor
        }
    }
    
    var popupDescription: String = "" {
        didSet {
            popupDescriptionLabel.text = popupDescription
            popupDescriptionLabel.setLineSpacing(lineSpacing: 20.asDesigned)
        }
    }
    
    var primaryButtonTitle: String = "OK".localized() {
        didSet {
            primaryButton.setTitle(primaryButtonTitle, for: .normal)
        }
    }
    
    var secondaryButtonTitle: String = "Back".localized() {
        didSet {
            secondaryButton.setTitle(secondaryButtonTitle, for: .normal)
        }
    }
    
    // MARK: Component UI
    private lazy var popupTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = popupTitleColor
        label.textAlignment = .left
        label.setFontName(fontName: .bold, fontSize: 16.asDesigned)
        label.setLineSpacing(lineSpacing: 18.4.asDesigned)
        
        return label
    }()
    
    private lazy var underlineView: UnderlineView = {
        let underline = UnderlineView()
        
        return underline
    }()
    
    private lazy var popupDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = popupDescriptionColor
        label.setFontName(fontName: .regular, fontSize: 14.asDesigned)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var primaryButton: UIButton = {
        let button = UIButton()
        button.setTitle(primaryButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorDr.blue.value
        button.layer.cornerRadius = 4.asDesigned
        button.titleLabel?.setFontName(fontName: .bold, fontSize: 14.asDesigned)
        
        return button
    }()
    
    private lazy var secondaryButton: UIButton = {
        let button = UIButton()
        button.setTitle(secondaryButtonTitle, for: .normal)
        button.setTitleColor(ColorDr.blue.value, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4.asDesigned
        button.layer.borderWidth = 1.asDesigned
        button.layer.borderColor = ColorDr.blue.value.cgColor
        button.titleLabel?.setFontName(fontName: .bold, fontSize: 14.asDesigned)
        
        return button
    }()
    
    private lazy var popUpTitleContainerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var popupContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2.asDesigned
        
        return view
    }()
    
    // MARK: System
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        guard let isDismissable = isDismissable, isDismissable else { return }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addTapGesture()
    }
    
    // MARK: Function
    private func setupUI() {
        view.backgroundColor = .black.withAlphaComponent(0.8)
        
        view.addSubview(popupContainerView)
        
        popupContainerView.addSubview(popUpTitleContainerView)
        popupContainerView.addSubview(popupDescriptionLabel)
        popupContainerView.addSubview(primaryButton)
        popupContainerView.addSubview(secondaryButton)
        
        popUpTitleContainerView.addSubview(popupTitleLabel)
        popUpTitleContainerView.addSubview(underlineView)
        
        // Pop up container view
        popupContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(70.asDesigned)
            make.left.equalToSuperview().offset(20.asDesigned)
            make.right.equalToSuperview().offset(-20.asDesigned)
        }
        
        // Pop up title container view
        popUpTitleContainerView.snp.makeConstraints { make in
            if (popupTitle.isEmpty) {
                make.height.equalTo(0)
            }
            make.top.left.right.equalToSuperview()
        }
        
        // Pop up title label
        popupTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(13.5.asDesigned)
            make.right.equalToSuperview().offset(-13.5.asDesigned)
            make.top.equalToSuperview().offset(17.asDesigned)
            make.bottom.equalToSuperview().offset(-17.asDesigned)
        }
        
        // Pop up underline view
        underlineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        // Primary button
        let buttonWidth = (SCREEN_WIDTH - (20.asDesigned * 2) - (12.asDesigned * 3)) / 2
        
        primaryButton.snp.makeConstraints { make in
            make.width.equalTo(buttonWidth)
            make.height.equalTo(36.asDesigned)
            make.left.equalToSuperview().offset(12.asDesigned)
            make.bottom.equalTo(popupContainerView.snp.bottom).offset(-20.asDesigned)
        }
        
        // Pop up description label
        popupDescriptionLabel.snp.makeConstraints { make in
            if (popupDescription.isEmpty) {
                make.height.equalTo(0)
                make.top.left.right.equalToSuperview()
            } else {
                make.top.equalTo(popUpTitleContainerView.snp.bottom).offset(19.asDesigned)
                make.left.equalToSuperview().offset(12.asDesigned)
                make.right.equalToSuperview().offset(-12.asDesigned)
                make.bottom.equalTo(primaryButton.snp.top).offset(-19.asDesigned)
            }
        }
        
        // Secondary button
        secondaryButton.snp.makeConstraints { make in
            make.height.equalTo(primaryButton.snp.height)
            make.top.equalTo(primaryButton.snp.top)
            make.right.equalToSuperview().offset(-12.asDesigned)
            make.left.equalTo(primaryButton.snp.right).offset(12.asDesigned)
        }
        
    }
    
    @objc private func didTapPrimaryButton() {
        primaryButtonTapCallback?()
    }
    
    @objc private func didTapSecondaryButton() {
        secondaryButtonTapCallback?()
    }
    
    private func addTapGesture() {
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(didTapSecondaryButton), for: .touchUpInside)
    }
    
}
