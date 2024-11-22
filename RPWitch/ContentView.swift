import ARKit
import SwiftUI
import RealityKit

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    @State private var selectedOption: MenuOption? = nil
    @State private var isMenuVisible: Bool = false

    var body: some View {
        ZStack {
            // Espaço imersivo como plano de fundo
            if appModel.immersiveSpaceState == .open {
                Color.clear // Placeholder para o espaço imersivo
                    .ignoresSafeArea()
            }

            // Conteúdo principal
            VStack {
                if appModel.immersiveSpaceState != .open {
                    switch selectedOption {
                    case .characterSheet:
                        Text("Ficha de Personagem")
                            .font(.largeTitle)
                            .padding()
                        FichaDePersonagem()
                    case .characteristics:
                        Text("Características")
                            .font(.largeTitle)
                            .padding()
                        Text("Ainda em implementação")
                    case .inventory:
                        Text("Inventário")
                            .font(.largeTitle)
                            .padding()
                        Text("Sem itens ainda no inventário, para comprar se dirija a cidade de Xentria")
                    case .spells:
                        Text("Feitiços")
                            .font(.largeTitle)
                            .padding()
                        Text("Sem feitiços novos.")
                    case .none:
                        Text("Selecione uma opção no menu")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .overlay(
                // Botão para abrir o menu
                Button(action: {
                    withAnimation {
                        isMenuVisible.toggle()
                    }
                }) {
                    Image(systemName: "person.fill")
                        .font(.title)
                        .padding()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading),
                alignment: .topLeading
            )
            .overlay(
                // Botão para alternar o espaço imersivo
                Button(action: toggleImmersiveSpace) {
                    Text("Ir para o mundo")
                        .font(.title)
                        .padding()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing),
                alignment: .topTrailing
            )

            // Menu lateral
            if isMenuVisible && appModel.immersiveSpaceState != .open {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Menu")
                            .font(.title)
                            .bold()
                            .padding(.bottom, 10)

                        ForEach(MenuOption.allCases, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                                withAnimation {
                                    isMenuVisible = false
                                }
                            }) {
                                Text(option.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .cornerRadius(8)
                            }
                        }

                        Spacer()
                    }
                    .frame(width: 250)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .offset(y: 80)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.move(edge: .leading))

                    Spacer()
                }
            }

            // Espaço imersivo: Ficha e botão no mundo virtual
            if appModel.immersiveSpaceState == .open {
                VStack(spacing: 20) {
                    PhotoCircleView()

                    // Botão para reduzir a janela
//                    Button(action: {
//                        withAnimation(.easeInOut(duration: 0.5)) {
//                            // Lógica para reduzir a escala
//                        }
//                    }) {
//                        Text("Reduzir")
//                            .font(.headline)
//                            .padding()
//        
//                            .foregroundColor(.white)
//                            .clipShape(Capsule())
//                            .shadow(radius: 5)
//                    }
                }
                .padding()
            }
        }
    }

    private func toggleImmersiveSpace() {
        Task { @MainActor in
            switch appModel.immersiveSpaceState {
            case .open:
                appModel.immersiveSpaceState = .inTransition
                await dismissImmersiveSpace()

            case .closed:
                appModel.immersiveSpaceState = .inTransition
                switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
                case .opened:
                    break
                case .userCancelled, .error:
                    appModel.immersiveSpaceState = .closed
                @unknown default:
                    appModel.immersiveSpaceState = .closed
                }

            case .inTransition:
                break
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}
