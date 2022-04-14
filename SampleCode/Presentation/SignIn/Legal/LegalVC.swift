//
//  LegalVC.swift
//  sample
//
//  Created by KenNguyen 12/10/2021.
//

import UIKit
enum LegalValues: String, CaseIterable {
    case term = "Terms of Service"
    case policy = "Privacy Policy"
}
class LegalVC: CustomNavigationBarViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(nibWithCellClass: LegalTBCell.self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationTitle = "Legal".localized()
        self.isRoundTopLeftRight = true
    }

    

}
extension LegalVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LegalValues.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LegalTBCell.self, for: indexPath)
        cell.lbName.text = LegalValues.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = LegalValues.allCases[indexPath.row]
        let appConfiguration = AppConfiguration()

        if item == .term {
            guard let url = URL(string: appConfiguration.termOfServiceURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        if item == .policy {
            guard let url = URL(string: appConfiguration.policyURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
