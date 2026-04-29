//
//  EditQuestionView.swift
//  PTest
//
//  Created by miaobobo on 2026/4/29.
//

import SwiftUI

struct EditQuestionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var item: Item
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var tests: String = ""
    @State private var isSaved = false

    var body: some View {
        Group {
            Form {
                Section(header: Text("Informations of the question")) {
                    TextField("Title", text: $title)
                    TextEditor(text: $content).frame(height: 150)
                }
                Section(header: Text("Tests")) {
                    TextEditor(text: $tests).frame(height: 100)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancle") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        item.title = title
                        item.content = content
                        item.tests = tests
                        
                        if viewContext.hasChanges {
                            try? viewContext.save()
                            viewContext.refresh(item, mergeChanges: true)
                        }
                        
                        isSaved = true
                        dismiss()
                    }
                }
            }
            .onAppear {
                title = item.title ?? ""
                content = item.content ?? ""
                tests = item.tests ?? ""
            }
            .padding(10)
            .frame(minWidth: 600)
        }
    }
}

//struct EditQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditQuestionView()
//    }
//}
