//
//  MessageManager.swift
//  AnimationSample
//
//  Created by Yasin Akbaş on 3.01.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import UIKit

enum MessageType {
    case success, error, warning
}

final class MessageManager: UIView {
    private lazy var layout = Layout(bounds: bounds)
    private var view: UIView
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: layout.titleLabelFrame)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.font = label.font.withSize(18)
        return label
    }()
    
    private lazy var closeButton: UIImageView = {
        let imageView = UIImageView(frame: layout.closeButtonFrame)
        imageView.image = #imageLiteral(resourceName: "close")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonClicked(_:))))
        return imageView
    }()
    
    init(_ view: UIView) {
        self.view = view
        super.init(frame:CGRect(x:0,y:-100,width:view.bounds.width,height:100))
        view.addSubview(self)
        configureAppearance()
        setupViews()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func typeHandle(type: MessageType) -> String {
        switch type {
        case .success:
            backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            return "Success: "
        case .warning:
            backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            return "Warning: "
        case .error:
            backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return "Error: "
        }
    }
    
    private func configureAppearance() {
        backgroundColor = .yellow
    }
    
    private func setupViews() {
        setupTitleLabel()
        setupCloseButton()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
    }
    
    private func setupCloseButton() {
        addSubview(closeButton)
    }
    
    func send(_ message: String..., type: MessageType) {
        titleLabel.text = typeHandle(type: type) + message.joined(separator: " ")
        UIView.animate(withDuration: 0.7) {
            self.frame.origin.y += 100
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.dismiss()
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.7) {
            self.frame.origin.y -= 100
        }
    }
    
    private struct Layout {
        private var bounds: CGRect
        init(bounds: CGRect) { self.bounds = bounds }
        lazy var titleLabelFrame = CGRect(x: 10, y: 10, width: bounds.width - 50, height: 100)
        lazy var closeButtonFrame = CGRect(x: bounds.width - 60, y: bounds.height / 2 - 10 + 10, width: 20, height: 20)
    }
}

extension MessageManager {
    @objc
    func closeButtonClicked(_ button: UIButton) {
        print("-> clicked: closeButton")
        dismiss()
    }
}
