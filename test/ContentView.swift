//
//  ContentView.swift
//  test
//
//  Created by Shaqina Yasmin on 27/07/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .linear)
    var notes: FetchedResults<Item>
    
    @State private var showAddNoteSheet: Bool = false
    @State private var newNoteTitle: String = ""
    @State private var newNoteContent: String = ""
    @State var selection: Item? = nil
    
    
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(notes) { note in
                    NavigationLink(note.title ?? "", destination: NoteView(note: note))
                }

            }

            .onDeleteCommand{
                if
                    let sel = self.selection,
                    let index = self.notes.firstIndex(of: sel){
                    
                    let noteEntity = notes[index]
                    viewContext.delete(noteEntity)
                    
                    saveItems()
                }
                print("Delete")

            }
            

            
            .toolbar{
                ToolbarItem {
                    Button {
                        showAddNoteSheet.toggle()
                    } label: {
                        Label("Add note", systemImage: "plus")
                    }
                    
                }
                
            }
            .sheet(isPresented: $showAddNoteSheet) {
                NavigationView {

                    Spacer()
                    Form {
                            TextField("Title", text: $newNoteTitle)
                                
                            TextEditor(text: $newNoteContent)
                                .frame(height: 200)
                                .font(.custom("Courier Prime", size: 12))
                            
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                    }.padding()

                }
            }
        }


    }
    private func addItem() {
        withAnimation {
            let newNote = Item(context: viewContext)
            newNote.title = newNoteTitle
            newNote.content = newNoteContent
            newNote.timestamp = Date()
            
            saveItems()
            
        }
    }
    
    private func saveItems(){
        try? viewContext.save()
        newNoteTitle = ""
        newNoteContent = ""
        showAddNoteSheet.toggle()
    }
    
    private func deleteItems (offsets : IndexSet){
        withAnimation {
            guard let index = offsets.first else {return}
            let notesEntity = notes[index]
            viewContext.delete(notesEntity)
            
            saveItems()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
