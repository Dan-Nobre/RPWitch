//import SwiftUI
//import PhotosUI
//
//class PhotoModel: ObservableObject {
//    @Published var selectedPhoto: UIImage?
//}
//
//struct PhotoCircleView: View {
//    @State private var selectedPhotoItem: PhotosPickerItem? = nil
//    @StateObject private var photoModel = PhotoModel()
//    @State private var isPickerPresented: Bool = false
//
//    var body: some View {
//        VStack {
//            if let photo = photoModel.selectedPhoto {
//                Image(uiImage: photo)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 200, height: 200)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
//            } else {
//                Circle()
//                    .fill(Color.gray.opacity(0.2))
//                    .frame(width: 200, height: 200)
//                    .overlay(Image(systemName: "photo.badge.plus").foregroundColor(.gray))
//            }
//
//            Button(action: {
//                isPickerPresented = true
//            }) {
//                Text("Selecionar Foto")
//                    .font(.headline)
//                    .padding()
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//        .photosPicker(isPresented: $isPickerPresented, selection: $selectedPhotoItem, matching: .images)
//        .onChange(of: selectedPhotoItem) { newItem in
//            Task {
//                await loadSelectedPhoto(from: newItem)
//            }
//        }
//    }
//
//    private func loadSelectedPhoto(from item: PhotosPickerItem?) async {
//        guard let item = item else { return }
//        do {
//            if let data = try await item.loadTransferable(type: Data.self),
//               let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.photoModel.selectedPhoto = image
//                }
//            } else {
//                print("Erro: Dados inválidos ou não foi possível criar UIImage.")
//            }
//        } catch {
//            print("Erro ao carregar a imagem: \(error)")
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
