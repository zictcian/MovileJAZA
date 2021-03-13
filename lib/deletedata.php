<?php
include 'conexion.php';
$id=$_POST['id'];
$connect->query("DELETE FROM usuario WHERE id="$id);
?>