//
//  ViewController.swift
//  JWTSample
//
//  Created by iMac on 2022/10/06.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    private lazy var tokenLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .label
        
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        label.layer.cornerRadius = 8.0
        
        label.numberOfLines = 0
        label.text = ""
        
        return label
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Copy", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.label.withAlphaComponent(0.3), for: .highlighted)
        
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        
        button.isHidden = true
        
        button.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        return button
    }()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

private extension ViewController {
    func setupViews() {
        [
            tokenLabel,
            copyButton,
            tokenButton
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        tokenLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            
        }
        
        copyButton.snp.makeConstraints {
            $0.top.equalTo(tokenLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.height.equalTo(50.0)
        }
        
        tokenButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            
        }
    }
    
    @objc
    func didTapGenerateButtonAction() {
        let token = JWTGenerator.generateJWT()
        tokenLabel.text = token
        
        copyButton.isHidden = false
    }
    
    @objc
    func didTapCopyButton() {
        guard let token = tokenLabel.text else {
            let alert = UIAlertController(title: "빈 텍스트", message: "토큰 생성 후 사용해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        if token == "" {
            let alert = UIAlertController(title: "빈 텍스트", message: "토큰 생성 후 사용해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
        } else {
            UIPasteboard.general.string = token
            
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "checkmark")
            imageView.tintColor = .green
            
            view.addSubview(imageView)
            
            imageView.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.height.width.equalTo(50.0)
            }
            
            UIView.animate(
                withDuration: 3.0,
                delay: 0.0,
                usingSpringWithDamping: 1.0,
                initialSpringVelocity: 1.0,
                options: .curveEaseInOut,
                animations: {
                    imageView.alpha = 0
                },
                completion: { _ in
                    imageView.removeFromSuperview()
                }
            )
            
        }
    }
}

