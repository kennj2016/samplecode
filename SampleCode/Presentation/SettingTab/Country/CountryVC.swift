//
//  CountryVC.swift
//  sample
//
//  Created by KenNguyen 25/10/2021.
//

import UIKit


class CountryVC: CustomNavigationBarViewController {

    //MARK: IBOUTLETS
    @IBOutlet weak var tfSearch: TextFieldDr! {
        didSet {
            tfSearch.placeHolder = "Search".localized()
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(nibWithCellClass: CountryTBCell.self)
            tableView.reloadData()
        }
    }
    //MARK: OTHER VARIABLES
    private var viewModel:CountryViewModel!
    
    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: CountryViewModel) -> CountryVC {
        let view = CountryVC()
        view.viewModel = viewModel
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDebugs()
        handleEvent()
        bind(to: viewModel)
        getAllCountry()
    }
    
    //MARK: - SETUP VIEW
    private func setupViews() {
    }
    
    private func setupDebugs() {
        
    }
    
    //MARK: - HANDLE EVENT & BIND VIEWMODLE
    func handleEvent() {
        tfSearch.typingCallBack = {(value) in
            guard let value = value else {
                return
            }
            self.viewModel.getFindCountry(key: value)
        }
    }
    
    private func bind(to viewModel: CountryViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.errorMessage($0) }
        viewModel.country.observe(on: self) { profile in
            //
            self.tableView.reloadData()
        }
    }
    
    private func setValueLanguage() {
        
    }
    
    
    // MARK: API SERVICE
    private func getAllCountry() {
        hideKeyboard()
        viewModel.getAllCountry()
        
    }
    
    // MARK: OBSERVE & ACTION
    private func errorMessage(_ error: String) {
        guard !error.isEmpty else { return }
//        self.lbError.isHidden = false
    }

}
extension CountryVC: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.country.value.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CountryTBCell.self, for: indexPath)
        let item = viewModel.country.value[indexPath.row]
        cell.fillData(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.callBack != nil {
            let item = viewModel.country.value[indexPath.row]
            self.callBack!(item)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
