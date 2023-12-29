//
//  ViewController.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import UIKit

protocol MainScreenProtocol: AnyObject {
    
}

final class MainScreenViewController: UIViewController {

    //MARK: - UI
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    private lazy var startButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.setTitle("Start", for: .normal)
        button.addTarget(nil, action: #selector(startButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.setTitle("Settings", for: .normal)
        button.addTarget(nil, action: #selector(settingsButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var recordsButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.setTitle("Records", for: .normal)
        button.addTarget(nil, action: #selector(recordsButtonAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    var presenter: MainScreenPresenterProtocol?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        
    }
    
    //MARK: - Actions
    
    @objc
    private func startButtonAction() {
        showNewGameAlert()
    }
    
    @objc
    private func recordsButtonAction() {
        let view = ModuleBuilder().createRecordsScreen()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc
    private func settingsButtonAction() {
        let view = ModuleBuilder().createSettingsScreen()
        navigationController?.pushViewController(view, animated: true)
    }
    
    private func showNewGameAlert() {
        guard presentedViewController == nil else {
            return
        }
        
        let alert = UIAlertController(title: "Введите имя игрока", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        let apply = UIAlertAction(title: "Начать!", style: .default) { [weak self] _ in
            guard let tf = alert.textFields?.first, let playerName = tf.text else { return }
            let player = PlayerModel(name: playerName, score: nil)
            let view = ModuleBuilder().createRaceScreen(player: player)
            self?.navigationController?.pushViewController(view, animated: true)
        }
        alert.addAction(apply)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
}

private extension MainScreenViewController {
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupHierarchy() {
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(startButton)
        buttonStack.addArrangedSubview(recordsButton)
        buttonStack.addArrangedSubview(settingsButton)
    }
    
    func setupLayout() {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            buttonStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    
}

extension MainScreenViewController: MainScreenProtocol {
    
}
