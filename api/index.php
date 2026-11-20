<?php
require_once __DIR__ . '/datos.php';
responder([
    'servicio' => 'API Maki Andino',
    'rutas' => [
        'categorias.php', 'platos.php?categoria_id=1', 'plato.php?id=1',
        'sedes.php', 'ventas.php', 'equipo.php',
    ],
]);
