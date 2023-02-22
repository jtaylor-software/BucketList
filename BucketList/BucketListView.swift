//
//  ContentView.swift
//  BucketList
//
//  Created by Jeremy Taylor on 2/22/23.
//

import SwiftUI

struct BucketListView: View {
    @State private var bucketList = ["Skydive", "Visit South Carolina", "Get a job"]
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New Bucket Item", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        bucketList.append(newItem)
                        newItem = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .disabled(newItem.isEmpty)
                    }
                    
                }
                .padding()
                List {
                    ForEach(bucketList, id: \.self) { item in
                        NavigationLink(value: item) {
                            Text(item)
                        }
                    }
                    .onDelete { indexSet in
                        bucketList.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Bucket List")
                .navigationDestination(for: String.self) { item in
                    Text(item)
                        .font(.title)
                }
                
            }
        }
    }
}

struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}
