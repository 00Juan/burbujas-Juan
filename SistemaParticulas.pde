class SistemaParticulas {
  
  ArrayList<Particula> particulas; 
  PVector origin;
  float viscosidad;
  
  SistemaParticulas(PVector pos, float v) 
  {
    particulas = new ArrayList<Particula>();
    origin = pos.copy();
    viscosidad = v;
  }
  
  void addParticula() 
  {
    Particula p = new Particula(origin);
    particulas.add(p);
  }
  
  void addParticula(int cuantas) 
  {
    for(int i = 0; i < cuantas; i++) {
      addParticula();
    }
  }  
  
  // --- CÓDIGO MODIFICADO ---
  /**
   * Añade un LOTE de partículas especiales.
   * Todas las partículas de este lote compartirán el mismo idLote.
   */
  void addLoteEspecial(int idLote, int cuantas) 
  {
    for(int i = 0; i < cuantas; i++) {
      // Pasa el ID al constructor de la ParticulaEspecial
      Particula p = new ParticulaEspecial(origin, idLote);
      particulas.add(p);
    }
  }
  // --- FIN CÓDIGO MODIFICADO ---
  
  void run() 
  {
    // Iterar hacia atrás es más seguro al eliminar
    for(int i = particulas.size()-1; i >= 0; i--) { 
      Particula p = particulas.get(i);
      p.aplicarViscosidad(viscosidad); 
      p.run();                         
      if (p.isDead) {
        particulas.remove(i);
      }
    }
  }
}
