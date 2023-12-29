//
//  RecordsScreenViewController.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation
import UIKit

protocol RecordsScreenProtocol: AnyObject {
    func updateView()
}

final class RecordsScreenViewController: UIViewController {
    
    
    //MARK: - Properties
    var presenter: RecordsScreenPresenterProtocol?
    
    //MARK: - UI
    
    private lazy var recordsTableView: UITableView = {
        let table = UITableView()
        table.register(RecordCell.self, forCellReuseIdentifier: RecordCell.id)
        return table
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        setupDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getRecords()
    }
    
    //MARK: - Actions
    
    private func setupDelegates() {
        recordsTableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "clear", style: .plain, target: self, action: #selector(navButtonTapped))
    }
    
    @objc private func navButtonTapped() {
        
        presenter?.removeRecords()
    }
}

private extension RecordsScreenViewController {
    
    func setupHierarchy() {
        view.addSubview(recordsTableView)
    }
    
    func setupLayout() {
        recordsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            recordsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recordsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recordsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recordsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RecordsScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.records.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.id, for: indexPath) as? RecordCell else {
            return UITableViewCell()
        }
        if let player = presenter?.records[indexPath.row] {
            cell.setupUI(player: player)
            
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            return UITableViewCell()
        }
    }
}


extension RecordsScreenViewController: RecordsScreenProtocol {
    func updateView() {
        recordsTableView.reloadData()
    }
}
