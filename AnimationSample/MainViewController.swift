//
//  MainViewController.swift
//  AnimationSample
//
//  Created by Yasin Akbaş on 2.01.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var message = MessageManager(view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = MainView(frame: view.bounds)
        setListeners()
    }
    
    private func setListeners() {
        guard let view = view as? MainView else { return }
        view.delegate = self
    }
}

extension MainViewController: MainViewDelegate {
    func mainView(_ mainView: MainView, didTapSendMessageButton button: UIButton, text textField: UITextField) {
        print("-> listened: didTapClickMeButton")
        message.send(textField.text!, type: .success)
    }
    
    func mainView(_ mainView: MainView, didTapClickMeButton button: UIButton) {
        print("-> listened: didTapSendMessageButton")
    }    
}
