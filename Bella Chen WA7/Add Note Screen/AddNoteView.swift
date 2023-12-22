//
//  AddNoteView.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit

class AddNoteView: UIView {
    var textView: UITextView!
    var addButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTextView()
        setupAddButton()
        initConstraints()
    }
    
 

    func setupTextView() {
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.systemBlue
        textView.textColor = UIColor.blue
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Type your note here"
        self.addSubview(textView)
    }
    
    func setupAddButton() {
        addButton = UIButton(type: .system)
        addButton.tintColor = UIColor.red
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.blue.cgColor
        addButton.layer.cornerRadius = 5
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 150),
            
            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 80), // Adjust the constant value
            addButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
