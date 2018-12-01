//
//  DataCollection.swift
//  ExpandableCell
//
//  Created by Nick on 2018/12/1.
//  Copyright © 2018 kcin.nil.app. All rights reserved.
//

import Foundation

class DataCollection: ExpandProtocol {    
    var subDatas: [ExpandProtocol] = []
    var isExpand: Bool = false
    
    var string: String = ""
    init(string: String) {
        self.string = string
    }
    
}
