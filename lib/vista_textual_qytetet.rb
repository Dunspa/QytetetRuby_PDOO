# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase VistaTextualQytetet
# Autor: Jose Luis Gallego Peña

require_relative "qytetet.rb"
require_relative "controlador_qytetet"
require_relative "sorpresa.rb"
require_relative "qytetet.rb"
require_relative "tipo_sorpresa.rb"
require_relative "casilla.rb"
require_relative "titulo_propiedad.rb"
require_relative "tipo_casilla.rb"
require_relative "tablero.rb"
require_relative "jugador.rb"
require_relative "dado.rb"
require_relative "estado_juego.rb"
require_relative "metodo_salir_carcel.rb"
require_relative "estado_juego.rb"
require_relative "opcion_menu.rb"
require_relative "calle.rb"

module VistaTextualQytetet
   class VistaTextualQytetet
      include ControladorQytetet
      attr_reader :controlador
      
      #-------------------------------------------------------------------------
      
      def initialize
         @controlador = ControladorQytetet.instance
      end
      
      #-------------------------------------------------------------------------
      
      def obtener_nombre_jugadores
         jugadores = Array.new
         
         puts "¿Cuántos jugadores van a jugar? (4 máximo, 2 mínimo)"
         n = gets.chomp.to_i
         puts "Introduzca los nombres de los #{n} jugadores:"
         for i in 1..n
            s = gets
            jugadores << s
         end
         
         jugadores
      end
      
      def elegir_casilla(opcion_menu)
         casillas_validas = Array.new
         casillas_validas_s = Array.new
         casillas_validas = @controlador.obtener_casillas_validas(opcion_menu)
         
         if casillas_validas.empty?
            return -1
         else
            puts "Casillas: "
            
            for i in casillas_validas
               puts i.to_s
               casillas_validas_s << i.to_s
            end
            
            return leer_valor_correcto(casillas_validas_s).to_i
         end
      end
      
      def leer_valor_correcto(valores_correctos)
         valor = gets.chomp
         
         while !valores_correctos.include?(valor)
            puts "Error. Debe introducir un valor correcto."
            valor = gets.chomp
         end
         
         return valor
      end
      
      def elegir_operacion
         operaciones = @controlador.obtener_operaciones_juego_validas
         operaciones_s = Array.new
         
         for i in operaciones
            puts OpcionMenu.at(i).to_s + ": " + i.to_s
            operaciones_s << i.to_s
         end
         
         return leer_valor_correcto(operaciones_s).to_i
      end
      
      def self.main 
         ui = VistaTextualQytetet.new
         ui.controlador.nombre_jugadores = ui.obtener_nombre_jugadores
         operacion_elegida = 0
         casilla_elegida = 0
         
         loop do
            operacion_elegida = ui.elegir_operacion
            necesita_elegir_casilla = ui.controlador.necesita_elegir_casilla(operacion_elegida)
            if necesita_elegir_casilla
               casilla_elegida = ui.elegir_casilla(operacion_elegida)
            end
            if !necesita_elegir_casilla || casilla_elegida >= 0
               puts ui.controlador.realizar_operacion(operacion_elegida, casilla_elegida)
            end
            
            break if 1 != 1
         end
      end
   end
   # Invocar al método main
   VistaTextualQytetet.main
end
