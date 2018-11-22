# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase TituloPropiedad
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class TituloPropiedad
      attr_reader :nombre, :precioCompra, :alquilerBase, :factorRevalorizacion,
                  :hipotecaBase, :precioEdificar, :numHoteles, :numCasas
      attr_accessor :hipotecada, :propietario
      
      #-------------------------------------------------------------------------
      
      def initialize(nom, preciocom, alquiler, factor, hipoteca, precioedi)
        @nombre = nom                    # Nombre de la calle
        @precioCompra = preciocom        # Precio de compra
        @alquilerBase = alquiler         # Precio base a pagar
        @factorRevalorizacion = factor   # Indica cuanto se revaloriza el título
        @hipotecaBase = hipoteca         # Valor base de la hipoteca
        @precioEdificar = precioedi      # Precio para edificar casas y hoteles
        @hipotecada = false              # Indica si el título está hipotecado
        @numHoteles = 0                  # Número de hoteles edificados
        @numCasas = 0                    # Número de casas edificadas
        @propietario = nil
      end
      
      #-------------------------------------------------------------------------
      
      def calcular_coste_cancelar
        return (calcular_coste_hipotecar + 0.10 * calcular_coste_hipotecar)
      end
      
      def calcular_coste_hipotecar
        return (@hipotecaBase + @numCasas * 0.5 * @hipotecaBase + @numHoteles * @hipotecaBase)
      end
      
      def calcular_importe_alquiler
        return (@alquilerBase + (@numCasas * 0.5 + @numHoteles * 2))
      end
      
      def calcular_precio_venta
        return (@precioCompra + (@numCasas + @numHoteles) * @precioEdificar * @factorRevalorizacion)
      end
      
      def cancelar_hipoteca
        @hipotecada = false
      end
      
      def cobrar_alquiler(coste)
         raise NotImplementedError
      end
      
      def edificar_casa
        @numCasas = @numCasas + 1
      end
      
      def edificar_hotel
        @numHoteles = @numHoteles + 1
      end
      
      def hipotecar
        @hipotecada = true
        coste_hipoteca = calcular_coste_hipotecar
        
        return coste_hipoteca
      end
      
      def pagar_alquiler
        coste_alquiler = calcular_importe_alquiler
        @propietario.modificar_saldo(coste_alquiler)
        
        return coste_alquiler
      end
      
      def propietario_encarcelado
        return @propietario.encarcelado
      end
      
      def tengo_propietario
        return (@propietario != nil)
      end
      
      def to_s
        "\nTituloPropiedad{nombre: #{@nombre}, hipotecada: #{@hipotecada}, precioCompra: 
        #{@precioCompra}, alquilerBase: #{@alquilerBase}, factorRevalorizacion:
        #{@factorRevalorizacion}, hipotecaBase: #{@hipotecaBase}, 
        precioEdificar: #{@precioEdificar}, numHoteles: #{@numHoteles},
        numCasas: #{@numCasas}}\n"
      end 
   end
end
