# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Casilla
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Casilla
      
      attr_reader :numeroCasilla, :coste, :tipo
      
      attr_accessor :titulo
      
      # Constructor
      def initialize(numcasilla, cost, tip, tit)
      
         @numeroCasilla = numcasilla   # Número de casilla (posición en tablero)
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
      
      def to_s
         
         "Casilla{numeroCasilla: #{@numeroCasilla}, coste: #{@coste},
         tipo: #{@tipo}, titulo: #{@titulo.to_s}}"
         
      end    
      
      # Indicar que un modificador tiene visibilidad privada
      private :titulo=
      
   end
end