import SwiftUI
import PhotosUI

class PhotoModel: ObservableObject {
    @Published var selectedPhoto: UIImage?
    @Published var characterName: String? = nil
    @Published var characterClass: String? = nil
}

struct PhotoCircleView: View {
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @StateObject private var photoModel = PhotoModel()
    @State private var isPickerPresented: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                // Círculo verde externo
                Circle()
                    .stroke(Color.green, lineWidth: 8)
                    .frame(width: 220, height: 220) // Ajuste maior que o círculo interno

                // Círculo principal
                if let photo = photoModel.selectedPhoto {
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                        .onTapGesture {
                            isPickerPresented = true
                        }
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 200, height: 200)
                        .overlay(
                            Image("Okarun")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                        )
                        .onTapGesture {
                            isPickerPresented = true
                        }
                }
            }

            // Informações do personagem
//            VStack(spacing: 8) {
//                Text(photoModel.characterName?.isEmpty == false ? photoModel.characterName! : "Não informado")
//                    .font(.headline)
//                Text(photoModel.characterClass?.isEmpty == false ? photoModel.characterClass! : "Não informado")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
        }
        .photosPicker(isPresented: $isPickerPresented, selection: $selectedPhotoItem, matching: .images)
        .onChange(of: selectedPhotoItem) { newItem in
            Task {
                await loadSelectedPhoto(from: newItem)
            }
        }
    }

    private func loadSelectedPhoto(from item: PhotosPickerItem?) async {
        guard let item = item else { return }
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.photoModel.selectedPhoto = image
                }
            } else {
                print("Erro: Dados inválidos ou não foi possível criar UIImage.")
            }
        } catch {
            print("Erro ao carregar a imagem: \(error)")
        }
    }
}

#Preview {
    PhotoCircleView()
}
