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
      
      def cancelar_hipoteca(titulo)
         coste_cancelar = titulo.calcular_coste_cancelar
         puede_cancelar = tengo_saldo(coste_cancelar)
         if (puede_cancelar)
           modificar_saldo(-coste_cancelar)
           titulo.cancelar_hipoteca
         end

         return puede_cancelar
      end
      
      def comprar_titulo_propiedad
         comprado = false
         coste_compra = @casilla_actual.coste
         if (coste_compra < @saldo)
           titulo = @casilla_actual.asignar_propietario(self)
           @propiedades << titulo
           modificar_saldo(-coste_compra)
           comprado = true
         end

         return comprado
      end
      
      def cuantas_casas_hoteles_tengo
         casas_hoteles = 0

         for t in @propiedades
           casas_hoteles += (t.numCasas + t.numHoteles)
         end

         return casas_hoteles
      end
      
      def debo_pagar_alquiler
         tiene_propietario = false
         esta_encarcelado = false
         esta_hipotecada = false
         titulo = @casilla_actual.titulo
         es_de_mi_propiedad = es_de_mi_propiedad(titulo)

         if (!es_de_mi_propiedad)
           tiene_propietario = titulo.tengo_propietario
         end

         if (!es_de_mi_propiedad && tiene_propietario)
           esta_encarcelado = titulo.propietario_encarcelado
         end

         if (!es_de_mi_propiedad && tiene_propietario && !esta_encarcelado)
           esta_hipotecada = titulo.hipotecada
         end

         return (!es_de_mi_propiedad && tiene_propietario && !encarcelado && !esta_hipotecada)
      end
      
      def devolver_carta_libertad
         copia_carta_libertad = Sorpresa.new(@carta_libertad.texto, 
           @carta_libertad.valor, @carta_libertad.tipo)
         @carta_libertad = nil

         return copia_carta_libertad
      end
      
      def edificar_casa(titulo)
         edificada = false
         num_casas = titulo.numCasas

         if (num_casas < 4)
           coste_edificar_casa = titulo.precioEdificar
           tengo_saldo = tengo_saldo(coste_edificar_casa)

           if (tengo_saldo)
             titulo.edificar_casa
             modificar_saldo(-coste_edificar_casa)
             edificada = true
           end
         end

         return edificada
      end
      
      def edificar_hotel(titulo)
         edificada = false
         num_casas = titulo.numCasas
         num_hoteles = titulo.numHoteles

         if ((num_casas == 4) && (num_hoteles < 4))
           coste_edificar_hotel = titulo.precioEdificar
           tengo_saldo = tengo_saldo(coste_edificar_hotel)

           if (tengo_saldo)
             titulo.edificar_hotel
             modificar_saldo(-coste_edificar_hotel)
             edificada = true
           end
         end

         return edificada
      end
      
      def eliminar_de_mis_propiedades(titulo)
         @propiedades.remove(titulo)
         titulo.propietario = nil
      end
      
      def es_de_mi_propiedad(titulo)
         return @propiedades.include?(titulo)
      end
      
      def estoy_en_calle_libre
         raise NotImplementedError
      end
      
      def hipotecar_propiedad(titulo)
         coste_hipoteca = titulo.hipotecar
         modificar_saldo(coste_hipoteca)
      end
      
      def ir_a_carcel(casilla_carcel)
         @casilla_actual = casilla_carcel
         @encarcelado = true
      end
      
      def modificar_saldo(cantidad)
         @saldo += cantidad
      end
      
      def obtener_capital
         capital = @saldo

         for t in @propiedades
           capital += (t.precioCompra + (t.numCasas + t.numHoteles) * t.precioEdificar)

           if (t.hipotecada)
             capital -= t.hipotecaBase
           end
         end

         return capital
      end
      
      def obtener_propiedades(estado_hipoteca)
         titulos = Array.new

         for t in @propiedades
           if (t.hipotecada == estado_hipoteca)
             titulos << t
           end
         end

         return titulos
      end
      
      def pagar_alquiler
         coste_alquiler = @casilla_actual.pagar_alquiler
         modificar_saldo(-coste_alquiler)
      end
      
      def pagar_impuesto
         @saldo -= @casilla_actual.coste
      end
      
      def pagar_libertad(cantidad)
         tengo_saldo = tengo_saldo(cantidad)

         if (tengo_saldo)
           @encarcelado = false
           modificar_saldo(-cantidad)
         end
      end
      
      def tengo_carta_libertad
         return (@carta_libertad != nil)
      end
      
      def tengo_saldo(cantidad)
         return (saldo > cantidad)
      end
      
      def vender_propiedad(casilla)
         titulo = casilla.titulo
         eliminar_de_mis_propiedades(titulo)
         precio_venta = titulo.calcular_precio_venta
         modificar_saldo(precio_venta)
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
      
      def <=> (otro_jugador)
         otro_capital = otro_jugador.obtener_capital
         mi_capital = obtener_capital
         if (otro_capital > mi_capital)
           return 1 end
         if (otro_capital < mi_capital)
           return -1 end
         return 0
      end
      
      private :eliminar_de_mis_propiedades, :es_de_mi_propiedad, :tengo_saldo
   end
end
