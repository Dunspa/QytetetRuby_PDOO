# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Tablero
# Autor: Jose Luis Gallego Peña

require_relative "calle.rb"
require_relative "casilla.rb"

module ModeloQytetet
   class Tablero
      attr_reader :casillas, :carcel
      
      #-------------------------------------------------------------------------
      
      @@NUM_CASILLAS = 20
      
      def initialize
         @casillas = Array.new   # Contiene las casillas
         @carcel                 # Indica la cárcel
         
         inicializar
      end
      
      #-------------------------------------------------------------------------
      
      def es_casilla_carcel(numero_casilla)
         return (numero_casilla == @carcel.numero_casilla)
      end
      
      # Inicializa todas las casillas del tablero con sus atributos
      def inicializar
         @casillas << Casilla.new(0, 0, TipoCasilla::SALIDA)
         
         @casillas << Calle.new(1, TituloPropiedad.new("Calle Bufita",
         500, 50, 0.10, 150, 250))
   
         @casillas << Calle.new(2, TituloPropiedad.new("Calle Victoria",
         1000, 100, 0.20, 1000, 750))
   
         @casillas << Casilla.new(3, 0, TipoCasilla::SORPRESA)
         
         @casillas << Casilla.new(4, 0, TipoCasilla::JUEZ)
         
         @casillas << Calle.new(5, TituloPropiedad.new("Hotel Chucho",
         750, 75, 0.15, 400, 400))
         
         @casillas << Calle.new(6, TituloPropiedad.new("Calle Goof",
         600, 60, 0.13, 300, 350))
   
         @casillas << Calle.new(7, TituloPropiedad.new("Centro Comercial Mango",
         1000, 100, 0.20, 1000, 750))
   
         @casillas << Casilla.new(8, 500, TipoCasilla::IMPUESTO)
         
         @casillas << Calle.new(9, TituloPropiedad.new("Calle Rocky",
         500, 50, 0.10, 150, 250))
   
         @casillas << Calle.new(10, TituloPropiedad.new("Museo Gundam",
         850, 75, 0.15, 730, 600))
   
         @casillas << Calle.new(11, TituloPropiedad.new("Cloaca de ratas",
         500, 60, 0.12, 225, 420))
   
         @casillas << Casilla.new(12, 0, TipoCasilla::PARKING)
         
         @casillas << Casilla.new(13, 0, TipoCasilla::SORPRESA)
         
         @casillas << Calle.new(14, TituloPropiedad.new("Bosque Shiba",
         735, 55, 0.17, 500, 500))
   
         @casillas << Calle.new(15, TituloPropiedad.new("Calle Comunicación",
         520, 60, 0.13, 300, 250))
   
         @casillas << Casilla.new(16, 0, TipoCasilla::CARCEL)
         
         @casillas << Calle.new(17, TituloPropiedad.new("Paseo de Torna",
         780, 90, 0.19, 400, 350))
         
         @casillas << Casilla.new(18, 0, TipoCasilla::SORPRESA)
         
         @casillas << Calle.new(19, TituloPropiedad.new("Fábrica de roboces",
         500, 70, 0.10, 999, 475))
   
         @carcel = @casillas[15]
      end
      
      def obtener_casilla_final(casilla, desplazamiento)
         posicion = casilla.numero_casilla + desplazamiento
         if (posicion > 19)
            posicion -= 20
         end
         
         return @casillas.at(posicion)
      end
      
      def obtener_casilla_numero(numero_casilla)
         return @casillas.at(numero_casilla)
      end
      
      def to_s   
         tablero = "\n"
         
         for c in casillas
            tablero = tablero + c.to_s + "\n"
         end
         
         tablero
      end
      
      # Visibilidad de los métodos
      private :inicializar
   end
end
