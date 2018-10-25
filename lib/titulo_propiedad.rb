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
         raise NotImplementedError
      end
      
      def calcular_coste_hipotecar
         raise NotImplementedError
      end
      
      def calcular_importe_alquiler
         raise NotImplementedError
      end
      
      def calcular_precio_venta
         raise NotImplementedError
      end
      
      def cancelar_hipoteca
         raise NotImplementedError
      end
      
      def cobrar_alquiler(coste)
         raise NotImplementedError
      end
      
      def edificar_casa
         raise NotImplementedError
      end
      
      def edificar_hotel
         raise NotImplementedError
      end
      
      def hipotecar
         raise NotImplementedError
      end
      
      def pagar_alquiler
         raise NotImplementedError
      end
      
      def propietario_encarcelado
         raise NotImplementedError
      end
      
      def tengo_propietario
         raise NotImplementedError
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
