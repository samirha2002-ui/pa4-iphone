import Foundation

enum Route: Hashable {
    case galeria
    case categorias
    case platos(categoriaId: Int, nombre: String)
    case detalle(platoId: Int)
    case mapa
    case grafico

    /// Permite abrir la app directamente en una pantalla ("-screen mapa").
    /// Se usa para tomar las capturas automáticas en GitHub Actions.
    static func desdeArgumentos() -> [Route] {
        switch UserDefaults.standard.string(forKey: "screen") {
        case "galeria":    return [.galeria]
        case "categorias": return [.categorias]
        case "platos":     return [.categorias, .platos(categoriaId: 1, nombre: "Makis clásicos")]
        case "detalle":    return [.categorias, .platos(categoriaId: 1, nombre: "Makis clásicos"), .detalle(platoId: 1)]
        case "mapa":       return [.mapa]
        case "grafico":    return [.grafico]
        default:           return []
        }
    }
}
