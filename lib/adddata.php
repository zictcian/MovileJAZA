<?php
include 'conexion.php';

$email=$_POST['email'];
$password=$_POST['password'];
$nombre=$_POST['nombre'];
$imagen=$_POST['imagen'];
$direccion=$_POST['direccion'];
$edad=$_POST['edad'];

$connect->query("INSERT INTO usuario (email,password,nombre,imagen,direccion,edad) VALUES ('".$email."','".$password."','".$nombre."','".$imagen."','".$direccion."','".$edad."')");
?>