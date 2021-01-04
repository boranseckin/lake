//
//  TestCourseView.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-04.
//

import SwiftUI
import MobileCoreServices

struct Item: Identifiable {
    let id = UUID()
    let title: String
}

struct TestCourseView: View {
    @State private var editMode = EditMode.inactive
    @State private var items: [Item] = []
    
    private static var count = 0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
                .onInsert(of: [String(kUTTypeURL)], perform: onInsert)
            }
            .navigationTitle("List")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    private func onAdd() {
        items.append(Item(title: "Item #\(Self.count)"))
        Self.count += 1
    }
    
    private func onDelete(offset: IndexSet) {
        items.remove(atOffsets: offset)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    private func onInsert(at offset: Int, itemProvider: [NSItemProvider]) {
        for provider in itemProvider {
            if provider.canLoadObject(ofClass: URL.self) {
                _ = provider.loadObject(ofClass: URL.self) { url, error in
                    DispatchQueue.main.async {
                        url.map { self.items.insert(Item(title: $0.absoluteString), at: offset) }
                    }
                }
            }
        }
    }
}

struct TestCourseView_Previews: PreviewProvider {
    static var previews: some View {
        TestCourseView()
    }
}
