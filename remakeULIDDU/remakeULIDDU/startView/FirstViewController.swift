//
//  firstViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import SnapKit

class FirstViewController : UIViewController {
    
    let imageView: UIImageView = {
        let logoImage = UIImageView()
        logoImage.backgroundColor = .white
        logoImage.image = UIImage(named: "ULIDDL-Logo1")
        logoImage.contentMode = .scaleAspectFit
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLoginButton()
        configureSignUpButton()
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.width.height.equalTo(150)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-550)
            $0.leading.equalTo(45)
        }
    }
    
    func configureLoginButton() {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(loginButton)
        
        loginButton.layer.cornerRadius = 15
        
        loginButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-350)
            $0.leading.equalTo(45)
            }
        
        loginButton.addTarget(self, action: #selector(LoginButtonAction), for: .touchUpInside)
        
        }
    
    @objc func LoginButtonAction(sender: UIButton!){
        let goToLoginVC = MainLoginViewController()
        goToLoginVC.modalPresentationStyle = .fullScreen
        //반만 나오는 이동
//        goToLoginVC.modalPresentationStyle = .automatic
        self.present(goToLoginVC, animated: true, completion: nil)
        print("MainLoginViewController 이동 성공 😃")
    }
    
    func configureSignUpButton() {
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .black
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
        
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        signUpButton.layer.cornerRadius = 15

        
        signUpButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-280)
            $0.leading.equalTo(45)
        }
        
        signUpButton.addTarget(self, action: #selector(SignUpButtonAction), for: .touchUpInside)
    }
    
    @objc func SignUpButtonAction(sender: UIButton!){
        let goToMainTabBarVC = MainSignUpViewController()
        goToMainTabBarVC.modalPresentationStyle = .fullScreen
        self.present(goToMainTabBarVC, animated: true, completion: nil)
        print("회원가입 번튼 실행됨 🤣")
    }
    
}

import SwiftUI

struct FirstViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = FirstViewController

    func makeUIViewController(context: Context) -> FirstViewController {
        return FirstViewController()
    }
    
    func updateUIViewController(_ uiViewController: FirstViewController, context: Context) { }
}

@available(iOS 13.0.0, *)
struct FirstViewPreview: PreviewProvider {
    static var previews: some View {
        FirstViewControllerRepresentable()
    }
}
