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
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubViews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        test_Title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func addSubViews() {
        view.addSubview(test_Title)
    }
}

struct SignViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SignViewController()
        }
    }
}
