// Archivo: ParticulaEspecial.pde (MODIFICADO)

class ParticulaEspecial extends Particula {

  float angulo;
  float velRotacion;
  color colorLote;
  
  // --- CÓDIGO AÑADIDO ---
  int tipoForma;      // 0: rect, 1: elipse, 2: triángulo
  PVector fuerzaLote;   // Gravedad, viento, etc.
  float cambioTamanio;  // Positivo (crece) o negativo (encoge)
  // --- FIN CÓDIGO AÑADIDO ---


  // --- CONSTRUCTOR MODIFICADO ---
  ParticulaEspecial(PVector donde, int idLote) {
    // 1. Llama al constructor "padre"
    super(donde); 

    // 2. --- DEFINIR PROPIEDADES ÚNICAS BASADAS EN EL ID ---
    
    // a) Color (Igual que antes)
    float matiz = (idLote * 40) % 360;
    colorLote = color(matiz, 90, 90, 80);

    // b) Forma
    // Cambia de forma cada vez: 0, 1, 2, 0, 1, 2, ...
    tipoForma = idLote % 3;

    // c) Tamaño inicial
    tamanio = random(10, 30);
    
    // d) Comportamiento del Tamaño
    // Los lotes pares se encogen, los impares crecen
    if (idLote % 2 == 0) {
      cambioTamanio = random(-0.05, -0.2); // Se encoge
    } else {
      cambioTamanio = random(0.05, 0.2); // Crece
    }

    // e) Velocidad y Dirección Inicial
    // Hacemos que la dirección inicial también dependa del lote
    float dirX = random(1, 4);
    float dirY = random(-3, 3);
    if (idLote % 4 == 1) dirY = random(-5, -2); // Lotes tipo 1 van más hacia arriba
    if (idLote % 4 == 2) dirX = random(-4, -1); // Lotes tipo 2 van hacia la izquierda
    velocidad = new PVector(dirX, dirY);
    
    // f) Física (Fuerza constante)
    // Cambia la "física" para cada lote
    int tipoFisica = idLote % 4;
    if (tipoFisica == 0) {
      fuerzaLote = new PVector(0, 0.1); // Gravedad normal
    } else if (tipoFisica == 1) {
      fuerzaLote = new PVector(0, 0); // Sin gravedad (flota)
    } else if (tipoFisica == 2) {
      fuerzaLote = new PVector(0.05, 0.05); // Viento a la derecha + gravedad leve
    } else {
      fuerzaLote = new PVector(0, -0.05); // Anti-gravedad (sube)
    }

    // g) Rotación
    velRotacion = random(-0.05, 0.05) * (idLote % 4 + 1); // Más rápido en algunos lotes
    angulo = random(TWO_PI);
  }
  // --- FIN CONSTRUCTOR MODIFICADO ---

  @Override
  void update() {
    // Aplicar la fuerza única de este lote
    aplicarFuerza(fuerzaLote); 

    velocidad.add(aceleracion);
    posicion.add(velocidad);
    angulo += velRotacion;
    aceleracion.mult(0);   

    // Usar el comportamiento de tamaño único
    tamanio += cambioTamanio; 
    
    // Morir si es muy pequeño (y no está creciendo)
    if (tamanio < 1 && cambioTamanio < 0) {
      isDead = true;
    }
    
    // Morir si sale de la pantalla
    if (posicion.y > height + tamanio || posicion.y < -tamanio || 
        posicion.x > width + tamanio || posicion.x < -tamanio) {
      isDead = true;
    }
  }

  @Override
  void aplicarViscosidad(float v) {
    // Esta partícula ignora la viscosidad del sistema
  }

  // --- RENDER MODIFICADO ---
  @Override
  void render() {
    push();
    fill(colorLote);
    noStroke(); // Se ve más limpio
    
    // Aplica transformación
    translate(posicion.x, posicion.y);
    rotate(angulo);
    
    // Dibuja la forma correcta
    if (tipoForma == 0) {
      // Rectángulo
      rectMode(CENTER);
      rect(0, 0, tamanio, tamanio);
    } else if (tipoForma == 1) {
      // Elipse
      ellipseMode(CENTER);
      ellipse(0, 0, tamanio, tamanio * 0.7); // Un poco ovalado
    } else {
      // Triángulo
      triangle(0, -tamanio/2, -tamanio/2, tamanio/2, tamanio/2, tamanio/2);
    }
    
    pop();
  }
}
