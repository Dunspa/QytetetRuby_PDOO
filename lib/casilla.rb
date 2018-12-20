# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Casilla
# Autor: Jose Luis Gallego Peña

require_relative "tipo_casilla"
require_relative "calle.rb"

module ModeloQytetet
   class Casilla
      attr_reader :numero_casilla, :coste, :tipo
      attr_accessor :titulo
      
      #-------------------------------------------------------------------------
      
      # Constructor
      def initialize(numcasilla, cost, tip)
         @numero_casilla = numcasilla   # Número de casilla (posición en tablero)
         @coste = cost                 # Coste de la casilla
         @tipo = tip                   # Tipo de la casilla
      end
      
      #-------------------------------------------------------------------------
      
      def soy_edificable
         return false
      end
      
      def to_s
         "\n-Casilla: \nNúmero de casilla: #{@numero_casilla} \nCoste: #{@coste} \nTipo: #{@tipo} \nTitulo: #{@titulo}"
      end
      
      # Indicar que un modificador tiene visibilidad privada
      private :titulo=
      
   end
end