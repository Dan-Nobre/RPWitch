//
//  FichaDePersonagem.swift
//  RPWitch
//
//  Created by Daniel Nobre on 13/11/24.
//

import SwiftUI

struct FichaDePersonagem: View {
    // Variáveis para armazenar as informações do personagem
    @State private var nome: String = ""
    @State private var classe: String = "Selecione" // Classe padrão
    let classesDisponiveis = ["Mago", "Guerreiro", "Arqueiro", "Clérigo", "Ladino"]

    // Controle para exibir o modal
    @State private var isEditing: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            
                // Foto do personagem
                PhotoCircleView()

                // Exibe Nome e Classe abaixo da foto
                VStack {
                    Text("\(nome.isEmpty ? "Não informado" : nome)")
                        .font(.headline)
                    Text("\(classe == "Selecione" ? "Não informado" : classe)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            
            Spacer()
            // Botão para abrir o modal de edição
            Button(action: {
                isEditing.toggle()
            }) {
                Text("Editar Informações")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isEditing) {
                EditarInformacoesView(
                    nome: $nome,
                    classe: $classe,
                    classesDisponiveis: classesDisponiveis
                )
            }
        }
        .padding()
    }
}

struct EditarInformacoesView: View {
    // Binding para receber os dados da tela principal
    @Binding var nome: String
    @Binding var classe: String
    let classesDisponiveis: [String]

    // Fechamento do modal
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações do Personagem")) {
                    // Campo Nome
                    TextField("Digite o nome", text: $nome)

                    // Campo Classe (Picker)
                    Picker("Selecione uma classe", selection: $classe) {
                        Text("Selecione").tag("Selecione")
                        ForEach(classesDisponiveis, id: \.self) { classe in
                            Text(classe).tag(classe)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .navigationTitle("Editar Informações")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        dismiss() // Fecha o modal ao salvar
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss() // Fecha o modal ao cancelar
                    }
                }
            }
        }
    }
}

#Preview {
    FichaDePersonagem()
}
