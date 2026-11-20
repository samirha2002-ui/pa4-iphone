<?php
// Datos y utilidades compartidas por todos los servicios web de Maki Andino.

function responder($datos, int $codigo = 200): void {
    http_response_code($codigo);
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *');
    echo json_encode($datos, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// Imágenes remotas.
// Si existe api/img/<nombre>.jpg (o .png / .webp) se usa esa foto; si no, una imagen de ejemplo.
function img(string $nombre, int $w = 800, int $h = 600): string {
    foreach (['jpg', 'jpeg', 'png', 'webp'] as $ext) {
        if (file_exists(__DIR__ . "/img/$nombre.$ext")) {
            return 'https://' . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['SCRIPT_NAME']), '/') . "/img/$nombre.$ext";
        }
    }
    return "https://picsum.photos/seed/$nombre/$w/$h";
}

function categorias(): array {
    return [
        ['id' => 1, 'nombre' => 'Makis clásicos', 'descripcion' => 'Los rolls de siempre, frescos y bien enrollados', 'icono' => 'fork.knife', 'imagen' => img('makis-clasicos')],
        ['id' => 2, 'nombre' => 'Makis acevichados', 'descripcion' => 'Fusión nikkei con sabores de Lima', 'icono' => 'star.fill', 'imagen' => img('makis-acevichados')],
        ['id' => 3, 'nombre' => 'Makis tempura', 'descripcion' => 'Crocantes por fuera, suaves por dentro', 'icono' => 'flame.fill', 'imagen' => img('makis-tempura')],
        ['id' => 4, 'nombre' => 'Makis vegetarianos', 'descripcion' => 'Opciones frescas sin pescado ni carne', 'icono' => 'leaf.fill', 'imagen' => img('makis-vegetarianos')],
    ];
}

function plato(int $id, int $cat, string $nombre, string $desc, float $precio, int $cal, int $min, string $semilla): array {
    return [
        'id' => $id, 'categoria_id' => $cat, 'nombre' => $nombre, 'descripcion' => $desc,
        'precio' => $precio, 'calorias' => $cal, 'tiempo' => $min, 'imagen' => img($semilla),
    ];
}

function platos(): array {
    return [
        plato(1, 1, 'California maki', 'Rollo de 8 piezas con kani, palta y pepino, cubierto de ajonjolí tostado.', 28.00, 320, 12, 'california-maki'),
        plato(2, 1, 'Philadelphia maki', 'Salmón fresco, queso crema y cebollita china envueltos en arroz de sushi.', 32.00, 360, 12, 'philadelphia-maki'),
        plato(3, 1, 'Tuna maki', 'Atún fresco con palta y un toque de ají amarillo, 8 piezas.', 30.00, 300, 12, 'tuna-maki'),
        plato(4, 1, 'Ebi maki', 'Langostino cocido, pepino y mayonesa japonesa, envuelto en alga nori.', 29.00, 310, 12, 'ebi-maki'),
        plato(5, 2, 'Maki acevichado', 'Langostino empanizado y palta, bañado en salsa acevichada y cebolla crocante.', 34.00, 420, 15, 'maki-acevichado'),
        plato(6, 2, 'Maki tiradito', 'Pescado blanco laminado con crema de ají amarillo y cancha molida.', 36.00, 350, 15, 'maki-tiradito'),
        plato(7, 2, 'Maki nikkei', 'Salmón, palta y cebolla roja con un chorrito de leche de tigre.', 35.00, 380, 15, 'maki-nikkei'),
        plato(8, 2, 'Maki lomo saltado', 'Lomo fino salteado al wok con cebolla y tomate, sobre arroz sushi y salsa de soya.', 38.00, 480, 18, 'maki-lomo-saltado'),
        plato(9, 3, 'Ebi tempura maki', 'Langostino en tempura crocante, palta y salsa teriyaki, 8 piezas.', 33.00, 440, 15, 'ebi-tempura-maki'),
        plato(10, 3, 'Crispy salmon maki', 'Salmón frito en panko, queso crema y salsa anguila.', 35.00, 470, 15, 'crispy-salmon-maki'),
        plato(11, 3, 'Spicy tuna crunch', 'Atún picante con tempura crujiente por encima y mayonesa sriracha.', 36.00, 430, 15, 'spicy-tuna-crunch'),
        plato(12, 3, 'Dragon maki', 'Anguila y pepino por dentro, palta en láminas por fuera y salsa unagi.', 40.00, 520, 18, 'dragon-maki'),
        plato(13, 4, 'Avocado maki', 'Palta cremosa y pepino envueltos en arroz de sushi y ajonjolí.', 22.00, 250, 10, 'avocado-maki'),
        plato(14, 4, 'Kappa maki', 'Rollo fino de pepino, simple y refrescante, 6 piezas.', 18.00, 180, 8, 'kappa-maki'),
        plato(15, 4, 'Veggie tempura maki', 'Zapallo, camote y espárrago en tempura con salsa dulce de soya.', 26.00, 400, 15, 'veggie-tempura-maki'),
        plato(16, 4, 'Maki de camote crocante', 'Camote frito, palta y queso crema vegetal con topping de panko.', 24.00, 390, 15, 'maki-camote'),
    ];
}

function sedes(): array {
    return [
        ['id' => 1, 'nombre' => 'Maki Andino San Isidro', 'direccion' => 'Av. Conquistadores 450, San Isidro', 'latitud' => -12.0977, 'longitud' => -77.0365],
        ['id' => 2, 'nombre' => 'Maki Andino Miraflores', 'direccion' => 'Av. Larco 1120, Miraflores', 'latitud' => -12.1219, 'longitud' => -77.0297],
        ['id' => 3, 'nombre' => 'Maki Andino Surco', 'direccion' => 'Av. Caminos del Inca 2200, Santiago de Surco', 'latitud' => -12.1450, 'longitud' => -76.9910],
        ['id' => 4, 'nombre' => 'Maki Andino La Molina', 'direccion' => 'Av. La Molina 1850, La Molina', 'latitud' => -12.0850, 'longitud' => -76.9420],
    ];
}

function ventas(): array {
    return [
        ['categoria' => 'Clásicos', 'total' => 18450.0],
        ['categoria' => 'Acevichados', 'total' => 9320.0],
        ['categoria' => 'Tempura', 'total' => 4180.0],
        ['categoria' => 'Vegetarianos', 'total' => 7260.0],
    ];
}

function equipo(): array {
    $f = fn(int $n) => "https://i.pravatar.cc/400?img=$n";
    return [
        ['id' => 1, 'nombre' => 'Rocío Quispe', 'cargo' => 'Itamae (chef de sushi)', 'foto' => $f(47)],
        ['id' => 2, 'nombre' => 'Marco Salazar', 'cargo' => 'Maestro de makis', 'foto' => $f(12)],
        ['id' => 3, 'nombre' => 'Lucía Paredes', 'cargo' => 'Cocina fría', 'foto' => $f(32)],
        ['id' => 4, 'nombre' => 'Diego Huamán', 'cargo' => 'Barman', 'foto' => $f(33)],
        ['id' => 5, 'nombre' => 'Carla Rivas', 'cargo' => 'Jefa de sala', 'foto' => $f(5)],
        ['id' => 6, 'nombre' => 'Jorge Mendoza', 'cargo' => 'Sommelier de sake', 'foto' => $f(60)],
    ];
}
