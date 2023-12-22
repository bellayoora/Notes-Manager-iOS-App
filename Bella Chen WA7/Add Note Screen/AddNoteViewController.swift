//
//  AddNoteViewController.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit
import Alamofire

class AddNoteViewController: UIViewController {
    let addNoteScreen = AddNoteView()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = addNoteScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNoteScreen.addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func onAddButtonTapped() {
        if let unwNote = addNoteScreen.textView.text {
            if !unwNote.isEmpty {
                createNote(unwNote)
            } else {
            }
        }
    }
    
    func createNote(_ note: String) {
        let newNote = Note(note: note)
        notificationCenter.post(name: .addNoteNotification, object: newNote)
        navigationController?.popViewController(animated: true)
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

