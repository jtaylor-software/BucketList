//
//  BucketItem.swift
//  BucketList
//
//  Created by Jeremy Taylor on 2/22/23.
//

import Foundation

struct BucketItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var note = ""
    var completedDate = Date.distantPast
    
    static var samples: [BucketItem] {
        [
            BucketItem(name: "Visit South Carolina"),
            BucketItem(name: "Skydive", note: "Sooner vs later"),
            BucketItem(name: "Get a job", note: "ASAP", completedDate: Date())
        ]
    }
    
}
