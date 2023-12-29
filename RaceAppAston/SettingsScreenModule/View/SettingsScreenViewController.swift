//
//  SettingsScreenViewController.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation
import UIKit


protocol SettingsScreenProtocol: AnyObject {
    func setupColorButton(difficulty: Difficulty)
    func getInitialDifficulty()
}

final class SettingsScreenViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: SettingsScreenPresenterProtocol?
    private var defaultColor: UIColor = .blue
    
    //MARK: - UI
    
    private lazy var difficultyLabeL: UILabel = {
        let label = UILabel()
        label.text = "Выберите сложность"
        label.textColor = .black
        return label
    }()
    
    
    private lazy var difficultyButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = UIGrid.Spacing.spacing15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var easyButton: UIButton = {
        let button = UIButton()
        button.setTitle(Difficulty.easy.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = UIGrid.CornerRadius.cr10
        button.addTarget(nil, action: #selector(easyTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mediumButton: UIButton = {
        let button = UIButton()
        button.setTitle(Difficulty.medium.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = UIGrid.CornerRadius.cr10
        button.addTarget(nil, action: #selector(mediumTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var hardButton: UIButton = {
        let button = UIButton()
        button.setTitle(Difficulty.hard.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = UIGrid.CornerRadius.cr10
        button.addTarget(nil, action: #selector(hardTapped), for: .touchUpInside)
        return button
    }()
    

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupHierarchy()
        setupLayout()
        getInitialDifficulty()
    }
    
    
    //MARK: - Button actions
    @objc
    private func easyTapped(sender: UIButton) {
        guard var presenter else {return}
        presenter.changeDifficulty(.easy)
    }
    
    @objc
    private func mediumTapped(sender: UIButton) {
        guard var presenter else {return}
        presenter.changeDifficulty(.medium)
    }
    
    @objc
    private func hardTapped(sender: UIButton) {
        guard var presenter else {return}
        presenter.changeDifficulty(.hard)
    }
}

private extension SettingsScreenViewController {
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupHierarchy() {
        view.addSubview(difficultyLabeL)
        view.addSubview(difficultyButtonStack)
        difficultyButtonStack.addArrangedSubview(easyButton)
        difficultyButtonStack.addArrangedSubview(mediumButton)
        difficultyButtonStack.addArrangedSubview(hardButton)
    }
    
    func setupLayout() {
        
        difficultyLabeL.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            difficultyLabeL.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.diffLVLTopAnchor),
            difficultyLabeL.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.diffLVLLeadingAnchor),
            difficultyLabeL.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.diffLVLTrailingAnchor),
            difficultyLabeL.heightAnchor.constraint(equalToConstant: Constants.diffLVLHeightAnchor)
        ])
        
        difficultyButtonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            difficultyButtonStack.topAnchor.constraint(equalTo: difficultyLabeL.bottomAnchor, constant: Constants.buttonStackTopAnchor),
            difficultyButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonStackLeadingAnchor),
            difficultyButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonStackTrailingAnchor),
            difficultyButtonStack.heightAnchor.constraint(equalToConstant: Constants.buttonStackHeightAnchor)
        ])
    }
}

extension SettingsScreenViewController: SettingsScreenProtocol {
    func setupColorButton(difficulty: Difficulty) {
        switch difficulty {
        case .easy:
            easyButton.backgroundColor = .green
            mediumButton.backgroundColor = defaultColor
            hardButton.backgroundColor = defaultColor
        case .medium:
            mediumButton.backgroundColor = .green
            easyButton.backgroundColor = defaultColor
            hardButton.backgroundColor = defaultColor
        case .hard:
            hardButton.backgroundColor = .green
            easyButton.backgroundColor = defaultColor
            mediumButton.backgroundColor = defaultColor
        }
    }
    
    func getInitialDifficulty() {
        guard let presenter else {return}
        presenter.changeDifficulty(presenter.getInitialDifficulty())
    }
}

private extension SettingsScreenViewController {
    enum Constants {
        static let diffLVLTopAnchor: CGFloat = 15
        static let diffLVLLeadingAnchor: CGFloat = 30
        static let diffLVLTrailingAnchor: CGFloat = -30
        static let diffLVLHeightAnchor: CGFloat = 40
        static let buttonStackTopAnchor: CGFloat = 30
        static let buttonStackLeadingAnchor: CGFloat = 30
        static let buttonStackTrailingAnchor: CGFloat = -30
        static let buttonStackHeightAnchor: CGFloat = 50
    }
}
