//
//  ContentView.swift
//  TestJson
//
//  Created by nikita on 09.11.2023.
//
import SwiftUI

struct ContentView: View {
    var artists: [Artist] = decodeArtistData()
    @State private var searchText: String = ""
    @State var tapOnArtisrt = false
    var body: some View {
        NavigationView {
            List {
                ForEach(artists, id: \.name) { artist in
                    if searchText.isEmpty || artist.name.localizedCaseInsensitiveContains(searchText) || artist.works.contains { $0.title.localizedCaseInsensitiveContains(searchText) } {
                        VStack(alignment: .leading) {
                            NavigationLink(destination: DetailView(works: artist.works, author: artist).navigationBarBackButtonHidden(true)) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Image(artist.image)
                                    Text(artist.name)
                                        .font(.headline)
                                    Text(artist.bio)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TextField("Search by artist or painting", text: $searchText)
                        .padding(8)
                        .background(Color(.lightGray))
                        .cornerRadius(10)
                        .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Artists")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
