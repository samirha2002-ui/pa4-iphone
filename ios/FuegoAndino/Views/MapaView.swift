import SwiftUI
import MapKit

// Punto 5: mapa con marcadores cuya latitud, longitud y etiqueta vienen de sedes.php
struct MapaView: View {
    var body: some View {
        RemoteView("sedes.php") { (sedes: [Sede]) in
            MapaContenido(sedes: sedes)
        }
        .titulo("Nuestras sedes")
    }
}

private struct MapaContenido: View {
    let sedes: [Sede]

    private var region: MKCoordinateRegion {
        let lat = sedes.map(\.latitud).reduce(0, +) / Double(max(sedes.count, 1))
        let lon = sedes.map(\.longitud).reduce(0, +) / Double(max(sedes.count, 1))
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.16)
        )
    }

    var body: some View {
        Map(initialPosition: .region(region)) {
            ForEach(sedes) { sede in
                Marker(sede.nombre,
                       systemImage: "flame.fill",
                       coordinate: CLLocationCoordinate2D(latitude: sede.latitud, longitude: sede.longitud))
                    .tint(Theme.primario)
            }
        }
        .safeAreaInset(edge: .bottom) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(sedes) { sede in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(sede.nombre)
                                .font(Theme.fuente(13, .semibold))
                                .foregroundStyle(Theme.oscuro)
                            Text(sede.direccion)
                                .font(Theme.fuente(11))
                                .foregroundStyle(Theme.secundario)
                                .lineLimit(2)
                        }
                        .padding(14)
                        .frame(width: 220, alignment: .leading)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Theme.oscuro.opacity(0.08), lineWidth: 1))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
        }
    }
}
