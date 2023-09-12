//
//  ContentView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-08.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        VStack {
            AddExpenseView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
