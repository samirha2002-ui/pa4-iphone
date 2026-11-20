import SwiftUI
import Charts

// Punto 6: gráfico de barras con datos de ventas.php
struct GraficoView: View {
    var body: some View {
        RemoteView("ventas.php") { (ventas: [Venta]) in
            GraficoContenido(ventas: ventas)
        }
        .titulo("Estadísticas")
    }
}

private struct GraficoContenido: View {
    let ventas: [Venta]

    private var total: Double { ventas.reduce(0) { $0 + $1.total } }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Ventas del mes")
                        .font(Theme.fuente(13))
                        .foregroundStyle(Theme.secundario)
                    Text(String(format: "S/ %.0f", total))
                        .font(Theme.fuente(32, .bold))
                        .foregroundStyle(Theme.oscuro)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Por categoría")
                        .font(Theme.fuente(16, .semibold))
                        .foregroundStyle(Theme.oscuro)
                    Chart(ventas) { venta in
                        BarMark(
                            x: .value("Categoría", venta.categoria),
                            y: .value("Ventas (S/)", venta.total)
                        )
                        .foregroundStyle(Theme.primario.gradient)
                        .cornerRadius(10)
                        .annotation(position: .top) {
                            Text(String(format: "%.0f", venta.total))
                                .font(Theme.fuente(10, .semibold))
                                .foregroundStyle(Theme.secundario)
                        }
                    }
                    .frame(height: 280)
                }
                .padding(18)
                .tarjeta()
            }
            .padding(20)
        }
    }
}
