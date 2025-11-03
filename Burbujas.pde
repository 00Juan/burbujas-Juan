import processing.serial.*;  //<>//
SistemaParticulas s; 
Serial arduino; 
float dato = 0;

// --- CÓDIGO AÑADIDO ---
int idLoteEspecial = 0; // Contador para los lotes únicos
// --- FIN CÓDIGO AÑADIDO ---

void settings()
{
  size(displayWidth, displayHeight);
}

void setup()
{
  printArray(Serial.list());
  String portName = "/dev/cu.usbmodemFX2348N1" ;//portName//Serial.list()[0];
  arduino = new Serial(this, portName, 115200);
  arduino.bufferUntil('\n');

  float viscosidad = 0.02;
  s = new SistemaParticulas(new PVector(40, displayHeight/2), viscosidad);

  // --- LÍNEA MODIFICADA ---
  // Usar HSB es mejor para cambiar colores cíclicamente
  colorMode(HSB, 360, 100, 100, 100); 
  // --- FIN LÍNEA MODIFICADA ---
}

void draw()
{
  // --- LÍNEA MODIFICADA ---
  background(0, 0, 50); // fondo gris oscuro en HSB
  // --- FIN LÍNEA MODIFICADA ---
  
  //if (mousePressed) { s.addParticula(); }
  
  // --- BLOQUE MODIFICADO ---
  if (dato > 700 || mousePressed) { 
    // Llama al nuevo método para añadir un lote con un ID único
    s.addLoteEspecial(idLoteEspecial, 1); 
    // Incrementa el ID para que el *próximo* lote sea diferente
    idLoteEspecial++; 
  }
  // --- FIN BLOQUE MODIFICADO ---
  
  s.run();
}

void mousePressed()
{
  if (mouseButton == RIGHT) { looping = !looping; }
}

void serialEvent(Serial port) 
{
  String datoString = port.readString();
  dato = float(datoString.trim());
}
