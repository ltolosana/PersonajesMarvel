# PersonajesMarvel

Esta aplicación hace uso de la API de Marvel (https://developer.marvel.com/docs), por lo que el primer paso es generar una **APIKEY** y un **HASH** siguiendo las instrucciones que se detallan en la documentación de la API.

En segundo lugar hay que crear dentro del proyecto un fichero *.plist* llamado **apikey.plist**

Este fichero es un diccionario que deberá tener tres entradas clave/valor. Las claves son las siguientes:

  “urlApikey”

  “urlHash”

  “urlTs”

El valor (de tipo String) de cada clave, sera el correspondiente que se haya usado/generado en el primer paso.
