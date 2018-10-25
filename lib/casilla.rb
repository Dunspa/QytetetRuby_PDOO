# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Casilla
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Casilla
      attr_reader :numero_casilla, :coste, :tipo
      attr_accessor :titulo
      
      #-------------------------------------------------------------------------
      
      # Constructor
      def initialize(numcasilla, cost, tip, tit)
         @numero_casilla = numcasilla   # Número de casilla (posición en tablero)
         @coste = cost                 # Coste de la casilla
         @tipo = tip                   # Tipo de la casilla
         @titulo = tit                 # Asocia la casilla a su título
      end
      
      # Constructor si la casilla es una calle
      def self.new_calle(numcasilla, tit)
         self.new(numcasilla, tit.precioCompra, TipoCasilla::CALLE, tit)  
      end
      
      # Constructor para cualquier otra casilla
      def self.new_casilla_normal(numcasilla, cost, tip)        
         self.new(numcasilla, cost, tip, nil)        
      end 
      
      #-------------------------------------------------------------------------
      
      def asignar_propietario(jugador)
         raise NotImplementedError
      end
      
      def pagar_alquiler
         raise NotImplementedError
      end
      
      def propietario_encarcelado
         raise NotImplementedError
      end
      
      def soy_edificable
         raise NotImplementedError
      end
      
      def tengo_propietario
         raise NotImplementedError
      end
      
      def to_s
         "\nCasilla{numero_casilla: #{@numero_casilla}, coste: #{@coste}, 
         tipo: #{@tipo}, titulo: #{@titulo}}\n"
      end
      
      # Indicar que un modificador tiene visibilidad privada
      private :titulo=
      
   end
end