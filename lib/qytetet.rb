# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Qytetet
# Autor: Jose Luis Gallego Peña

require "singleton"

module ModeloQytetet
   class Qytetet
      include Singleton
      attr_reader :mazo, :tablero, :jugadores, :jugador_actual, :dado
      attr_accessor :carta_actual
      
      #-------------------------------------------------------------------------
      
      @@MAX_JUGADORES = 4
      @@NUM_SORPRESAS = 10
      @@NUM_CASILLAS = 20
      @@PRECIO_LIBERTAD = 200
      @@SALDO_SALIDA = 1000
      
      def initialize
         @mazo = Array.new       # Almacena las cartas
         @jugadores = Array.new  # Jugadores
         @tablero                # Tablero de juego  
         @carta_actual
         @jugador_actual
         @dado
      end
      
      #-------------------------------------------------------------------------
      
      def actuar_si_en_casilla_edificable
         raise NotImplementedError
      end
      
      def actuar_si_en_casilla_no_edificable
         raise NotImplementedError
      end
      
      def aplicar_sorpresa
         raise NotImplementedError
      end
      
      def cancelar_hipoteca(numero_casilla)
         raise NotImplementedError
      end
      
      def comprar_titulo_propiedad
         raise NotImplementedError
      end
      
      def edificar_casa(numero_casilla)
         raise NotImplementedError
      end
      
      def edificar_hotel(numero_casilla)
         raise NotImplementedError
      end
      
      def encarcelar_jugador
         raise NotImplementedError
      end
      
      def get_valor_dado
         raise NotImplementedError
      end
      
      def hipotecar_propiedad(numero_casilla)
         raise NotImplementedError
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
         diferente.", @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)
    
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
      
      def inicializar_juego(nombres)
         inicializar_jugadores(nombres)
         inicializar_tablero
         inicializar_cartas_sorpresa
      end
      
      def inicializar_jugadores(nombres)
         for n in nombres
            @jugadores << Jugador.new(n)
         end
      end
      
      def inicializar_tablero  
         @tablero = Tablero.new      
      end
      
      def intentar_salir_carcel(metodo)
         raise NotImplementedError
      end
      
      def jugar
         raise NotImplementedError
      end
      
      def mover (num_casilla_destino)
         raise NotImplementedError
      end
      
      def obtener_casilla_jugador_actual
         raise NotImplementedError
      end
      
      def obtener_casillas_tablero
         raise NotImplementedError
      end
      
      def obtener_propiedades_jugador
         raise NotImplementedError
      end
      
      def obtener_propiedades_jugador_segun_estado_hipoteca
         raise NotImplementedError
      end
      
      def obtener_ranking
         raise NotImplementedError
      end
      
      def obtener_saldo_jugador_actual
         raise NotImplementedError
      end
      
      def salida_jugadores
         raise NotImplementedError
      end
      
      def siguiente_jugador
         raise NotImplementedError
      end
      
      def tirar_dado
         raise NotImplementedError
      end
      
      def vender_propiedad(numero_casilla)
         raise NotImplementedError
      end
      
      def to_s
         s = "\nJuego Qytetet: #{@tablero.to_s}"
         
         for j in @jugadores
            s = s + j.to_s
         end
         
         for sorp in @mazo
            s = s + sorp.to_s
         end
         
         if @jugador_actual != nil && @carta_actual != nil
            s = s + ", jugador_actual: #{@jugador_actual.to_s}"
            s = s + ", carta_actual: #{@carta_actual.to_s}"
         end
         
         if @dado != nil
            s = s + ", dado: #{@dado.to_s}"
         end
         
         s = s + "\n"
         
         s
      end
      # Visibilidad de los métodos
      # private_class_method :encarcelar_jugador, :salida_jugadores
   end
end
