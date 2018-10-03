# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase TituloPropiedad
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class TituloPropiedad
      
      attr_reader :nombre, :precioCompra, :alquilerBase, :factorRevalorizacion,
                  :hipotecaBase, :precioEdificar, :numHoteles, :numCasas
      
      attr_accessor :hipotecada
      
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
         
      end
      
      def to_s
      
         "TituloPropiedad{nombre: #{@nombre}, hipotecada: #{@hipotecada}, precioCompra: 
         #{@precioCompra}, alquilerBase: #{@alquilerBase}, factorRevalorizacion:
         #{@factorRevalorizacion}, hipotecaBase: #{@hipotecaBase}, 
         precioEdificar: #{@precioEdificar}, numHoteles: #{@numHoteles},
         numCasas: #{@numCasas}} \n"
      
      end 
   end
end
