import Foundation

struct Categoria: Codable, Identifiable, Hashable {
    let id: Int
    let nombre: String
    let descripcion: String
    let icono: String
    let imagen: String
}

struct Plato: Codable, Identifiable, Hashable {
    let id: Int
    let categoriaId: Int
    let nombre: String
    let descripcion: String
    let precio: Double
    let calorias: Int
    let tiempo: Int
    let imagen: String
}

struct Sede: Codable, Identifiable, Hashable {
    let id: Int
    let nombre: String
    let direccion: String
    let latitud: Double
    let longitud: Double
}

struct Venta: Codable, Identifiable {
    let categoria: String
    let total: Double
    var id: String { categoria }
}

struct Miembro: Codable, Identifiable, Hashable {
    let id: Int
    let nombre: String
    let cargo: String
    let foto: String
}
