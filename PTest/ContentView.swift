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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        NavigationView {
                            QuestionView(title: item.title!, context: item.content!)
                                .navigationTitle(item.title!)
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
                            TestsView(tests: item.tests!)
                                .id(item.tests)
                        }
                    } label: {
                        HStack {
                            Text(item.title!)
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
                        addItem(content: "Use edit button to type the content.  \nThe format of the tests:  \n```#1INP:XXX#1OUT:XXX#2INP:XXX#2OUT:XXX...```  \nFor example:  \n```#1INP:12#1OUT:4#2INP:30#2OUT:10```  \nWarning: Try your best to avoid using ```\\n``` in your tests.", title: "Untitled Test", tests: "#1INP:12#1OUT:4#2INP:30#2OUT:10")
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(_ offsets: Item) {
        withAnimation {
            viewContext.delete(offsets)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
