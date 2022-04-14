//
//  SampleCodeVC.swift
//  SampleCode
//
//  Created by KenNguyen 04/10/2021.
//

import UIKit

class HomeVC: BaseViewController {

    //MARK: IBOUTLETS
   
    //MARK: OTHER VARIABLES
    private var viewModel:AuthenViewModel!
   
    
    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: AuthenViewModel) -> HomeVC {
        let view = HomeVC()
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
