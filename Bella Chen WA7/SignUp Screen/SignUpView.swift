//
//  SignUpView.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit

class SignUpView: UIView {
    var textFieldUsrn: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPwd: UITextField!
    var buttonCreate: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    
        setupTextFieldUsrn()
        setupTextFieldEmail()
        setupTextFieldPwd()
        setupButtonCreate()
        
        initConstraints()
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
    
    func setupTextFieldUsrn() {
        textFieldUsrn = UITextField()
        setupTextField(textField: textFieldUsrn, text: "username", secure: false)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        setupTextField(textField: textFieldEmail, text: "email", secure: false)
    }
    
    func setupTextFieldPwd() {
        textFieldPwd = UITextField()
        setupTextField(textField: textFieldPwd, text: "password", secure: false)
    }
    
    
    
    func setupButtonCreate() {
        buttonCreate = UIButton(type: .system)
        buttonCreate.tintColor = UIColor.red
        buttonCreate.setTitle("Sign Up", for: .normal)
        buttonCreate.setTitleColor(.blue, for: .normal)
        buttonCreate.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buttonCreate.layer.borderWidth = 2
        buttonCreate.layer.borderColor = UIColor.blue.cgColor
        buttonCreate.layer.cornerRadius = 5
        buttonCreate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonCreate)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            textFieldUsrn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            textFieldUsrn.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldUsrn.widthAnchor.constraint(equalToConstant: 300),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldUsrn.bottomAnchor, constant: 20),
            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.widthAnchor.constraint(equalToConstant: 300),
            
            textFieldPwd.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20),
            textFieldPwd.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPwd.widthAnchor.constraint(equalToConstant: 300),
            
            buttonCreate.topAnchor.constraint(equalTo: textFieldPwd.bottomAnchor, constant: 80),
            buttonCreate.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonCreate.widthAnchor.constraint(equalToConstant: 150),
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

