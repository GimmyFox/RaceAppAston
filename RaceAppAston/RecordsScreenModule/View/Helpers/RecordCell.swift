//
//  RecordCell.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 28.11.2023.
//

import Foundation
import UIKit


class RecordCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let id = String(describing: type(of: RecordCell.self))
    
    
    //MARK: - UI
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        scoreLabel.text = nil
    }
    
    
    func setupUI(player: PlayerModel) {
        nameLabel.text = "name: \(player.name)"
        scoreLabel.text = "score: \(player.score ?? 0000)"
    }
    
}

private extension RecordCell {
    func commonInit() {
        setupHierarcy()
        setupLayout()
    }
    func setupHierarcy() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreLabel)
    }
    
    func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIGrid.Padding.padding5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIGrid.Padding.padding16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIGrid.Padding.padding16)
        ])
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIGrid.Spacing.spacing5),
            scoreLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            scoreLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIGrid.Padding.padding5)
        ])
    }
}
