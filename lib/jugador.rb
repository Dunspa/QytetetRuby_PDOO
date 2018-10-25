# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Jugador
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Jugador
      attr_reader   :nombre, :saldo, :propiedades
      attr_accessor :casilla_actual, :carta_libertad, :encarcelado
      
      #-------------------------------------------------------------------------
      
      def initialize(n)
         @nombre = n                # Nombre del jugador
         @encarcelado = false       # Si el jugador está en la cárcel
         @saldo = 7500              # Saldo del jugador (inicial 7500)
         @carta_libertad            # Carta para salir de la cárcel
         @propiedades = Array.new   # Títulos de propiedad del jugador
         # Casilla en la que se encuentra el jugador
         @casilla_actual = Casilla.new_casilla_normal(0, 0, TipoCasilla::SALIDA) 
      end
      
      #-------------------------------------------------------------------------
      private
      
      def cancelar_hipoteca(titulo)
         raise NotImplementedError
      end
      
      def comprar_titulo_propiedad
         raise NotImplementedError
      end
      
      def cuantas_casas_hoteles_tengo
         raise NotImplementedError
      end
      
      def debo_pagar_alquiler
         raise NotImplementedError
      end
      
      def devolver_carta_libertad
         raise NotImplementedError
      end
      
      def edificar_casa(titulo)
         raise NotImplementedError
      end
      
      def edificar_hotel(titulo)
         raise NotImplementedError
      end
      
      def es_de_mi_propiedad(titulo)
         raise NotImplementedError
      end
      
      def estoy_en_calle_libre
         raise NotImplementedError
      end
      
      def hipotecar_propiedad(titulo)
         raise NotImplementedError
      end
      
      def ir_a_carcel(casilla)
         raise NotImplementedError
      end
      
      def modificar_saldo(cantidad)
         raise NotImplementedError
      end
      
      def obtener_capital
         raise NotImplementedError
      end
      
      def obtener_propiedades(hipotecada)
         raise NotImplementedError
      end
      
      def pagar_alquiler
         raise NotImplementedError
      end
      
      def pagar_impuesto
         raise NotImplementedError
      end
      
      def pagar_libertad(cantidad)
         raise NotImplementedError
      end
      
      def tengo_carta_libertad
         raise NotImplementedError
      end
      
      def tengo_saldo(cantidad)
         raise NotImplementedError
      end
      
      def vender_propiedad(casilla)
         raise NotImplementedError
      end
      
      public
      def to_s
         s = "\nJugador{nombre: #{@nombre}encarcelado: #{@encarcelado}"
         s = s + "\nsaldo: #{@saldo}"
         if @carta_libertad != nil
            s = s + "\ncarta_libertad: #{@carta_libertad.to_s}"
         end
         
         s = s + "\ncasilla_actual: #{@casilla_actual.to_s} \npropiedades: "
         for t in @propiedades
            s = s + t.to_s
         end
         
         s = s + "}\n"
         
         s
      end
   end
end
