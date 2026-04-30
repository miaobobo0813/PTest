//
//  ContentView.swift
//  PTest
//
//  Created by miaobobo on 2026/4/28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var isSheet = false
    @State private var selection = Item()
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        NavigationView {
                            QuestionView(title: item.title ?? "Untitled test", context: item.content ?? "")
                                .navigationTitle(item.title ?? "Untitled test")
                                .padding(10)
                                .toolbar {
                                    ToolbarItem {
                                        Button {
                                            isSheet = true
                                            selection = item
                                        } label: {
                                            Label("Edit Item", systemImage: "square.and.pencil")
                                        }
                                    }
                                }
                            TestsView(tests: item.tests ?? "#1INP: #1OUT: ")
                                .id(item.tests)
                        }
                    } label: {
                        HStack {
                            Text(item.title ?? "Untitled test")
                            Spacer()
                            Button {
                                deleteItems(item)
                            } label: {
                                Label("Delete Item", systemImage: "minus")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        addItem(content: "Use edit button to type the content.  \nThe format of the tests:  \n```#1INP:XXX#1OUT:XXX#2INP:XXX#2OUT:XXX...```  \nFor example:  \n```#1INP:12#1OUT:4#2INP:30#2OUT:10```  \nWarning: Try your best to avoid using ```\\n``` in your tests. Ensure that the tests are vaild", title: "Untitled Test", tests: "#1INP:12#1OUT:4#2INP:30#2OUT:10")
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an test.")
        }
        .sheet(isPresented: $isSheet) {
            EditQuestionView(item: $selection)
        }
        .alert("Error", isPresented: $isShowAlert) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text(alertMessage)
        }
    }

    private func addItem(content: String, title: String, tests: String) {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.content = content
            newItem.title = title
            newItem.tests = tests

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                alertMessage = "Save failed: \(nsError)"
                isShowAlert = true
            }
        }
    }

    private func deleteItems(_ item: Item) {
        withAnimation {
            viewContext.delete(item)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                alertMessage = "Save failed: \(nsError)"
                isShowAlert = true
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
