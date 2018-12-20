# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Calle, hereda de Casilla
# Autor: Jose Luis Gallego Peña

require_relative "casilla.rb"
require_relative "tipo_casilla.rb"

module ModeloQytetet
   class Calle < Casilla
      attr_reader :tipo
      attr_accessor :titulo
      
      #-------------------------------------------------------------------------
      
      def initialize(numero_casilla, titulo)
         super(numero_casilla, titulo.precioCompra, TipoCasilla::CALLE)
         
         @titulo = titulo
      end
      
      #-------------------------------------------------------------------------
      
      def asignar_propietario(jugador)
         @titulo.propietario = jugador
         return @titulo
      end
      
      def pagar_alquiler
         coste_alquiler = @titulo.pagar_alquiler
         return coste_alquiler
      end
      
      def propietario_encarcelado
         return @titulo.propietario_encarcelado
      end
      
      def soy_edificable
         return true
      end
      
      def tengo_propietario
         return @titulo.tengo_propietario
      end
      
      def to_s
         return "\n #{super.to_s}"
      end
      
      private :titulo=
   end
end
