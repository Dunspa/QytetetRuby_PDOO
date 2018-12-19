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
      
      #-------------------------------------------------------------------------
      
      def soy_edificable
         return false
      end
      
      def to_s
         "\nCasilla{numero_casilla: #{@numero_casilla}, coste: #{@coste}, 
         tipo: #{@tipo}, titulo: #{@titulo}}\n"
      end
      
      # Indicar que un modificador tiene visibilidad privada
      private :titulo=
      
   end
end