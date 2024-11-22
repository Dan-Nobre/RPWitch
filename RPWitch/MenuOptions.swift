//
//  MenuOptions.swift
//  RPWitch
//
//  Created by Daniel Nobre on 12/11/24.
//

enum MenuOption: CaseIterable {
    case characterSheet
    case characteristics
    case inventory
    case spells

    var title: String {
        switch self {
        case .characterSheet: return "Ficha de Personagem"
        case .characteristics: return "Características"
        case .inventory: return "Inventário"
        case .spells: return "Feitiços"
        }
    }
}
