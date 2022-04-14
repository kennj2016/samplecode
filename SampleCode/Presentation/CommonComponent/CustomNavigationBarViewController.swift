//
//  CustomNavigationBarViewController.swift
//  SampleCode
//
//  Created by  KenNguyen on 25/09/2021.
//

import UIKit
import ActionSheetPicker_3_0
class CustomNavigationBarViewController: BaseHiddenNavigationViewController {
    var didTapCameraButton: (() -> ())?
    var didTapQrButton: (() -> ())?
    var callBack: ((_ value: Any?) -> ())?

    // MARK: Properties
    var navigationTitle: String = "" {
        didSet {
            navigationBarView.title = navigationTitle
        }
    }
    
    var isRoundTopLeftRight = false {
        didSet {
            viewBlue.backgroundColor = isRoundTopLeftRight ? ColorDr.blue.value : UIColor.white
        }
    }
    
    // MARK: Component UI
    lazy var navigationBarView = NavigationBarView()
    lazy var viewBlue = UIView()

    var isHasRightButton: Bool = false {
        didSet {
            navigationBarView.isHasRightButton = isHasRightButton
        }
    }
    // MARK: System
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        handleDidTapBackButton()
        handleDidTapRightButton()
        handleDidTapCameraButton()
        handleDidTapQRButton()

    }
    
    // MARK: Function
    private func setupUI() {
        view.addSubview(navigationBarView)
        view.insertSubview(viewBlue, at: 0)

        // Navigation Bar
        navigationBarView.snp.makeConstraints { make in
            make.height.equalTo(50.asDesigned + statusBarHeight)
            make.top.left.right.equalToSuperview()
        }
        
        //View Blue
        viewBlue.snp.makeConstraints { make in
            make.height.equalTo(SCREEN_HEIGHT/2)
            make.top.left.right.equalToSuperview()
        }
    }
    
    private func handleDidTapBackButton() {
        navigationBarView.didTapBackButton = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func handleDidTapRightButton() {
        navigationBarView.didTapRightButton = {
            self.navigationController?.pushViewController(LegalVC(), animated: true)
        }
    }
    
    private func handleDidTapCameraButton() {
        navigationBarView.didTapCameraButton = {
            self.didTapCameraButton!()
        }
    }
    
    private func handleDidTapQRButton() {
        navigationBarView.didTapQrButton = {
            self.didTapQrButton!()
        }
    }
    
}
class CustomNavibarProfile: CustomNavigationBarViewController {
    var isHasRightProfileButton: Bool = false {
        didSet {
            navigationBarView.isHasRightProfileButton = isHasRightProfileButton
        }
    }
}

class CustomPickerNavibarProfile: CustomNavigationBarViewController {
    func showDatePicker(origin : UIView, _ mode : UIDatePicker.Mode = .date,  completeHandler: @escaping(_ item : Date?)->()) {
        ActionSheetDatePicker.show(withTitle: "", datePickerMode: mode, selectedDate: Date(), doneBlock: { (picker, selectedDate, orgin) in
            guard let selectedDate = selectedDate as? Date else {
                completeHandler(nil)
                return
            }
            completeHandler(selectedDate)
        }, cancel: { (picker) in
            
        }, origin: origin)
    }

    func showInforPicker(items:[String], initialSelection : Int = 0, completeHandler: @escaping(_ item : String?, _ index : Int?)->()) {
        guard let rootView = SHARE_APPLICATION_DELEGATE.window?.rootViewController else {return}
        ActionSheetStringPicker.show(withTitle: "", rows: items as [Any] , initialSelection: initialSelection, doneBlock: { (picker, index, orgin) in
            completeHandler(items[index], index)
        }, cancel: { (picker) in
            completeHandler(nil, nil)
        }, origin: rootView.view)
    }

}


