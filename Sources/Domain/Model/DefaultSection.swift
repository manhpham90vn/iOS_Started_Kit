//
//  DefaultSection.swift
//  MyApp
//
//  Created by Manh Pham on 3/17/20.
//

import Foundation

struct DefaultSection {
    
    var id: Int
    var items: [Event]
    
}

extension DefaultSection: AnimatableSectionModelType {
    
    typealias Item = Event
    
    var identity: Int {
        return id
    }
    
    init(original: DefaultSection, items: [Event]) {
        self = original
        self.items = items
    }
    
}

extension DefaultSection: Equatable {
    
    static func == (lhs: DefaultSection, rhs: DefaultSection) -> Bool {
        return lhs.id == rhs.id
    }
    
}
