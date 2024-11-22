//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct PortalView: View {
//    var animationProgress: CGFloat // Progresso da animação do portal
//
//    var body: some View {
//        ZStack {
//            // Círculo do portal animado
//            Circle()
//                .stroke(
//                    LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom),
//                    lineWidth: 10
//                )
//                .scaleEffect(animationProgress) // Expande o círculo com base no progresso da animação
//                .opacity(1.0 - Double(animationProgress)) // Diminui a opacidade conforme o portal abre
//
//            if animationProgress == 1.0 {
//                ImmersiveView() // Carrega a ImmersiveView quando a animação está completa
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(animationProgress == 1.0 ? 1.0 : 0.0))
//        .ignoresSafeArea()
//    }
//}
