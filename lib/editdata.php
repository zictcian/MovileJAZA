<?php
include 'conexion.php';

$id=$_POST['id'];
$username=$_POST['email'];
$password=$_POST['password'];
$nombre=$_POST['nombre'];
$imagen=$_POST['imagen'];
$direccion=$_POST['direccion'];
$edad=$_POST['edad'];

$connect->query("UPDATE usuario SET email='".$email."',password='".$password."',nombre='".$nombre."',direccion='".$direccion."',imagen='".$imagen."',edad='".$edad."' WHERE id='".$id."'");
?>