import processing.serial.*;  //<>//
SistemaParticulas s; 
Serial arduino; 
float dato = 0;

int idLoteEspecial = 0; // Contador para los lotes únicos
// --- CÓDIGO AÑADIDO ---
boolean sensorEstabaActivo = false; // Para detectar el "flanco de subida"
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

  colorMode(HSB, 360, 100, 100, 100); 
}

void draw()
{
  background(0, 0, 50); 
  
  if (mousePressed) { s.addParticula(); }
  
  // --- BLOQUE MODIFICADO ---
  
  boolean sensorEstaActivo = (dato > 700);
  
  if (sensorEstaActivo) {
    if (!sensorEstabaActivo) {
      // El sensor ACABA de activarse. 
      // Incrementamos el ID para crear un nuevo tipo de partícula.
      idLoteEspecial++;
    }
    // Mientras el sensor esté activo, crea UNA partícula por frame.
    // Todas usarán el mismo idLoteEspecial hasta que el sensor se apague y se vuelva a encender.
    s.addLoteEspecial(idLoteEspecial, 1); // <--- CAMBIADO DE 5 A 1
  }
  
  // Actualiza el estado para el próximo frame
  sensorEstabaActivo = sensorEstaActivo;
  
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
