//
//  SampleCodeTextField.swift
//  SampleCode
//
//  Created by  KenNguyen on 05/07/2021.
//

import UIKit
import SnapKit

enum TextFieldType {
    case normal_with_icon
    case normal_no_icon
    case password
    case bod
    case custom


}

enum ResponderStandardEditActions {
    case cut, copy, paste, select, selectAll, delete
    case makeTextWritingDirectionLeftToRight, makeTextWritingDirectionRightToLeft
    case toggleBoldface, toggleItalics, toggleUnderline
    case increaseSize, decreaseSize
    
    var selector: Selector {
        switch self {
        case .cut:
            return #selector(UIResponderStandardEditActions.cut)
        case .copy:
            return #selector(UIResponderStandardEditActions.copy)
        case .paste:
            return #selector(UIResponderStandardEditActions.paste)
        case .select:
            return #selector(UIResponderStandardEditActions.select)
        case .selectAll:
            return #selector(UIResponderStandardEditActions.selectAll)
        case .delete:
            return #selector(UIResponderStandardEditActions.delete)
        case .makeTextWritingDirectionLeftToRight:
            return #selector(UIResponderStandardEditActions.makeTextWritingDirectionLeftToRight)
        case .makeTextWritingDirectionRightToLeft:
            return #selector(UIResponderStandardEditActions.makeTextWritingDirectionRightToLeft)
        case .toggleBoldface:
            return #selector(UIResponderStandardEditActions.toggleBoldface)
        case .toggleItalics:
            return #selector(UIResponderStandardEditActions.toggleItalics)
        case .toggleUnderline:
            return #selector(UIResponderStandardEditActions.toggleUnderline)
        case .increaseSize:
            return #selector(UIResponderStandardEditActions.increaseSize)
        case .decreaseSize:
            return #selector(UIResponderStandardEditActions.decreaseSize)
        }
    }
}

class CustomTextField: UITextField {
    
    private var editActions: [ResponderStandardEditActions: Bool]?
    private var filterEditActions: [ResponderStandardEditActions: Bool]?
    
    func setEditActions(only actions: [ResponderStandardEditActions]) {
        if self.editActions == nil { self.editActions = [:] }
        filterEditActions = nil
        actions.forEach { self.editActions?[$0] = true }
    }
    
    func addToCurrentEditActions(actions: [ResponderStandardEditActions]) {
        if self.filterEditActions == nil { self.filterEditActions = [:] }
        editActions = nil
        actions.forEach { self.filterEditActions?[$0] = true }
    }
    
    private func filterEditActions(actions: [ResponderStandardEditActions], allowed: Bool) {
        if self.filterEditActions == nil { self.filterEditActions = [:] }
        editActions = nil
        actions.forEach { self.filterEditActions?[$0] = allowed }
    }
    
    func filterEditActions(notAllowed: [ResponderStandardEditActions]) {
        filterEditActions(actions: notAllowed, allowed: false)
    }
    
    func resetEditActions() { editActions = nil }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if let actions = editActions {
            for _action in actions where _action.key.selector == action { return _action.value }
            return false
        }
        
        if let actions = filterEditActions {
            for _action in actions where _action.key.selector == action { return _action.value }
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}

class TextFieldDr: UIView {

    // MARK: Properties
    var typingCallBack: ((_ text: String?) -> ())?
    var beginCallBack: (() -> ())?

    var autoFocus: Bool = false {
        didSet {
            if (autoFocus) {
                textField.becomeFirstResponder()
            }
        }
    }

    var isHasBorder: Bool = false {
        didSet {
            if (isHasBorder) {
                errorContainerView.backgroundColor = ColorDr.gray_text.value
            }
        }
    }
    
    var isHiddenRightIcon: Bool = false {
        didSet {
            self.rightIconImageView.isHidden = isHiddenRightIcon
        }
    }

    var isCheckValid: Bool = false {
        didSet {
            if self.value?.isEmpty == true {
                containerView.layer.borderColor = UIColor.clear.cgColor
                containerView.layer.borderWidth = 0.0
                return
            }
            if self.textFieldType != .password {
                rightIconImageView.image = isCheckValid ? Asset.signup_checked.image : Asset.signup_exit.image
            }
            
            containerView.layer.borderColor = isCheckValid ? ColorDr.blue.value.cgColor : ColorDr.red_text.value.cgColor
            containerView.layer.borderWidth = 1.0
        }
    }
    
    
    var placeHolder: String? {
        didSet {
            textField.placeholder = placeHolder
        }
    }

    var text: String? {
        didSet {
            textField.text = text
        }
    }

    var value: String? {
        get {
            return textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }

    var image: UIImage? {
        didSet {
            leftIconImageView.image = image
        }
    }
    

    var textFieldType: TextFieldType = .normal_with_icon {
        didSet {
            if textFieldType == .password {
                textField.isSecureTextEntry = true
            }
          
        }
    }
    
    // MARK: Component UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.asDesigned
        view.backgroundColor = ColorDr.blue_30_alpha.value

        return view
    }()
    
    private lazy var errorContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()
    
    private lazy var textField: CustomTextField = {
        let textField = CustomTextField()
        textField.delegate = self
        textField.setFontName(fontName: .regular, fontSize: 16.asDesigned)
        textField.textColor = ColorDr.black_text.value
        textField.setPlaceholderTextColor(color: ColorDr.black_text.withAlpha(0.5))
        textField.autocorrectionType = .no
        textField.smartQuotesType = .no
        textField.smartDashesType = .no
        textField.autocapitalizationType = .none
        textField.smartInsertDeleteType = .no
        textField.spellCheckingType = .no
        return textField
    }()
    
    private lazy var leftIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if textFieldType == .password {
            imageView.image = Asset.login_hidden_pass.image
        }
        if textFieldType == .bod {
            imageView.image = Asset.profile_bod_big.image
        }

        return imageView
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    // MARK: System
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
        addTapGesture()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: Function
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        typingCallBack?(textField.text)
    }
    private func setupUI() {
        backgroundColor = .white
        layer.masksToBounds = true
        clipsToBounds = true
        layer.cornerRadius = 15.asDesigned
        addSubview(errorContainerView)
        errorContainerView.addSubview(containerView)
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .valueChanged)
        containerView.addSubview(textField)
        
        errorContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        var borderWidth = 2.asDesigned
        if (isHasBorder) {
            borderWidth = 1.asDesigned
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(errorContainerView.snp.top).offset(borderWidth)
            make.left.equalTo(errorContainerView.snp.left).offset(borderWidth)
            make.right.equalTo(errorContainerView.snp.right).offset(-borderWidth)
            make.bottom.equalTo(errorContainerView.snp.bottom).offset(-borderWidth)
        }
        
        if textFieldType == .normal_no_icon {
            textField.snp.makeConstraints { make in
                make.height.equalToSuperview()
                make.left.equalToSuperview().offset(10.asDesigned)
                make.right.equalToSuperview().offset(-10.asDesigned)
            }
        } else {
            containerView.addSubview(leftIconImageView)
            
            leftIconImageView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(7.asDesigned)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(24.asDesigned)
            }
            
            
            if (textFieldType == .normal_with_icon) {
                textField.snp.makeConstraints { make in
                    make.height.equalToSuperview()
                    make.left.equalToSuperview().offset(11.asDesigned)
                    make.right.equalToSuperview().offset(-10.asDesigned)
                }
            } else {
                containerView.addSubview(rightButton)
                containerView.addSubview(rightIconImageView)
                
                rightButton.snp.makeConstraints { make in
                    make.right.centerY.equalToSuperview()
                    make.width.equalTo(40.asDesigned)
                    make.height.equalToSuperview()
                }
                
                rightIconImageView.snp.makeConstraints { make in
                    make.right.equalToSuperview().offset(-9.asDesigned)
                    make.centerY.equalToSuperview()
                    make.width.height.equalTo(24.asDesigned)
                }
                
                textField.snp.makeConstraints { make in
                    make.height.equalToSuperview()
                    make.left.equalToSuperview().offset(11.asDesigned)
                    make.right.equalTo(rightIconImageView.snp.left).offset(-10.asDesigned)
                }
                
            }
            
        }
    }
    
    @objc private func didTapRightIcon() {
        if textFieldType == .password {
            textField.isSecureTextEntry = !textField.isSecureTextEntry
            rightIconImageView.image = textField.isSecureTextEntry ? Asset.login_hidden_pass.image : Asset.login_un_hidden_pass.image
        }
        if textFieldType == .bod {
            
        }

    }
    
    private func addTapGesture() {
        rightButton.addTarget(self, action: #selector(didTapRightIcon), for: .touchUpInside)
    }
    
    func checkError() {
        // Update error background color to notice user about the error
        errorContainerView.backgroundColor = .red
        textField.setPlaceholderTextColor(color: .red)
        shake()
    }
    
    func setEditActions(notAllowed: [ResponderStandardEditActions]) {
        textField.filterEditActions(notAllowed: notAllowed)
    }
    
    func clear() {
        textField.text?.removeAll()
        resetTextFieldState()
    }
    
    func setResignFirstResponder() {
        textField.resignFirstResponder()
    }
    
    fileprivate func resetTextFieldState() {
        if (isHasBorder) {
            errorContainerView.backgroundColor = ColorDr.gray_text.value
        } else {
            errorContainerView.backgroundColor = .white
        }
        
        textField.setPlaceholderTextColor(color: ColorDr.blue.withAlpha(0.5))
    }
    
}

// MARK: UITextFieldDelegate
extension TextFieldDr: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        typingCallBack?(updatedString)
       

        if (textFieldType == .password) {
            if string == " " || string.contains(" ") {
                return false
            }
        }

        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textFieldType == .bod || textFieldType == .custom) {
            beginCallBack?()
            return false
        }
        return true
    }
    
}
