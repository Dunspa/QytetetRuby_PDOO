# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase ControladorQytetet
# Autor: Jose Luis Gallego Peña

require "singleton"
require_relative "metodo_salir_carcel.rb"
require_relative "estado_juego.rb"
require_relative "opcion_menu.rb"

module ControladorQytetet
   class ControladorQytetet
      include Singleton
      include ModeloQytetet
      
      attr_reader :modelo
      attr_accessor :nombre_jugadores
      
      #-------------------------------------------------------------------------
      
      def initialize
         @modelo = Qytetet.instance
         @nombre_jugadores = Array.new
      end
      
      #-------------------------------------------------------------------------
      
      def obtener_operaciones_juego_validas
         operaciones = Array.new

         if @modelo.jugadores.empty?
            operaciones << OpcionMenu.index(:INICIARJUEGO)
         else
            # Opciones por defecto
            operaciones << OpcionMenu.index(:TERMINARJUEGO)
            operaciones << OpcionMenu.index(:MOSTRARJUGADORACTUAL)
            operaciones << OpcionMenu.index(:MOSTRARJUGADORES)
            operaciones << OpcionMenu.index(:MOSTRARTABLERO)
            
            if @modelo.estado_juego == EstadoJuego::JA_PREPARADO
               operaciones << OpcionMenu.index(:JUGAR)
            elsif @modelo.estado_juego == EstadoJuego::ALGUNJUGADORENBANCARROTA
               operaciones << OpcionMenu.index(:OBTENERRANKING)
            elsif @modelo.estado_juego == EstadoJuego::JA_CONSORPRESA
               operaciones << OpcionMenu.index(:APLICARSORPRESA)
            elsif @modelo.estado_juego == EstadoJuego::JA_ENCARCELADO
               operaciones << OpcionMenu.index(:PASARTURNO)
            elsif @modelo.estado_juego == EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
               operaciones << OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO)
               operaciones << OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD)
            elsif @modelo.estado_juego == EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
               operaciones << OpcionMenu.index(:PASARTURNO)
               operaciones << OpcionMenu.index(:COMPRARTITULOPROPIEDAD)
               operaciones << OpcionMenu.index(:VENDERPROPIEDAD)
               operaciones << OpcionMenu.index(:HIPOTECARPROPIEDAD)
               operaciones << OpcionMenu.index(:CANCELARHIPOTECA)
               operaciones << OpcionMenu.index(:EDIFICARCASA)
               operaciones << OpcionMenu.index(:EDIFICARHOTEL)
            elsif @modelo.estado_juego == EstadoJuego::JA_PUEDEGESTIONAR
               operaciones << OpcionMenu.index(:PASARTURNO)
               operaciones << OpcionMenu.index(:VENDERPROPIEDAD)
               operaciones << OpcionMenu.index(:HIPOTECARPROPIEDAD)
               operaciones << OpcionMenu.index(:CANCELARHIPOTECA)
               operaciones << OpcionMenu.index(:EDIFICARCASA)
               operaciones << OpcionMenu.index(:EDIFICARHOTEL)
            end
         end
         
         return operaciones
      end
      
      def necesita_elegir_casilla(opcion_menu)
         return (
            opcion_menu == OpcionMenu.index(:HIPOTECARPROPIEDAD) ||
            opcion_menu == OpcionMenu.index(:CANCELARHIPOTECA) ||
            opcion_menu == OpcionMenu.index(:EDIFICARCASA) ||
            opcion_menu == OpcionMenu.index(:EDIFICARHOTEL) ||
            opcion_menu == OpcionMenu.index(:VENDERPROPIEDAD) 
         )
      end
      
      def obtener_casillas_validas(opcion_menu)
         casillas = Array.new
         opcion = OpcionMenu[opcion_menu]
         
         if opcion == :HIPOTECARPROPIEDAD
            casillas = @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
         elsif opcion == :CANCELARHIPOTECA
            casillas = @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
         elsif opcion == :EDIFICARCASA
            casillas = @modelo.obtener_propiedades_jugador
         elsif opcion == :EDIFICARHOTEL
            casillas = @modelo.obtener_propiedades_jugador
         elsif opcion == :VENDERPROPIEDAD
            casillas = @modelo.obtener_propiedades_jugador
         end
         
         return casillas;
      end
      
      def realizar_operacion(opcion_elegida, casilla_elegida)
         operaciones = ""
         
         if opcion_elegida == 0
            @modelo.inicializar_juego(@nombre_jugadores)
            operaciones += "\nQue empiece el juego"
         elsif opcion_elegida == 1
            @modelo.jugar
            operaciones += "\nSe tira el dado y se obtiene: " + @modelo.get_valor_dado.to_s
            operaciones += "\nEl jugador cae en la casilla: " + @modelo.obtener_casilla_jugador_actual.to_s
         elsif opcion_elegida == 2    
            operaciones += "Se aplica la sorpresa: " + @modelo.carta_actual.to_s
            @modelo.aplicar_sorpresa
         elsif opcion_elegida == 3
            sale = @modelo.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
            operaciones += "\nIntentas salir de la cárcel pagando"
            if sale
               operaciones += "\nTienes suficiente dinero así que pagas y sales de la cárcel"
            else
               operaciones += "\nEres un pobre, te quedas en la cárcel"
            end
         elsif opcion_elegida == 4
            sale = @modelo.intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
            operaciones += "\nIntentas salir de la cárcel pagando"
            if (sale)
               operaciones += "\nConsigues salir de la cárcel"
            else
               operaciones += "\nSale mal. No sales de la cárcel"
            end
         elsif opcion_elegida == 5
            comprado = @modelo.comprar_titulo_propiedad
            if comprado
               operaciones += "\nHas comprado la propiedad"
            else
               operaciones += "\nNo has podido comprar la propiedad"
            end
         elsif opcion_elegida == 6
            @modelo.hipotecar_propiedad(casilla_elegida)
            operaciones += "\nHipotecas la casilla número " + casilla_elegida.to_s
         elsif opcion_elegida == 7
            @modelo.hipotecar_propiedad(casilla_elegida)
            operaciones += "\nCancelas la hipoteca de la casilla número " + casilla_elegida.to_s
         elsif opcion_elegida == 8
            edificada = @modelo.edificar_casa(casilla_elegida)
            if edificada
               operaciones += "\nHas edificado una casa"
            else
               operaciones += "\nNo has podido edificar la casa"
            end
         elsif opcion_elegida == 9
            edificada = @modelo.edificar_hotel(casilla_elegida)
            if edificada
               operaciones += "\nHas edificado un hotel"
            else
               operaciones += "\nNo has podido edificar el hotel"
            end
         elsif opcion_elegida == 10
            @modelo.vender_propiedad(casilla_elegida)
            operaciones += "\nVendes la propiedad de la casilla " + casilla_elegida.to_s
         elsif opcion_elegida == 11
            @modelo.siguiente_jugador
            operaciones += "\nPasas tu turno"
            operaciones += "\nSiguiente jugador: " + @modelo.jugador_actual.to_s
         elsif opcion_elegida == 12
            i = 1
            @modelo.obtener_ranking
            operaciones += "\nRanking de jugadores: "
            for j in @modelo.jugadores
               operaciones += "\n" + i.to_s + " - " + j.to_s
               i += 1
            end
         elsif opcion_elegida == 13
            operaciones += "\nCERRAMOS EL CHIRINGUITO\n"
            exit(true)
         elsif opcion_elegida == 14
            operaciones += @modelo.jugador_actual.to_s
         elsif opcion_elegida == 15
            operaciones += @modelo.jugadores.join
         elsif opcion_elegida == 16
            operaciones += @modelo.tablero.to_s
         end
         
         return operaciones
      end
      
      private_class_method :new
   end
end
