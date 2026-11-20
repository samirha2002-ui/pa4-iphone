# Maki Andino · PA4 Aplicaciones Móviles para iPhone

App SwiftUI (iOS 17) de un restaurante de makis, con servicios web en PHP publicados en Alwaysdata.

| Punto | Pantalla | Servicio web |
|---|---|---|
| Galería de imágenes remotas | `GaleriaView` | `equipo.php` |
| Maestro-detalle (3 pantallas) | `CategoriasView` → `PlatosView` → `DetalleView` | `categorias.php`, `platos.php?categoria_id=`, `plato.php?id=` |
| Mapa con marcadores | `MapaView` | `sedes.php` |
| Gráfico de barras | `GraficoView` | `ventas.php` |
| Dashboard | `DashboardView` | — |

## Pasos
1. **Alwaysdata**: la carpeta `api/` se publica en `www/api/` (FTP/SSH). Prueba `https://samirha.alwaysdata.net/api/categorias.php`.
2. **Config**: la URL de la API está en `ios/MakiAndino/Services/Config.swift` (`https://samirha.alwaysdata.net/api`).
3. **Diseño**: usa la paleta y la tipografía (Golos Text) de la referencia https://www.behance.net/gallery/256882763/IKIGAI-Restaurant-App, centralizadas en `ios/MakiAndino/Views/Theme.swift`. Fuentes en `Resources/Fonts` y registradas en `project.yml` (`UIAppFonts`).
4. **GitHub**: en *Settings → Secrets and variables → Actions → Variables* se define `API_BASE` = `https://samirha.alwaysdata.net/api`.
5. **Actions → Compilar iOS y capturas → Run workflow**. Descarga los artifacts `capturas` (7 PNG) y `proyecto-xcode` (incluye el `.xcodeproj`).

## Para la sustentación
- *¿Cómo envías parámetros al servidor?* `APIClient.get` arma la URL con `URLComponents.queryItems` → `platos.php?categoria_id=1`.
- *¿Cómo conviertes el JSON?* `Codable` + `keyDecodingStrategy = .convertFromSnakeCase`.
- *¿Cómo muestras los marcadores?* `Map { ForEach(sedes) { Marker(...) } }` con lat/lon del JSON.
- *¿Cómo haces el gráfico?* `Charts` → `Chart(ventas) { BarMark(x:, y:) }`.
- *¿Cómo cargas imágenes remotas?* `AsyncImage` dentro de `ImagenRemota`.
- *¿Para qué sirve `RemoteView`?* Descarga con `async/await` en `.task` y muestra carga, error o contenido.
