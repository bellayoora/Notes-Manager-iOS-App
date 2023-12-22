//
//  ViewController.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let loginScreen = MainView()
    
    override func loadView() {
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keySaved = Validation.defaults.object(forKey: "authToken") as! String?
        if let _ = keySaved {
            let notesController = NotesViewController()
            navigationController?.pushViewController(notesController, animated: true)
        }
        
        loginScreen.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        loginScreen.signupButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func onSignUpButtonTapped() {
        let signUpController = SignUpViewController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @objc func onLoginButtonTapped() {
        let email = loginScreen.emailInput.text
        let password = loginScreen.passwordInput.text
        
        if let unwEmail = email, let unwPwd = password {
            if !unwEmail.isEmpty && !unwPwd.isEmpty {
                loginUser(email: unwEmail, password: unwPwd)
            } else {
                Validation.showErrorAlert(self, "Input cannot be empty!")
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        if let url = URL(string: APIConfigs.authUrl+"login"){
            let parameters: Parameters = [
                "email": email,
                "password": password
            ]
            let headers: HTTPHeaders = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            AF.request(url, method: .post, parameters: parameters, headers: headers)
                .responseData(completionHandler: { response in
                    let status = response.response?.statusCode
                    
                    switch response.result {
                        case.success(let data):
                            if let uwStatusCode = status {
                                switch uwStatusCode {
                                    case 200...299:
                                        let decoder = JSONDecoder()
                                        do {
                                            let receivedData = try decoder.decode(Authentication.self, from: data)
                                            Validation.defaults.set(receivedData.token, forKey: "authToken")
                                            let notesController = NotesViewController()
                                            self.navigationController?.pushViewController(notesController, animated: true)
                                        } catch let error {
                                            print("Error decoding JSON in user login: \(error)")
                                        }
                                        break
                                    case 400...499:
                                        Validation.showErrorAlert(self, "Wrong email or password!")
                                        break
                                    default:
                                        print(data)
                                        break
                                }
                            }
                        case .failure(let error):
                            print("Network error in user login: \(error)")
                            break
                    }
            })
            
        } else {
            print("Invalid URL in user login")
        }
    }


}

