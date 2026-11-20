import Foundation

enum Config {
    // URL de los servicios web publicados en Alwaysdata (carpeta www/api).
    static let baseURLPorDefecto = "https://samirha.alwaysdata.net/api"

    // Permite sobrescribirla con el argumento de lanzamiento "-api-base <url>" (lo usa GitHub Actions).
    static var baseURL: String {
        UserDefaults.standard.string(forKey: "api-base") ?? baseURLPorDefecto
    }
}
