//
//  NoteView.swift
//  test
//
//  Created by Shaqina Yasmin on 27/07/22.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var note: Item
    
    @State private var noteContent: String = ""
    

    
    var body: some View {
        
        TextEditor(text: $noteContent)
            .frame(maxHeight:.infinity)
            .navigationTitle(note.title ?? "")
            .textSelection(.enabled)
            .font(.custom("Courier Prime", size: 16))
        
            .onAppear{
                noteContent = note.content ?? ""
            }
            .toolbar {
                Button("Save") {
                    note.content = noteContent
                    try? viewContext.save()
                }
                Button("Delete") {
                    viewContext.delete(note)
                    try? viewContext.save()
                    
                }
            }
            
    }
}

