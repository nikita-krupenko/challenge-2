import SwiftUI

struct DetailView: View {
    @State private var selectedWorkIndex: Int?
    @State private var isFullCoverPresented = false
    let works: [Work]
    let author: Artist
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List(0..<works.count, id: \.self) { index in
                    let work = works[index]
                    Image(work.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: selectedWorkIndex == index ? .infinity : .infinity, maxHeight: selectedWorkIndex == index ? .infinity : .infinity)
                        .onTapGesture {
                            withAnimation {
                                if selectedWorkIndex == index {
                                } else {
                                    isFullCoverPresented = true
                                    selectedWorkIndex = index
                                }
                            }
                        }
                }
                .fullScreenCover(isPresented: $isFullCoverPresented) {
                    if let selectedWorkIndex = selectedWorkIndex, selectedWorkIndex < works.count {
                        FullCoverModelView(work: works[selectedWorkIndex])
                    }            }
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text("Back")
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack{
                        Text("Painted by:")
                        Text(author.name)
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let artist = Artist(name: "Sample Artist", bio: "Sample Bio", image: "sampleImage", works: [
            Work(title: "Example Title 1", image: "exampleImage1", info: "Example Info 1"),
            Work(title: "Example Title 2", image: "exampleImage2", info: "Example Info 2")
        ])
        return DetailView(works: artist.works, author: artist)
    }
}
struct FullCoverModelView: View {
    @Environment(\.presentationMode) var presentationMode
    let work: Work

    var body: some View {
        VStack {
            Image(work.image)
                .resizable()
                .scaledToFit()

            Text(work.title)
                .font(.headline)
                .padding()

            Text(work.info)
                .font(.subheadline)
                .padding()

            Spacer()

            Text("Swipe down to close")
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .gesture(DragGesture().onEnded { _ in
            presentationMode.wrappedValue.dismiss()
        })
    }
}
