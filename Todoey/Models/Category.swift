//
//  Category.swift
//  Todoey
//
//  Created by Gerold Kölle on 04.05.19.
//  Copyright © 2019 Gerold Kölle. All rights reserved.
//

import Foundation
import  RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
//    let array = Array<Int>()
//    let array: Array<Int> = [1, 2, 3]
//    let array = [Int]()
}
