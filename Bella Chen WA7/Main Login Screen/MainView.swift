//
//  MainView.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit

class MainView: UIView {

    var goodNoteLabel: UILabel!
    var emailInput: UITextField!
    var passwordInput: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupGoodNoteLabel()
        setupEmailInput()
        setupPasswordInput()
        setupLoginButton()
        setupSignUpButton()
        initConstraints()
    }
    
    func setupGoodNoteLabel() {
        goodNoteLabel = UILabel()
        goodNoteLabel.text = "Good Notes"
        goodNoteLabel.font = UIFont.italicSystemFont(ofSize: 55) 
        goodNoteLabel.textColor = UIColor.blue
        goodNoteLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(goodNoteLabel)
    }

    
    func setupTextField(textField: UITextField, text: String, secure: Bool) {
        textField.placeholder = text
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = secure
        textField.textContentType = .oneTimeCode
        self.addSubview(textField)
    }
    
    func setupEmailInput() {
        emailInput = UITextField()
        setupTextField(textField: emailInput, text: "email", secure: false)
    }
    
    func setupPasswordInput() {
        passwordInput = UITextField()
        setupTextField(textField: passwordInput, text: "password", secure: true)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.tintColor = UIColor.red
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.blue.cgColor
        loginButton.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    func setupSignUpButton() {
        signupButton = UIButton(type: .system)
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(.blue, for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = UIColor.blue.cgColor
        signupButton.layer.cornerRadius = 5
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(signupButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            goodNoteLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 120),
            goodNoteLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            emailInput.topAnchor.constraint(equalTo: goodNoteLabel.bottomAnchor, constant: 90),
            emailInput.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailInput.widthAnchor.constraint(equalToConstant: 300),
            
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 30),
            passwordInput.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            passwordInput.widthAnchor.constraint(equalToConstant: 300),
            
            
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 90),
            loginButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 90),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            signupButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 90),
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

