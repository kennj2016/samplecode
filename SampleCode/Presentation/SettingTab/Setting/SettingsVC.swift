//
//  SettingsVC.swift
//  SampleCode
//
//  Created by KenNguyen 04/10/2021.
//

import UIKit

class SettingsVC: CustomNavigationBarViewController {

    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(nibWithCellClass: SettingTBCell.self)
            tableView.register(nibWithCellClass: STHeaderTBCell.self)
            tableView.reloadData()
        }
    }
    //MARK: OTHER VARIABLES
    private var viewModel:AuthenViewModel!
    var versions: [String] = ["Version: 2.0.X - Beta", "Server version: 3.11.X", "Logout"]
    
    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: AuthenViewModel) -> SettingsVC {
        let view = SettingsVC()
        view.viewModel = viewModel
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDebugs()
        handleEvent()
        bind(to: viewModel)
    }
    
    //MARK: - SETUP VIEW
    private func setupViews() {
        self.navigationBarView.backButton.isHidden = true
    }
    
    private func setupDebugs() {
        
    }
    
    //MARK: - HANDLE EVENT & BIND VIEWMODLE
    func handleEvent() {
       
    }
    
    private func bind(to viewModel: AuthenViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.errorMessage($0) }
    }
    
    private func setValueLanguage() {
        
    }
    
    
    // MARK: API SERVICE
    private func signIn() {
        hideKeyboard()
//        viewModel.signIn(email: tfEmail.value ?? "", password: tfPassword.value ?? "")
    }
    
    // MARK: OBSERVE & ACTION
    private func errorMessage(_ error: String) {
        guard !error.isEmpty else { return }
//        self.lbError.isHidden = false
    }

}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return versions.count
        }
        return SettingSelection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView()
            view.backgroundColor = ColorDr.gray_bg.value
            return view
        }
        let cell = tableView.dequeueReusableCell(withClass: STHeaderTBCell.self)
        cell.callBackWithAction = {
            self.navigationController?.pushViewController(ProfileVC.create(with: self.viewModel), animated: true)
//                SHARE_APPLICATION_DELEGATE.appFlowCoordinator!.gotoProfile()

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 15
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SettingTBCell.self, for: indexPath)
        if indexPath.section == 0 {
            let item = SettingSelection.allCases[indexPath.row]
            cell.fill(with: item.textValue, image: item.image, sub_name: "", isRight: true)
        }else {
            cell.fill(with: versions[indexPath.row], image: nil, sub_name: nil, isRight: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == versions.count - 1 {
//                self.navigationController?.pushViewController(ProfileVC.create(with: self.viewModel), animated: true)

                
                AppConfiguration.logout()
                SHARE_APPLICATION_DELEGATE.appFlowCoordinator?.flow.gotoSignIn()
                self.showToastMessage(message: "logout")

            }
        }
    }
    
    
}
