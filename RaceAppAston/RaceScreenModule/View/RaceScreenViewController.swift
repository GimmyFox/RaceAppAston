//
//  RaceScreenViewController.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation
import UIKit

protocol RaceScreenProtocol: AnyObject {
    func showAlert()
    func tryAgain()
}

final class RaceScreenViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: RaceScreenPresenterProtocol?
    private var displayLink: CADisplayLink?
    
    //MARK: - UI
    private lazy var carView = UIView(frame: CGRect(x: Constants.xCoordinateCar, y: Constants.yCoordinateCar, width: Constants.objWidth, height: Constants.objWidth))
    private lazy var hitViews: [UIView] = []
    private lazy var scoreLabel = UILabel(frame: CGRect(x: UIGrid.ScreenSize.screenWidth / 2 - 75, y: UIGrid.ScreenSize.screenHeight / 5, width: 200, height: 60))
    private var animator: UIViewPropertyAnimator?
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        displayLink = CADisplayLink(target: self, selector: #selector(checkIntersection))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHitObjectsView()
        hitViews.forEach({createAnimation($0)})
        setupCar()
        setupLabel()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        displayLink?.invalidate()
        displayLink = nil
    }

    //MARK: - Setup UI
    
    private func setupHitObjectsView() {
        for i in 0...4 {
            let xCoordHitObj = (CGFloat(i) * Constants.roadWidth) + (Constants.objWidth / 2)
            let hitObj = UIView(frame: CGRect(x: xCoordHitObj, y: Constants.defaultYObjPosition, width: Constants.objWidth, height: Constants.objWidth))
            hitObj.backgroundColor = .purple
            view.addSubview(hitObj)
            hitViews.append(hitObj)
        }
    }
    
    private func setupLabel() {
        guard let presenter else {return}
        scoreLabel.text = "Score: \(presenter.score)"
        scoreLabel.textColor = .black
        scoreLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        view.addSubview(scoreLabel)
    }
    
    private func setupCar() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(moveCar))
        carView.addGestureRecognizer(gesture)
        carView.backgroundColor = .darkGray
        view.addSubview(carView)
    }
    
    //MARK: - UI methods
    
    @objc
    private func moveCar(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: carView)
        gesture.setTranslation(.zero, in: carView)
        var newCenter = carView.center
        newCenter.x += translation.x
        carView.center = newCenter
        
    }
    
    @objc
    private func checkIntersection() {
        for i in hitViews {
            let pos = i.layer.presentation()
            guard let cur = pos?.frame else {return}
            if cur.intersects(carView.frame) {
                hitViews.forEach({$0.isHidden = true})
                displayLink?.invalidate()
                displayLink = nil
                animator?.stopAnimation(true)
                carView.isHidden = true
                carView.isUserInteractionEnabled = false
                presenter?.showAlert()
            }
        }
    }
    
    private func createAnimation(_ view: UIView) {
        guard var presenter else {return}
        animator = UIViewPropertyAnimator(duration: presenter.getDuration(), curve: .linear, animations: {
            view.frame.origin.y += self.view.frame.height + Constants.overScreenYObjPostion
        })
        animator?.addCompletion({ [weak self] state in
            switch state {
            case .current:
                fallthrough
            case .end:
                if let _ = self?.displayLink {
                    presenter.score += 1
                    self?.updateLabel(with: presenter.score)
                    view.frame.origin.y = Constants.defaultYObjPosition
                    self?.createAnimation(view)
                    print("end")
                }
            case .start:
                fallthrough
            @unknown default:
                return
            }
        })
        animator?.startAnimation(afterDelay: .random(in: 0...3))
        
    }
    
    
    
    private func updateLabel(with score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
    deinit {
        print("deinited")
        
        print("tread: \(Thread.isMainThread) ||| \(Thread.current)")
    }
}

extension RaceScreenViewController: RaceScreenProtocol {
    func tryAgain() {
        guard var presenter else {return}
        presenter.score = 0
        hitViews.forEach({$0.frame.origin.y = Constants.defaultYObjPosition})
        updateLabel(with: presenter.score)
        displayLink = CADisplayLink(target: self, selector: #selector(checkIntersection))
        displayLink?.add(to: .main, forMode: .common)
        hitViews.forEach({$0.isHidden = false})
        hitViews.forEach({createAnimation($0)})
        carView.isHidden = false
        carView.isUserInteractionEnabled = true
        
    }
    
    func showAlert() {
        
        guard presentedViewController == nil else {
            return
        }
        
        let alert = UIAlertController(title: "Игра закончена!", message: "Итоговый счет: \(presenter?.score ?? 00900)", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Выйти", style: .default) { [weak self] _ in
            if let presenter = self?.presenter {
                presenter.saveRecord(record: presenter.player)
            }
            self?.navigationController?.popViewController(animated: true)
        }
        let apply = UIAlertAction(title: "Начать заново", style: .default) { [weak self] _ in
            if let presenter = self?.presenter {
                presenter.saveRecord(record: presenter.player)
            }
            self?.presenter?.tryAgain()
        }
        alert.addAction(apply)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    
}

private extension RaceScreenViewController {
    enum Constants {
        static let defaultYObjPosition: CGFloat = -50
        static let overScreenYObjPostion: CGFloat = 150
        static let roadWidth = UIGrid.ScreenSize.screenWidth / 5
        static let objWidth = roadWidth / 2
        static let xCoordinateCar = (UIGrid.ScreenSize.screenWidth / 2) - (Constants.objWidth / 2)
        static let yCoordinateCar = UIGrid.ScreenSize.screenHeight - 3 * Constants.objWidth
    }
}

