import SwiftUI

private struct Acceso: Identifiable {
    let id = UUID()
    let titulo: String
    let subtitulo: String
    let icono: String
    let ruta: Route
    let color: Color
}

struct DashboardView: View {
    @State private var ruta: [Route] = Route.desdeArgumentos()

    private let accesos: [Acceso] = [
        Acceso(titulo: "Nuestro menú", subtitulo: "Categorías y makis", icono: "fork.knife", ruta: .categorias, color: Theme.primario),
        Acceso(titulo: "Galería", subtitulo: "Conoce al equipo", icono: "photo.on.rectangle.angled", ruta: .galeria, color: Theme.acento),
        Acceso(titulo: "Sedes", subtitulo: "Encuéntranos en el mapa", icono: "mappin.and.ellipse", ruta: .mapa, color: Theme.oscuro),
        Acceso(titulo: "Estadísticas", subtitulo: "Ventas por tipo de maki", icono: "chart.bar.fill", ruta: .grafico, color: Theme.primario)
    ]

    private let columnas = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]

    var body: some View {
        NavigationStack(path: $ruta) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    encabezado
                    hero
                    Text("¿Qué deseas hacer?")
                        .font(Theme.fuente(18, .semibold))
                        .foregroundStyle(Theme.oscuro)
                    LazyVGrid(columns: columnas, spacing: 16) {
                        ForEach(accesos) { acceso in
                            NavigationLink(value: acceso.ruta) {
                                AccesoCard(acceso: acceso)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(20)
            }
            .background(Theme.fondo.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Route.self) { destino in
                switch destino {
                case .galeria: GaleriaView()
                case .categorias: CategoriasView()
                case .platos(let id, let nombre): PlatosView(categoriaId: id, nombre: nombre)
                case .detalle(let id): DetalleView(platoId: id)
                case .mapa: MapaView()
                case .grafico: GraficoView()
                }
            }
        }
        .font(Theme.fuente(15))
    }

    private var encabezado: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Bienvenido a")
                    .font(Theme.fuente(14))
                    .foregroundStyle(Theme.secundario)
                Text("Maki Andino")
                    .font(Theme.fuente(28, .semibold))
                    .foregroundStyle(Theme.oscuro)
            }
            Spacer()
            Image(systemName: "flame.fill")
                .font(.title2)
                .foregroundStyle(Theme.primario)
                .frame(width: 52, height: 52)
                .background(.ultraThinMaterial, in: Circle())
                .overlay(Circle().stroke(Theme.oscuro.opacity(0.08), lineWidth: 1))
        }
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [Theme.primario, Theme.oscuro],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            Circle()
                .fill(Theme.acento.opacity(0.45))
                .frame(width: 190, height: 190)
                .blur(radius: 34)
                .offset(x: 170, y: -70)
            VStack(alignment: .leading, spacing: 8) {
                Text("Makis nikkei hechos al momento")
                    .font(Theme.fuente(24, .bold))
                    .foregroundStyle(.white)
                Text("Rollos frescos con sabores de Lima y 4 sedes en la ciudad.")
                    .font(Theme.fuente(13))
                    .foregroundStyle(.white.opacity(0.85))
            }
            .padding(24)
        }
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: Theme.primario.opacity(0.35), radius: 20, x: 0, y: 12)
    }
}

private struct AccesoCard: View {
    let acceso: Acceso

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: acceso.icono)
                .font(.title3)
                .foregroundStyle(acceso.color)
                .frame(width: 48, height: 48)
                .background(acceso.color.opacity(0.14), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            Spacer(minLength: 0)
            Text(acceso.titulo)
                .font(Theme.fuente(16, .semibold))
                .foregroundStyle(Theme.oscuro)
            Text(acceso.subtitulo)
                .font(Theme.fuente(12))
                .foregroundStyle(Theme.secundario)
                .lineLimit(2)
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 160, alignment: .leading)
        .tarjeta()
    }
}
