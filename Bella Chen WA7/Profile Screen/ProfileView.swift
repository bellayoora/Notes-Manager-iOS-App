//
//  ProfileView.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit
import Alamofire

class ProfileView: UIView {
    var userName: UILabel!
    var email: UILabel!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupEmail()
        setupUserName()
        setupLogoutButton()
        initConstraints()
    }
    
    
    func setupUserName() {
        userName = UILabel()
        userName.font = UIFont.boldSystemFont(ofSize: 18)
        userName.textColor = UIColor.blue
        userName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(userName)
    }
    
    func setupEmail() {
        email = UILabel()
        email.font = UIFont.boldSystemFont(ofSize: 18)
        email.textColor = UIColor.blue
        email.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(email)
    }
    
    func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.tintColor = UIColor.red
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.borderColor = UIColor.blue.cgColor
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 250),
            userName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 25),
            email.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 50),
            logoutButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 80),
        ])
    }

    
    // unused methods
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

