//
//  DeleteButton.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import Foundation
import UIKit

class DeleteButton: UIButton {
    var note: ReceivedNote
    var indexPath: IndexPath
    
    init(note: ReceivedNote, indexPath: IndexPath) {
        self.note = note
        self.indexPath = indexPath
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
