//
//  ProfileViewController.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    let profileScreen = ProfileView()
    var user: User!
    
    override func loadView() {
        view = profileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
    }
    
    func getUser() {
        let keySaved = Validation.defaults.object(forKey: "authToken") as! String?
        if let url = URL(string: APIConfigs.authUrl+"me") {
            var headers: HTTPHeaders = []
            if let key = keySaved {
                headers = [
                    "x-access-token": key
                ]
            }
            AF.request(url, method: .get, headers: headers).responseData(completionHandler: { response in
                let status = response.response?.statusCode
                switch response.result {
                    case .success(let data):
                        if let uwStatusCode = status {
                            switch uwStatusCode {
                                case 200...299:
                                    let decoder = JSONDecoder()
                                    do {
                                        self.user = try decoder.decode(User.self, from: data)
                                        
                                        if let name = self.user.name {
                                            self.profileScreen.userName.text = "Username: " + name
                                        } else {
                                            
                                        }
                                        
                                        if let email = self.user.email {
                                            self.profileScreen.email.text = "Email: " + email
                                        } else {
                                            
                                        }
                                        
                                        self.profileScreen.logoutButton.addTarget(self, action: #selector(self.onLogoutButtonTapped), for: .touchUpInside)
                                    } catch let error {
                                        print("Error decoding JSON in get profile: \(error)")
                                    }
                                    break
                                case 400...499:
                                    print("Status code 400...499 in get profile")
                                    print(data)
                                    break
                                default:
                                    print(data)
                                    break
                            }
                        }
                        break
                    case .failure(let error):
                        print("Network error in get profile: \(error)")
                        break
                }
            })
        } else {
            print("Invalid URL in get profile")
        }
    }
    
    @objc func onLogoutButtonTapped() {
        if let url = URL(string: APIConfigs.authUrl+"logout") {
            AF.request(url, method: .get).responseData(completionHandler: { response in
                let status = response.response?.statusCode
                switch response.result {
                    case .success(let data):
                        if let uwStatusCode = status {
                            switch uwStatusCode {
                                case 200...299:
                                    Validation.defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                                    Validation.defaults.synchronize()
                                    
                                    if let firstViewController = self.navigationController?.viewControllers.first {
                                        self.navigationController?.popToViewController(firstViewController, animated: true)
                                    }
                                    break
                                case 400...499:
                                    print("Status code 400...499 in user logout")
                                    print(data)
                                    break
                                default:
                                    print(data)
                                    break
                            }
                        }
                        break
                    case .failure(let error):
                        print("Network error in user logout: \(error)")
                        break
                }
            })
        } else {
            print("Invalid URL in user logout")
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

