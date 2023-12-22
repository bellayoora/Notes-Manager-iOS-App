//
//  SignUpViewController.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    let signUpScreen = SignUpView()
    
    override func loadView() {
        view = signUpScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpScreen.buttonCreate.addTarget(self, action: #selector(onCreateButtonTapped), for: .touchUpInside)
    }
    
    @objc func onCreateButtonTapped() {
        let username = signUpScreen.textFieldUsrn.text
        let email = signUpScreen.textFieldEmail.text
        let password = signUpScreen.textFieldPwd.text
        
        if let unwUsrn = username, let unwEmail = email, let unwPwd = password{
            if !unwUsrn.isEmpty && !unwEmail.isEmpty && !unwPwd.isEmpty {
               
                if !Validation.isValidEmail(unwEmail) {
                    Validation.showErrorAlert(self, "Invalid email address!")
                }

                
                if Validation.isValidEmail(unwEmail) {
                    createUser(username: unwUsrn, email: unwEmail, password: unwPwd)
                }
            } else {
                Validation.showErrorAlert(self, "Input cannot be empty!")
            }
        }
    }
    
    func createUser(username: String, email: String, password: String) {
        if let url = URL(string: APIConfigs.authUrl+"register") {
            let parameters: Parameters = [
                "name": username,
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
                                            print("Error decoding JSON in user sign up: \(error)")
                                        }
                                        break
                                    case 400...499:
                                        print("Status code 400..499 in user sign up")
                                        print(data)
                                        break
                                    default:
                                        Validation.showErrorAlert(self, "Username or email already exists!")
                                        print(data)
                                        break
                                }
                            }
                        case .failure(let error):
                            print("Network error in user sign up: \(error)")
                            break
                    }
            })
        } else {
            print("Invalid URL in user sign up")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

