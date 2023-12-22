//
//  NotesView.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import UIKit

class NotesView: UIView {
    var tableViewNotes: UITableView!
    var buttonAdd: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewNotes()
        setupButtonAdd()
        initConstraints()
    }
    
    func setupTableViewNotes() {
        tableViewNotes = UITableView()
        tableViewNotes.backgroundColor = .white
        tableViewNotes.register(NotesTableViewCell.self, forCellReuseIdentifier: "notes")
        tableViewNotes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewNotes)
    }
    
    func setupButtonAdd() {
        buttonAdd = UIButton(type: .system)
        buttonAdd.setTitle("", for: .normal)
        buttonAdd.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        buttonAdd.tintColor = .blue
        buttonAdd.contentHorizontalAlignment = .fill
        buttonAdd.contentVerticalAlignment = .fill
        buttonAdd.imageView?.contentMode = .scaleAspectFit
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAdd)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewNotes.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableViewNotes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewNotes.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewNotes.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            buttonAdd.topAnchor.constraint(equalTo: tableViewNotes.bottomAnchor, constant: 16),
            buttonAdd.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonAdd.widthAnchor.constraint(equalToConstant: 50),
            buttonAdd.heightAnchor.constraint(equalToConstant: 50),
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

