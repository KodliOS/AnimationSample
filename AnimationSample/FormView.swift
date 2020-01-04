//
//  containerViewcontainerView.swift
//  AnimationSample
//
//  Created by Yasin Akbaş on 2.01.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import UIKit

protocol FormViewDelegate: class {
    func formView(_ formView: FormView, didTapSendMessageButton button: UIButton, text textfield: UITextField)
}

final class FormView: UIView {
    weak var delegate :FormViewDelegate?
    private lazy var layout = Layout(bounds: bounds)
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: layout.containerViewFrame)
        containerView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 10
        return containerView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: layout.titleFrame)
        label.text = "Send Message"
        label.textColor = .white
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: layout.textFieldFrame)
        textField.center = containerView.center
        textField.backgroundColor = .white
        textField.layer.cornerRadius = textField.bounds.height / 2
        textField.leftView = UIView(frame: CGRect(width: 15, height: textField.bounds.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(width: 15, height: textField.bounds.height))
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        textField.placeholder = "Please enter your message"
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(frame: layout.sendButtonFrame)
        button.center.x = containerView.center.x
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(sendButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        setupViews()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented.")
    }
    
    private func configureAppearance() {
        addSubview(containerView)
        containerView.center = self.center
        containerView.alpha = 1
    }
    
    private func setupViews() {
        setupTitle()
        setupTextField()
        setupSendButton()
    }
    
    private func setupTitle() {
        containerView.addSubview(title)
    }
    
    private func setupTextField() {
        containerView.addSubview(textField)
    }
    
    private func setupSendButton() {
        containerView.addSubview(sendButton)
    }
    
    @objc
    private func sendButtonClicked(_ button: UIButton) {
        print("-> clicked: sendButton")
        delegate?.formView(self, didTapSendMessageButton: button, text: textField)
        UIView.animate(
            withDuration: 0.7,
            animations: { self.transform = CGAffineTransform(translationX: 0, y: 1000) },
            completion: { _ in
                self.endEditing(true)
            }
        )
    }
    
    private struct Layout {
        private var bounds: CGRect
        lazy var gridHeight = containerViewFrame.height / 7
        init(bounds: CGRect) { self.bounds = bounds }
        lazy var containerViewFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        lazy var textFieldFrame = CGRect(width: containerViewFrame.width - 40, height: 30)
        lazy var titleFrame = CGRect(x: 0, y: gridHeight, width: containerViewFrame.width, height: gridHeight)
        lazy var sendButtonFrame = CGRect(x: 0, y: containerViewFrame.height - gridHeight - 10, width: containerViewFrame.width - 40, height: gridHeight)
    }
}

