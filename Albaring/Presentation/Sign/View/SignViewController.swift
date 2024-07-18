import UIKit
import SnapKit
import SwiftUI
import Lottie

class SignViewController: UIViewController {

    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "SignViewLottie")
        return lottieAnimationView
    }()
    
    private let test_Title: UILabel = {
        let label = UILabel()
        label.text = "SNS계정으로 간편 로그인하기"
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        if let kakaoImage = UIImage(named: "kakao_login") {
            button.setImage(kakaoImage, for: .normal)
        }
        button.alpha = 0
        button.isEnabled = false
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        if let googleImage = UIImage(named: "google_login") {
            button.setImage(googleImage, for: .normal)
        }
        button.alpha = 0
        button.isEnabled = false
        return button
    }()
    
    private lazy var naverLoginButton: UIButton = {
        let button = UIButton()
        if let naverImage = UIImage(named: "naver_login") {
            button.setImage(naverImage, for: .normal)
        }
        button.alpha = 0
        button.isEnabled = false
        return setupButtons(button: button)
    }()
    
    // triangleLabel 정의
    private let triangleLabel: TriangleLabel = {
        let label = TriangleLabel()
        label.backgroundColor = UIColor(hexCode: "FF5C00", alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.alpha = 0
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
        label.layer.masksToBounds = true
        label.alpha = 0
        return label
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(test_Title)
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20
        buttonStackView.addArrangedSubview(kakaoLoginButton)
        buttonStackView.addArrangedSubview(naverLoginButton)
        buttonStackView.addArrangedSubview(googleLoginButton)
        stackView.addArrangedSubview(buttonStackView)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "10121C")
        addSubViews()
        setupConstraints()
    }
}

extension SignViewController {
    private func addSubViews() {
        for viewItem in [animationView, triangleLabel, descriptionLabel, loginStackView] {
            view.addSubview(viewItem)
        }
    }
    
    private func setupButtons(button: UIButton) -> UIButton {
        button.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        return button
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        animationView.frame = view.bounds
        animationView.center = view.center
        animationView.animationSpeed = 2.0
        animationView.play { _ in }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.2) { [self] in
                [kakaoLoginButton, naverLoginButton, googleLoginButton].forEach { $0.isEnabled = true }
                [test_Title, kakaoLoginButton, naverLoginButton, googleLoginButton, triangleLabel, descriptionLabel].forEach { $0.alpha = 1 }
            }
        }
        
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).offset(-158)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(105)
        }
        
        triangleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(descriptionLabel)
            make.bottom.equalTo(descriptionLabel.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(20)
            make.leading.equalTo(loginStackView.snp.leading).offset(-15)
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

class InnerPaddedLabel: UILabel {
    
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
