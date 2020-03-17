//
//  DefaultSection.swift
//  MyApp
//
//  Created by Manh Pham on 3/17/20.
//

import Foundation

struct DefaultSection {
    
    var id: Int
    var items: [Meal]
    
}

extension DefaultSection: AnimatableSectionModelType {
    
    typealias Item = Meal
    typealias Identity = Int
    
    var identity: Int {
        return id
    }
    
    init(original: DefaultSection, items: [Item]) {
        self = original
        self.items = items
    }
    
}

extension DefaultSection: Equatable {
    
    static func == (lhs: DefaultSection, rhs: DefaultSection) -> Bool {
        return lhs.id == rhs.id
    }
    
}
