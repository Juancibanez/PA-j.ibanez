//Pseudocódigo

//Inicio

//    Declarar lista de escenas
//    Declarar variable escenaActual ← 0

//    Procedimiento setup
//        Definir tamaño de ventana
//        Inicializar lista de escenas

//        Por cada escena clave
//            Crear objeto Escena con texto, imagen y audio (si aplica)
//            Agregarlo a la lista

//        Alinear texto al centro
//        Definir tamaño de fuente
//    FinProcedimiento

//    Procedimiento draw
//        Limpiar pantalla
//        Mostrar escena en posición escenaActual
//    FinProcedimiento

//    Procedimiento keyPressed
//        Si se presiona tecla flecha derecha o ENTER entonces
//            Incrementar escenaActual
//            Si escenaActual ≥ número de escenas
//                escenaActual ← última escena
//            FinSi
//        FinSi
//    FinProcedimiento

//    Procedimiento mousePressed
//        // Aquí se podría activar una acción especial, como reproducir un audio
//        // Si la escena actual tiene audio, se reproduce
//    FinProcedimiento

//    Clase Escena
//        Atributos:
//            texto
//            imagen
//            audio

//        Constructor Escena(texto, imagen, audio)
//            Asignar valores a los atributos

//        Método mostrar()
//            Mostrar imagen si existe
//            Mostrar texto en el centro
//            Reproducir audio si aplica (según el diseño)
//        FinMétodo
//    FinClase

//Fin
