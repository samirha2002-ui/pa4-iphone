import SwiftUI

/// Imagen remota con indicador de carga y respaldo si falla.
struct ImagenRemota: View {
    let url: String

    var body: some View {
        Theme.borde.opacity(0.5)
            .overlay {
                AsyncImage(url: URL(string: url)) { fase in
                    switch fase {
                    case .success(let imagen):
                        imagen.resizable().scaledToFill()
                    case .failure:
                        Image(systemName: "photo").font(.title).foregroundStyle(Theme.secundario)
                    default:
                        ProgressView()
                    }
                }
            }
            .clipped()
    }
}

struct ErrorView: View {
    let mensaje: String
    let reintentar: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 44))
                .foregroundStyle(Theme.primario)
            Text("No se pudo cargar")
                .font(Theme.fuente(18, .semibold))
                .foregroundStyle(Theme.oscuro)
            Text(mensaje)
                .font(Theme.fuente(13))
                .foregroundStyle(Theme.secundario)
                .multilineTextAlignment(.center)
            Button("Reintentar", action: reintentar)
                .font(Theme.fuente(15, .semibold))
                .padding(.horizontal, 24).padding(.vertical, 12)
                .background(Theme.oscuro, in: Capsule())
                .foregroundStyle(.white)
        }
        .padding(32)
    }
}

/// Vista genérica: descarga un JSON del servicio web, muestra carga / error / contenido.
struct RemoteView<T: Decodable, Content: View>: View {
    private enum Estado {
        case cargando
        case error(String)
        case listo(T)
    }

    let endpoint: String
    let query: [String: String]
    let contenido: (T) -> Content
    @State private var estado: Estado = .cargando

    init(_ endpoint: String,
         query: [String: String] = [:],
         @ViewBuilder contenido: @escaping (T) -> Content) {
        self.endpoint = endpoint
        self.query = query
        self.contenido = contenido
    }

    var body: some View {
        Group {
            switch estado {
            case .cargando:
                ProgressView("Cargando…")
                    .font(Theme.fuente(14))
                    .tint(Theme.primario)
            case .error(let mensaje):
                ErrorView(mensaje: mensaje) { Task { await cargar() } }
            case .listo(let datos):
                contenido(datos)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.fondo.ignoresSafeArea())
        .task { await cargar() }
    }

    private func cargar() async {
        estado = .cargando
        do {
            let datos: T = try await APIClient.get(endpoint, query: query)
            estado = .listo(datos)
        } catch {
            estado = .error(error.localizedDescription)
        }
    }
}
