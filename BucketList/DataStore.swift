//
//  DataStore.swift
//  BucketList
//
//  Created by Jeremy Taylor on 2/22/23.
//

import Foundation

class DataStore: ObservableObject {
    @Published var bucketList: [BucketItem] = []
    let fileURL = URL.documentsDirectory.appending(path: "bucketList.json")
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        if FileManager().fileExists(atPath: fileURL.path) {
            do {
              let data = try Data(contentsOf: fileURL)
                bucketList = try JSONDecoder().decode([BucketItem].self, from: data)
            } catch {
                // file is corrupt so create a new empty array
                saveList()
            }
        }
    }
    
    func create(_ newItem: String) {
        let newBucketItem = BucketItem(name: newItem)
        bucketList.append(newBucketItem)
        saveList()
    }
    
    func update(bucketItem: BucketItem, note: String, completedDate: Date) {
        if let index = bucketList.firstIndex(where: {$0.id == bucketItem.id}) {
            bucketList[index].note = note
            bucketList[index].completedDate = completedDate
            saveList()
        }
    }
    
    func delete(indexSet: IndexSet) {
        bucketList.remove(atOffsets: indexSet)
        saveList()
    }
    
    func saveList() {
        do {
            let bucketListData = try JSONEncoder().encode(bucketList)
            let bucketListString = String(decoding: bucketListData, as: UTF8.self)
            try bucketListString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Could not encode bucket list and save it.")
        }
    }
}
