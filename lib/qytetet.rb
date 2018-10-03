# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Qytetet
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Qytetet
    
      attr_reader :mazo, :tablero
    
      def initialize
      
         @mazo = Array.new # Almacena las cartas
         @tablero          # Tablero de juego
         
      end
    
      # Se crean y se incluyen en el mazo todas las cartas sorpresa
      def inicializar_cartas_sorpresa
      
         # PAGARCOBRAR #
      
         # Carta sorpresa que suma una cantidad de dinero al saldo del jugador
         @mazo << Sorpresa.new("Después de ser un fracasado toda tu vida, 
         ¡te toca la lotería! ...Pero sigues siendo un fracasado.", 7000, 
         TipoSorpresa::PAGARCOBRAR)
      
         # Carta sorpresa que resta una cantidad de dinero al saldo del jugador
         @mazo << Sorpresa.new("El banco te quita dinero porque sí, da gracias
         que aún sigas teniendo un plato que poner en la mesa.", -7000,
         TipoSorpresa::PAGARCOBRAR)
    
         # IRACASILLA #
      
         # Carta sorpresa que manda al jugador a la cárcel
         @mazo << Sorpresa.new("Has sido pillado, mejor suerte la próxima vez. 
         ¡A la carcel!", 9, TipoSorpresa::IRACASILLA)
      
         # Carta sorpresa que manda al jugador a una casilla
         @mazo << Sorpresa.new("Te tropiezas y sales volando a una casilla 
         diferente.", @tablero.carcel.numeroCasilla, TipoSorpresa::IRACASILLA)
    
         # Carta sorpresa que manda al jugador a una casilla
         @mazo << Sorpresa.new("Te tropiezas y sales volando a una casilla 
         diferente.", 4, TipoSorpresa::IRACASILLA)
    
         # PORCASAHOTEL #
      
         # Carta sorpresa que hace que el jugador cobre por su propiedad
         @mazo << Sorpresa.new("Tu propiedad ha obtenido beneficios así que te 
         llevas un buen pico", 10000, TipoSorpresa::PORCASAHOTEL)
      
         # Carta sorpresa que hace que el jugador pague por su propiedad
         @mazo << Sorpresa.new("Te toca pagar por tener tierras, no seas tan
         avaricioso la próxima vez.", -10000, TipoSorpresa::PORCASAHOTEL)
      
         # PORJUGADOR #
      
         # Carta sorpresa que hace que todos los jugadores te paguen
         @mazo << Sorpresa.new("Hoy es tu día de suerte, todos los jugadores
         deben pagarte por tu cara bonita.", 3000, TipoSorpresa::PORJUGADOR)
      
         # Carta sorpresa que hace que tengas que pagar a todos los jugadores
         @mazo << Sorpresa.new("Hoy no es tu día de suerte, debes pagar a todos
         los jugadores porque así lo dice esta carta.", -3000, 
         TipoSorpresa::PORJUGADOR)
    
         # SALIRCARCEL #
      
         # Carta sorpresa que saca al jugador de la cárcel
         @mazo << Sorpresa.new("Parece ser que le has caído bien a alguien y ha
         pagado tu fianza. Sales de la cárcel.", 0, TipoSorpresa::SALIRCARCEL)
      
      end
      
      # Inicializa el tablero de juego
      def inicializar_tablero
         
         @tablero = Tablero.new
         
      end
      
   end
end
