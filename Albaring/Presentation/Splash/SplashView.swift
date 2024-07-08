//
//  SplashView.swift
//  Albaring
//
//  Created by 임대진 on 7/8/24.
//

import UIKit
import Lottie

class SplashView: UIViewController {
    
    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "LottieSplash")
        return lottieAnimationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        view.backgroundColor = UIColor(hexCode: "10121C")
        
        animationView.frame = view.bounds
        animationView.center = view.center
        
        animationView.play { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.animationView.alpha = 0
            }, completion: { _ in
                self.animationView.removeFromSuperview()
                self.pushHomeView()
            })
        }
    }
    
    func pushHomeView() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootView(HomeView(), animated: false)
    }
}
