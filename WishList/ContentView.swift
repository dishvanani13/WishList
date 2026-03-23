//
//  ContentView.swift
//  WishList
//
//  Created by Disha Limbani on 2026-03-16.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    //@Query(sort: \Wish.order) private var wishes: [Wish]
    @State private var isAlertShowing: Bool = false
    @State private var title: String = ""
    //@State private var order : Int = 1
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(wishes){ wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical,2)
                        .swipeActions {
                            Button("Delete", role: .destructive){
                                withAnimation {
                                        modelContext.delete(wish)
                                    }
                                try? modelContext.save()
                            }
                        }
                }
            }
            .navigationTitle("Wish List")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        isAlertShowing.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                if wishes.isEmpty != true {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : " ") ")
                            .fixedSize(horizontal: true, vertical: true)
                    }
                }
            }
            
            
                .alert("create a new Wish", isPresented: $isAlertShowing){
                    TextField("Enter a wish", text: $title)
                    Button {
                        if title != "" {
                           // let newOrder = (wishes.map { $0.order }.max() ?? 0) + 1
                            withAnimation {
                                modelContext.insert(Wish(title: title))
                                
                                       // modelContext.insert(Wish(title: title, order: newOrder))
                                    }
                            try? modelContext.save()
                            
                            title = ""
                            isAlertShowing = false
                        }
                    } label: {
                        Text("Add")
                    }
                }
                .onChange(of: wishes.count) { oldValue, newValue in
                    print("Updated count: \(newValue)")
                }
                .overlay{
                    if wishes.isEmpty {
                        ContentUnavailableView("My Wish List", systemImage: "heart.circle", description: Text("No wishes yet. Add one to started."))
                    }
                }
        }
    }
}
#Preview("List with sample Data"){
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
   // container.mainContext.insert(Wish(title: "Master SwiftData"))
    container.mainContext.insert(Wish(title: "Master SwiftUI"))
    //container.mainContext.insert(Wish(title: "Buy iPhone", order: 1))
   // container.mainContext.insert(Wish(title: "Every Day Practise", order: 4))
    return ContentView()
        .modelContainer(container)
}

#Preview ("Empty List"){
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
