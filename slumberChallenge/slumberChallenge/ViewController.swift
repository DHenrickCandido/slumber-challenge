//
//  ViewController.swift
//  slumberStudioChallenge
//
//  Created by Diego Henrick on 02/10/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let timerLabel = UILabel()
    var timerManager: TimerManager?

    let squareRed = SquareView(color: .red, text: NSLocalizedString("red_square_label", comment: ""), textAlignment: .left, textStyle: .body)
    let squareWhite = SquareView(color: .white, text: NSLocalizedString("white_rectangle_label", comment: ""), textAlignment: .center, textStyle: .body)
    let squareBlue = SquareView(color: .blue, text: NSLocalizedString("blue_square_label", comment: ""), textAlignment: .right, textStyle: .body)
    let squarePurple = SquareView(color: .purple, text: NSLocalizedString("purple_rectangle_label", comment: ""), textAlignment: .center, textStyle: .caption2)
    
    
    var whitePressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(squareRed)
        view.addSubview(squareWhite)
        squareWhite.addSubview(squarePurple)
        view.addSubview(squareBlue)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleWhiteSquareTap))
        squareWhite.addGestureRecognizer(tapGesture)
        squareWhite.isUserInteractionEnabled = true

        setupConstraints()

        setupTimer()
    }
    
    private func setupConstraints() {
        squareRed.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(170)
            make.height.equalTo(170)

        }

        squarePurple.snp.makeConstraints { make in
            make.top.equalTo(squareWhite.label.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        setupWhiteSquareConstraints()
        
        squareBlue.snp.makeConstraints { make in
            make.top.equalTo(squareWhite.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)

        }

        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.text = "00:00:00.000"
        view.addSubview(timerLabel)
        
        timerLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)

        }
    }
    
    private func setupTimer() {
        timerManager = TimerManager()
        
        timerManager?.onUpdate = { [weak self] timeString in
            self?.timerLabel.text = timeString
        }
        
        timerManager?.startTimer()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            self.updatePurpleSquareVisibility(for: UIDevice.current.orientation)
        })
    }

    private func updatePurpleSquareVisibility(for orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait, .portraitUpsideDown:
            squarePurple.isHidden = false
        case .landscapeLeft, .landscapeRight:
            squarePurple.isHidden = true
        default:
            break
        }
    }
    
    private func setupWhiteSquareConstraints() {
        squareWhite.snp.remakeConstraints { make in
            make.top.equalTo(squareRed.snp.bottom).offset(20)
            
            if whitePressed {
                make.leading.equalTo(squareRed.snp.trailing)
                make.trailing.equalTo(squareBlue.snp.leading)
            } else {
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
        }
    }

    @objc func handleWhiteSquareTap() {
        whitePressed.toggle()
        setupWhiteSquareConstraints()
        resetTimerAction()

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func resetTimerAction() {
        timerManager?.resetTimer()
    }

    deinit {
        timerManager?.stopTimer()
    }
}

