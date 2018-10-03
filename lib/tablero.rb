# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Tablero
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Tablero
      
      attr_reader :casillas, :carcel
      
      def initialize
      
         @casillas = Array.new   # Contiene las casillas
         @carcel                 # Indica la cárcel
         
         inicializar
         
      end
      
      # Inicializa todas las casillas del tablero con sus atributos
      def inicializar
         
         @casillas << Casilla.new_casilla_normal(0, 0, TipoCasilla::SALIDA)
         
         @casillas << Casilla.new_calle(1, TituloPropiedad.new("Calle Bufita",
         500, 50, 0.10, 150, 250))
   
         @casillas << Casilla.new_calle(2, TituloPropiedad.new("Calle Victoria",
         1000, 100, 0.20, 1000, 750))
   
         @casillas << Casilla.new_casilla_normal(3, 0, TipoCasilla::SORPRESA)
         
         @casillas << Casilla.new_casilla_normal(4, 0, TipoCasilla::JUEZ)
         
         @casillas << Casilla.new_calle(5, TituloPropiedad.new("Hotel Chucho",
         750, 75, 0.15, 400, 400))
         
         @casillas << Casilla.new_calle(6, TituloPropiedad.new("Calle Goof",
         600, 60, 0.13, 300, 350))
   
         @casillas << Casilla.new_calle(7, TituloPropiedad.new("Centro Comercial Mango",
         1000, 100, 0.20, 1000, 750))
   
         @casillas << Casilla.new_casilla_normal(8, 500, TipoCasilla::IMPUESTO)
         
         @casillas << Casilla.new_calle(9, TituloPropiedad.new("Calle Rocky",
         500, 50, 0.10, 150, 250))
   
         @casillas << Casilla.new_calle(10, TituloPropiedad.new("Museo Gundam",
         850, 75, 0.15, 730, 600))
   
         @casillas << Casilla.new_calle(11, TituloPropiedad.new("Cloaca de ratas",
         500, 60, 0.12, 225, 420))
   
         @casillas << Casilla.new_casilla_normal(12, 0, TipoCasilla::PARKING)
         
         @casillas << Casilla.new_casilla_normal(13, 0, TipoCasilla::SORPRESA)
         
         @casillas << Casilla.new_calle(14, TituloPropiedad.new("Bosque Shiba",
         735, 55, 0.17, 500, 500))
   
         @casillas << Casilla.new_calle(15, TituloPropiedad.new("Calle Comunicación",
         520, 60, 0.13, 300, 250))
   
         @casillas << Casilla.new_casilla_normal(16, 0, TipoCasilla::CARCEL)
         
         @casillas << Casilla.new_calle(17, TituloPropiedad.new("Paseo de Torna",
         780, 90, 0.19, 400, 350))
         
         @casillas << Casilla.new_casilla_normal(18, 0, TipoCasilla::SORPRESA)
         
         @casillas << Casilla.new_calle(19, TituloPropiedad.new("Fábrica de roboces",
         500, 70, 0.10, 999, 475))
   
         @carcel = @casillas[15]
         
      end
      
      def to_s
         
         tablero = ""
         
         for c in casillas
            tablero = tablero + c.to_s + "\n"
         end
         
         tablero
         
      end
      
      private :inicializar
      
   end
end
