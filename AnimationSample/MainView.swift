//
//  MainView.swift
//  AnimationSample
//
//  Created by Yasin Akbaş on 2.01.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import UIKit

protocol MainViewDelegate: class {
    func mainView(_ mainView: MainView, didTapClickMeButton button: UIButton)
    func mainView(_ mainView: MainView, didTapSendMessageButton button: UIButton, text textField: UITextField)
}

extension MainViewDelegate {
    func mainView(_ mainView: MainView, didTapSendMessageButton button: UIButton, text textField: UITextField) { }
}

final class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    private lazy var layout = Layout(bounds: bounds)
    
    private lazy var form = FormView(frame: layout.formFrame)
    private lazy var clickMeButton: UIButton = {
        let button = UIButton()
        button.frame = layout.clickMeButtonFrame
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.setTitle("Click Me", for: .normal)
        button.layer.cornerRadius = layout.clickMeButtonFrame.height / 2
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setListeners()
        setupViews()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented.")
    }
    
    private func setListeners() {
        form.delegate = self
    }
    
    private func setupViews() {
        setupButton()
        setupForm()
    }
    
    private func setupButton() {
        addSubview(clickMeButton)
    }
    
    private func setupForm() {
        
        form.center = center
        addSubview(form)
        form.alpha = 0
    }
    
    @objc
    func buttonClicked(_ button:UIButton) {
        print("-> clicked: clickMeButton")
        delegate?.mainView(self, didTapClickMeButton: button)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                UIView.transition(
                    with: self.form,
                    duration: 0.4,
                    options: .transitionFlipFromLeft,
                    animations: { self.form.alpha = 1 },
                    completion: nil
                )
            }
        }, completion: { _ in self.clickMeButton.removeFromSuperview() })
    }
    
    private struct Layout {
        private var bounds: CGRect
        init(bounds: CGRect) { self.bounds = bounds }
        lazy var clickMeButtonFrame = CGRect(x: bounds.width / 2 - 100, y: bounds.height / 2 - 25, width: 200, height: 50)
        lazy var formFrame = CGRect(width: bounds.width - 40, height: bounds.height / 4)
    }
}

extension MainView: FormViewDelegate {
    func formView(_ formView: FormView, didTapSendMessageButton button: UIButton, text textfield: UITextField) {
        delegate?.mainView(self, didTapSendMessageButton: button, text: textfield)
    }
}
