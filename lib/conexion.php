<?php 
$connect = new mysqli("localhost","zictcianz","zictcianz","jaza");

if($connect){

}else{
    echo "Fallo, revise ip o firewall";
    exit();
}