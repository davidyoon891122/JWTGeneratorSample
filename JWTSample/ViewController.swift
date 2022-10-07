//
//  ViewController.swift
//  JWTSample
//
//  Created by iMac on 2022/10/06.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    private lazy var tokenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate", for: .normal)
        
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.label.withAlphaComponent(0.30), for: .highlighted)
        
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        
        button.addTarget(self, action: #selector(didTapGenerateButtonAction), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        JWTGenerator.generateJWT()
    }
}

private extension ViewController {
    func setupViews() {
        [
            tokenButton
        ]
            .forEach {
                view.addSubview($0)
            }
        
        tokenButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(150.0)
            $0.height.equalTo(50.0)
        }
    }
    
    @objc
    func didTapGenerateButtonAction() {
        JWTGenerator.generateJWT()
    }
}

