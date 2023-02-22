//
//  DetailView.swift
//  BucketList
//
//  Created by Jeremy Taylor on 2/22/23.
//

import SwiftUI

struct DetailView: View {
    let bucketItem: BucketItem
    @EnvironmentObject var dataStore: DataStore
    @State private var note = ""
    @State private var completedDate = Date.distantPast
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Bucket Note", text: $note, axis: .vertical)
            if completedDate != Date.distantPast {
                DatePicker("Completed on", selection: $completedDate, displayedComponents: .date)
            }
            Button(completedDate == Date.distantPast ? "Add Date" : "Clear Date") {
                if completedDate == Date.distantPast {
                    completedDate = Date()
                } else {
                    completedDate = Date.distantPast
                }
            }
            .buttonStyle(.borderedProminent)
        }
            .onAppear {
                note = bucketItem.note
                completedDate = bucketItem.completedDate
            }
            .toolbar {
                ToolbarItem {
                    Button("Update") {
                        dataStore.update(bucketItem: bucketItem, note: note, completedDate: completedDate)
                        dismiss()
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle(bucketItem.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let bucketItem = BucketItem.samples[2]
    static var previews: some View {
        NavigationStack {
            DetailView(bucketItem: bucketItem)
                .environmentObject(DataStore())
        }
    }
}
