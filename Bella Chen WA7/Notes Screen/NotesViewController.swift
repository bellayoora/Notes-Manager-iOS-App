//
//  NotesViewController.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit
import Alamofire

class NotesViewController: UIViewController {
    let notesScreen = NotesView()
    var notes = [ReceivedNote]()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = notesScreen
        
        notesScreen.tableViewNotes.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes Summary"
        
        if let navigationController = self.navigationController {
                let titleAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.blue
                ]
                navigationController.navigationBar.titleTextAttributes = titleAttributes
            }
        
        notesScreen.tableViewNotes.dataSource = self
        notesScreen.tableViewNotes.delegate = self
        
        navigationItem.hidesBackButton = true
        
        let image = UIImage(systemName: "person.fill")
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(onProfileButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        notesScreen.buttonAdd.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        
        getAllNotes()
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationAddNote(notification:)),
            name: .addNoteNotification,
            object: nil)
    }
    
    @objc func onProfileButtonTapped() {
        let profileController = ProfileViewController()
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    @objc func onAddButtonTapped() {
        let addNoteController = AddNoteViewController()
        navigationController?.pushViewController(addNoteController, animated: true)
    }
    
    func getAllNotes() {
        if let url = URL(string: APIConfigs.noteUrl + "getall") {
            let keySaved = Validation.defaults.object(forKey: "authToken") as! String?
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
                                self.notes.removeAll()
                                let decoder = JSONDecoder()
                                do {
                                    let receivedData = try decoder.decode(Notes.self, from: data)
                                    for item in receivedData.notes {
                                        self.notes.append(item)
                                    }
                                    self.notesScreen.tableViewNotes.reloadData()
                                } catch let error {
                                    print("Error decoding JSON in get all notes: \(error)")
                                }
                                break
                            case 400...499:
                                print("Status code 400...499 in get all notes")
                                print(data)
                                break
                            default:
                                print(data)
                                break
                    
                        }
                    }
                    break
                case .failure(let error):
                    print("Network error in get all notes: \(error)")
                    break
                }
            })
        } else {
            print("Invalid URL in get all notes")
        }
    }
    
    @objc func notificationAddNote(notification: Notification) {
        let note = notification.object as! Note
        if let url = URL(string: APIConfigs.noteUrl+"post") {
            let keySaved = Validation.defaults.object(forKey: "authToken") as! String?
            let parameters: Parameters = [
                "text": note
            ]
            var headers: HTTPHeaders = []
            if let key = keySaved {
                headers = [
                    "x-access-token": key
                ]
            }
            AF.request(url, method: .post, parameters: parameters, headers: headers)
                .responseData(completionHandler: { response in
                    let status = response.response?.statusCode
                    
                    switch response.result {
                        case.success(let data):
                            if let uwStatusCode = status {
                                switch uwStatusCode {
                                    case 200...299:
                                        self.getAllNotes()
                                    case 400...499:
                                        print("Status code 400...499 in add note")
                                        print(data)
                                        break
                                    default:
                                        print(data)
                                        break
                                }
                            }
                        case .failure(let error):
                            print("Network error in add note: \(error)")
                            print(error)
                            break
                    }
            })
        } else {
            print("Invalid URL in add note")
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NotesTableViewCell
        cell.labelNote.text = notes[indexPath.row].text.components(separatedBy: #"""#)[1]
        
        let deleteButton = DeleteButton(note: notes[indexPath.row], indexPath: indexPath)
        deleteButton.sizeToFit()
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(onDeleteButtonTapped(_:)), for:.touchUpInside)
        
        cell.accessoryView = deleteButton
        return cell
    }
    
    @objc func onDeleteButtonTapped(_ sender: DeleteButton) {
        let id = sender.note._id
        let index = sender.indexPath.row
        if let url = URL(string: APIConfigs.noteUrl+"delete") {
            let keySaved = Validation.defaults.object(forKey: "authToken") as! String?
            let parameters: Parameters = [
                "id": id
            ]
            var headers: HTTPHeaders = []
            if let key = keySaved {
                headers = [
                    "x-access-token": key
                ]
            }
            AF.request(url, method: .post, parameters: parameters, headers: headers)
                .responseData(completionHandler: { response in
                    let status = response.response?.statusCode
                    
                    switch response.result {
                        case.success(let data):
                            if let uwStatusCode = status {
                                switch uwStatusCode {
                                    case 200...299:
                                        self.notes.remove(at: index)
                                        self.getAllNotes()
                                    case 400...499:
                                        print("Status code 400...499 in delete note")
                                        print(data)
                                        break
                                    default:
                                        print(data)
                                        break
                                }
                            }
                        case .failure(let error):
                            print("Network error in delete note: \(error)")
                            break
                    }
            })
        } else {
            print("Invalid URL in delete note")
        }
    }
}

