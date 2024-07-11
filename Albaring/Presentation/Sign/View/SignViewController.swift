//
//  SignViewController.swift
//  Albaring
//
//  Created by LJh on 7/10/24.
//

import UIKit
import SnapKit
import SwiftUI

class SignViewController: UIViewController {

    private let test_Title: UILabel = {
        let label = UILabel()
        label.text = "SNS계정으로 간편 로그인하기"
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        if let kakaoImage = UIImage(named: "kakao_login") {
            button.setImage(kakaoImage, for: .normal)
        }
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        if let googleImage = UIImage(named: "google_login") {
            button.setImage(googleImage, for: .normal)
        }
        return button
    }()
    
    private lazy var naverLoginButton: UIButton = {
        let button = UIButton()
        if let naverImage = UIImage(named: "naver_login") {
            button.setImage(naverImage, for: .normal)
        }
        return button
    }()
    
    // triangleLabel 정의
    private let triangleLabel: TriangleLabel = {
        let label = TriangleLabel()
        label.backgroundColor = UIColor(hexCode: "FF5C00", alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let descriptionLabel: InnerPaddedLabel = {
        let label = InnerPaddedLabel()
        label.text = "3초만에 로그인!"
        label.numberOfLines = 0
        label.textColor = .white
        label.layer.backgroundColor = UIColor(hexCode: "FF5C00", alpha: 1.0).cgColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true // 코너 반경 설정을 위해 추가
        return label
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubViews()
        setupConstraints()
    }
}

extension SignViewController {
    private func addSubViews() {
        for stackViewItem in [kakaoLoginButton, naverLoginButton, googleLoginButton] {
            loginStackView.addArrangedSubview(stackViewItem)
        }
        
        for viewItem in [test_Title,triangleLabel, descriptionLabel, loginStackView] {
            view.addSubview(viewItem)
        }
    }
    
    private func setupConstraints() {
        test_Title.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(test_Title.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        triangleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(descriptionLabel)
            make.bottom.equalTo(descriptionLabel.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
    }
}

struct SignViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SignViewController()
        }
    }
}

class InnerPaddedLabel : UILabel {
    
    private let padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}

final class TriangleLabel: UILabel {
    private let triangleLayer = CAShapeLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: bounds.midX - 6, y: 0))
        trianglePath.addLine(to: CGPoint(x: bounds.midX + 6, y: 0))
        trianglePath.addLine(to: CGPoint(x: bounds.midX, y: -6))
        trianglePath.close()

        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = backgroundColor?.cgColor

        if triangleLayer.superlayer == nil {
            layer.addSublayer(triangleLayer)
        }
    }
}
