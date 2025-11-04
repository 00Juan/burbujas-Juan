// Archivo: Particula.pde (Revisado)

class Particula {
  
  // --- ASEGÚRATE DE QUE ESTAS LÍNEAS SEAN CORRECTAS ---
  PVector posicion;
  PVector velocidad;
  PVector aceleracion;
  float tamanio;
  boolean isDead;
  // --------------------------------------------------
  
  Particula(PVector donde)
  {
    // Si la línea de arriba "PVector posicion;" está mal escrita,
    // esta línea (la de abajo) dará el error que mencionas.
    posicion = donde.copy(); 
    velocidad = new PVector(random(2,4), random(-1.0, 1));
    aceleracion = new PVector(0,0);
    tamanio = random(20,35);
    isDead = false;
  }
  
  void run()
  { 
    if (!isDead) {
      update();
      render();
    }
  }
  
  void update()
  {
    velocidad.add(aceleracion);
    posicion.add(velocidad); // El error también podría ocurrir aquí
    tamanio += 0.1;
    if (velocidad.mag() < 0.01) {isDead = true;}
    if (random(0,1000) > 995) {isDead = true; }
    
    aceleracion.mult(0); // Resetea la aceleración
  }
  
  void aplicarFuerza(PVector f) 
  {
    // Como si la masa fuera siempre 1: 
    aceleracion.add(f);
  }
  
  void aplicarViscosidad(float v) 
  {
    float magnitudvelocidad = velocidad.mag();
    float magnitudresistencia = 0.0001 * v * magnitudvelocidad * magnitudvelocidad;
    PVector resistencia = velocidad.copy();
    resistencia.mult(-1); // dirección inversa a la velocidad
    resistencia.setMag(magnitudresistencia);
    aplicarFuerza(resistencia);
  }
  
  void render()
  {
    push();
    // Color blanco, 50% alfa en modo HSB
    fill(0, 0, 100, 50); 
    ellipseMode(CENTER);
    ellipse(posicion.x, posicion.y, tamanio, tamanio); // O aquí
    pop();
  }
}
