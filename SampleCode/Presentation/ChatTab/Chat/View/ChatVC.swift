//
//  ChatVC.swift
//  SampleCode
//
//  Created by KenNguyen 04/10/2021.
//

import UIKit

class ChatVC: BaseViewController {

    //MARK: IBOUTLETS
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(nibWithCellClass: ChatTBCell.self)
        }
    }
    //MARK: OTHER VARIABLES
    var viewModel:ChatListViewModel!
    var nextPageLoadingSpinner: UIActivityIndicatorView?
    
    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: ChatListViewModel) -> ChatVC {
        let view = ChatVC()
        view.viewModel = viewModel
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
            setupVar()
            setupUI()
            bind(to: viewModel)
            viewModel.viewDidLoad()

    }
    
    //MARK: - SETUP UI & VAR
    func setupVar() {

    }
    
    
    func setupUI() {
    
    }
    
    //MARK - CALL API
    private func bind(to viewModel: ChatListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.loading.observe(on: self) { [weak self] in
            self?.updateLoading($0)
        }
        
        viewModel.query.observe(on: self) { [weak self] in
            //search
            print($0)
        }
        
        viewModel.error.observe(on: self) { [weak self] in
            self?.showToastMessage(message: $0)
        }
    }
    
    func updateLoading(_ loading: ChatListViewModelLoading?) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
        case .fullScreen, .none:
            tableView.tableFooterView = nil
        }
    }
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatVC:UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ChatTBCell.self, for: indexPath)
//        cell.fill(with: viewModel.items.value[indexPath.row])
//        if indexPath.row == viewModel.items.value.count - 1 {
//            //Load more
//            viewModel.didLoadNextPage()
//        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
//        return viewModel.isEmpty ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
