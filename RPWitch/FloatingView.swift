////
////  FloatingView.swift
////  RPWitch
////
////  Created by Daniel Nobre on 13/11/24.
////
//
//import SwiftUI
//
//struct FloatingUserView: View {
//    var nome: String
//    var classe: String
//    var isOnline: Bool
//
//    var body: some View {
//        VStack(spacing: 10) {
//            // Foto com indicador de status
//            ZStack {
//                Circle()
//                    .stroke(isOnline ? Color.green : Color.gray, lineWidth: 4)
//                    .frame(width: 80, height: 80)
//
//                PhotoCircleView(nome: "daniel", classe: $classe)
//                    .frame(width: 70, height: 70)
//            }
//
//            // Nome e Classe
//            VStack(spacing: 4) {
//                Text(nome)
//                    .font(.headline)
//                    .foregroundColor(.white)
//                Text(classe)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 12)
//                .fill(Color.black.opacity(0.7))
//        )
//        .shadow(radius: 10)
//    }
//}
