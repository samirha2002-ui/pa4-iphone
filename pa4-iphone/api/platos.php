<?php
// Maestro: lista los platos de una categoría.  Ejemplo: platos.php?categoria_id=1
require_once __DIR__ . '/datos.php';
$categoriaId = isset($_GET['categoria_id']) ? (int) $_GET['categoria_id'] : 0;
$lista = array_values(array_filter(platos(), fn($p) => $p['categoria_id'] === $categoriaId));
if (count($lista) === 0) {
    responder(['error' => 'Categoría inexistente'], 404);
}
responder($lista);
