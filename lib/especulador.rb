# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Especulador, hereda de Jugador
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Especulador < Jugador
   
      #-------------------------------------------------------------------------
      
      def initialize(jugador, fianza)
         copia(jugador)
         @fianza = fianza
      end
      
      #-------------------------------------------------------------------------

      def pagar_impuesto
         super.modificar_saldo(-(super.casilla_actual.coste / 2))
      end
    
      def debo_ir_a_carcel()
         return (super && !pagar_fianza)
      end

      def convertirme(fianza)
         @fianza = fianza
         return self
      end
    
      def pagar_fianza
         puedo_pagar_fianza = false;
        
         if super.tengo_saldo(fianza)
            puedo_pagar_fianza = true
            super.modificar_saldo(-fianza)
         end
        
         return puedo_pagar_fianza
      end
    
      def puedo_edificar_casa(titulo)
        return ((titulo.numCasas < 8) && tengo_saldo(titulo.precioEdificar))
      end
    
      def puedo_edificar_hotel(titulo)
        return ((titulo.getNumCasas() >= 4) && (titulo.getNumHoteles() < 8) && tengoSaldo(titulo.getPrecioEdificar()));
      end
    
      def to_s
         "\n-Especulador: #{super.to_s} \nFianza: #{@fianza}"
      end
   end
end
