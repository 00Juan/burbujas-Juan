// Archivo: ParticulaEspecial.pde (MODIFICADO)

class ParticulaEspecial extends Particula {

  float angulo;
  float velRotacion;
  
  // --- CÓDIGO AÑADIDO ---
  color colorLote; // Almacenará el color único de este lote
  // --- FIN CÓDIGO AÑADIDO ---

  // --- CONSTRUCTOR MODIFICADO ---
  ParticulaEspecial(PVector donde, int idLote) {
    // 1. Llama al constructor "padre"
    super(donde); 

    // 2. Propiedades sobrescritas
    velocidad = new PVector(random(-2, 2), random(-5, -3));
    tamanio = random(15, 25);
    
    // 3. --- COMPORTAMIENTO ÚNICO BASADO EN EL ID ---
    
    // a) Color único:
    // Calcula un matiz (Hue) basado en el ID. 
    // Multiplicamos por 40 para que los colores sean bien distintos.
    // El % 360 asegura que el valor siempre esté en el rango de 0-360.
    float matiz = (idLote * 40) % 360;
    colorLote = color(matiz, 90, 90, 80); // Color brillante, 80% alfa
    
    // b) Comportamiento único (Rotación):
    // La velocidad de rotación cambia según el ID.
    // Usamos (idLote % 5 + 1) para que la velocidad cicle (1x, 2x, 3x, 4x, 5x, 1x, ...)
    velRotacion = random(-0.05, 0.05) * (idLote % 5 + 1);
    
    angulo = random(TWO_PI);
  }
  // --- FIN CONSTRUCTOR MODIFICADO ---

  // ... (update y aplicarViscosidad sin cambios respecto a la respuesta anterior) ...
  @Override
  void update() {
    PVector gravedad = new PVector(0, 0.1);
    aplicarFuerza(gravedad);

    velocidad.add(aceleracion);
    posicion.add(velocidad);
    angulo += velRotacion; // Usa la velocidad de rotación única
    aceleracion.mult(0);   

    tamanio -= 0.05; 
    
    if (tamanio < 1 || posicion.y > height + tamanio) {
      isDead = true;
    }
  }

  @Override
  void aplicarViscosidad(float v) {
    // Esta partícula ignora la viscosidad.
  }

  // --- RENDER MODIFICADO ---
  @Override
  void render() {
    push();
    // Usa el color único del lote
    fill(colorLote); 
    rectMode(CENTER);
    
    translate(posicion.x, posicion.y);
    rotate(angulo);
    
    rect(0, 0, tamanio, tamanio);
    pop();
  }
}
