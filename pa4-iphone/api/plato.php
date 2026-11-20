<?php
// Detalle: devuelve un plato por su id.  Ejemplo: plato.php?id=3
require_once __DIR__ . '/datos.php';
$id = isset($_GET['id']) ? (int) $_GET['id'] : 0;
foreach (platos() as $p) {
    if ($p['id'] === $id) {
        responder($p);
    }
}
responder(['error' => 'Plato inexistente'], 404);
