//
//  Flower.swift
//  DiffableDataSource
//
//  Created by Le Phuong Tien on 4/29/20.
//  Copyright © 2020 Fx Studio. All rights reserved.
//

import Foundation


class Flower: Identifiable, Hashable {

    let id = UUID()
    var name: String
    var imageName: String

    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Flower, rhs: Flower) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
}

//MARK: - Dummy Data
extension Flower {
    static func mainFlowers() -> [Flower] {
        var flowers: [Flower] = []

        let item1 = Flower(name: "African Daisy", imageName: "flower1")
        flowers.append(item1)


        return flowers
    }
    static func slaveFlowers() -> [Flower] {
        var flowers: [Flower] = []
        let item6 = Flower(name: "Meconopsis", imageName: "flower6")
        flowers.append(item6)

        let item7 = Flower(name: "Osteospermum", imageName: "flower7")
        flowers.append(item7)

        let item8 = Flower(name: "Violet", imageName: "flower8")
        flowers.append(item8)

        let item9 = Flower(name: "Yellow Bell", imageName: "flower9")
        flowers.append(item9)

        let item10 = Flower(name: "Gladiolus", imageName: "flower10")
        flowers.append(item10)

        return flowers
    }
}

