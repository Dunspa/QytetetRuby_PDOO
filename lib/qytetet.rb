# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Qytetet
# Autor: Jose Luis Gallego Peña

require "singleton"

module ModeloQytetet
   class Qytetet
      include Singleton
      attr_reader :mazo, :tablero, :jugadores, :jugador_actual, :dado
      attr_accessor :carta_actual, :estado_juego
      
      #-------------------------------------------------------------------------
      
      @@MAX_JUGADORES = 4
      @@NUM_SORPRESAS = 10
      @@NUM_CASILLAS = 20
      @@PRECIO_LIBERTAD = 200
      @@SALDO_SALIDA = 1000
      
      def initialize
         @mazo = Array.new       # Almacena las cartas
         @jugadores = Array.new  # Jugadores
         @tablero                # Tablero de juego  
         @carta_actual
         @jugador_actual
         @dado = Dado.instance
         @estado_juego
      end
      
      #-------------------------------------------------------------------------
      
      def actuar_si_en_casilla_edificable
         debo_pagar = @jugador_actual.debo_pagar_alquiler
         if (debo_pagar)
            @jugador_actual.pagar_alquiler
            
            if (@jugador_actual.saldo <= 0)
               @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
         end
         
         casilla = obtener_casilla_jugador_actual
         tengo_propietario = casilla.tengo_propietario
         if (@estado_juego != EstadoJuego::ALGUNJUGADORENBANCARROTA)
            if (tengo_propietario)
               @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
            else
               @estado_juego = EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
            end
         end
      end
      
      def actuar_si_en_casilla_no_edificable
         @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
         
         casilla_actual = @jugador_actual.casilla_actual
         if (casilla_actual.tipo == TipoCasilla::IMPUESTO)
            @jugador_actual.pagar_impuesto
            
            if (@jugador_actual.saldo <= 0)
               @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
         else
            if (casilla_actual.tipo == TipoCasilla::JUEZ)
               encarcelar_jugador
            elsif (casilla_actual.tipo == TipoCasilla::SORPRESA)
               @carta_actual = @mazo.shift
               @estado_juego = EstadoJuego::JA_CONSORPRESA
            end
         end
      end
      
      def aplicar_sorpresa
         @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
         
         if (@carta_actual.tipo == TipoSorpresa::PAGARCOBRAR)
            @jugador_actual.modificar_saldo(@carta_actual.valor)
            
            if (@jugador_actual.saldo <= 0)
               @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
         elsif (@carta_actual.tipo == TipoSorpresa::IRACASILLA)
            valor = @carta_actual.valor
            casilla_carcel = @tablero.es_casilla_carcel(valor)
            
            if (casilla_carcel)
               encarcelar_jugador
            else
               mover(valor)
            end
         elsif (@carta_actual.tipo == TipoSorpresa::PORCASAHOTEL)
            cantidad = @carta_actual.valor
            numero_total = @jugador_actual.cuantas_casas_hoteles_tengo
            @jugador_actual.modificar_saldo(numero_total * cantidad)
            
            if (@jugador_actual.saldo <= 0)
               @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
         elsif (@carta_actual.tipo == TipoSorpresa::PORJUGADOR)
            for j in @jugadores
               if (j != @jugador_actual)
                  j.modificar_saldo(@carta_actual.valor)
                  
                  if (j.saldo <= 0)
                     @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                  end
                  
                  @jugador_actual.modificar_saldo(-@carta_actual.valor)
                  
                  if (@jugador_actual.saldo <= 0)
                     @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                  end
               end
            end
         end
      end
      
      def cancelar_hipoteca(numero_casilla)
         @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
         titulo = @tablero.obtener_casilla_numero(numero_casilla).titulo
         return @jugador_actual.cancelar_hipoteca(titulo)
      end
      
      def comprar_titulo_propiedad
         comprado = @jugador_actual.comprar_titulo_propiedad
         
         if (comprado)
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
         end
         
         return comprado
      end
      
      def edificar_casa(numero_casilla)
         casilla = @tablero.obtener_casilla_numero(numero_casilla)
         titulo = casilla.titulo
         edificada = @jugador_Actual.edificar_casa(titulo)
         
         if (edificada)
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
         end
         
         return edificada
      end
      
      def edificar_hotel(numero_casilla)
         casilla = @tablero.obtener_casilla_numero(numero_casilla)
         titulo = casilla.titulo
         edificada = @jugador_actual.edificar_hotel(titulo)
         
         if (edificada)
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
         end
         
         return edificada
      end
      
      def encarcelar_jugador
         if (!@jugador_actual.tengo_carta_libertad)
            casilla_carcel = @tablero.carcel
            @jugador_actual.ir_a_carcel(casilla_carcel)
            @estado_juego = EstadoJuego::JA_ENCARCELADO
         else
            carta = @jugador_actual.devolver_carta_libertad
            @mazo << carta
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
         end
      end
      
      def get_valor_dado
         return @dado.valor
      end
      
      def hipotecar_propiedad(numero_casilla)
         casilla = @tablero.obtener_casilla_numero(numero_casilla)
         titulo = casilla.titulo
         @jugador_actual.hipotecar_propiedad(titulo)
         @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
      end
      
      # Se crean y se incluyen en el mazo todas las cartas sorpresa
      def inicializar_cartas_sorpresa
         # PAGARCOBRAR #
         # Carta sorpresa que suma una cantidad de dinero al saldo del jugador
         @mazo << Sorpresa.new("Después de ser un fracasado toda tu vida, 
         ¡te toca la lotería! ...Pero sigues siendo un fracasado.", 7000, 
         TipoSorpresa::PAGARCOBRAR)
      
         # Carta sorpresa que resta una cantidad de dinero al saldo del jugador
         @mazo << Sorpresa.new("El banco te quita dinero porque sí, da gracias
         que aún sigas teniendo un plato que poner en la mesa.", -7000,
         TipoSorpresa::PAGARCOBRAR)
    
         # IRACASILLA #
         # Carta sorpresa que manda al jugador a la cárcel
         @mazo << Sorpresa.new("Has sido pillado, mejor suerte la próxima vez. 
         ¡A la carcel!", 9, TipoSorpresa::IRACASILLA)
      
         # Carta sorpresa que manda al jugador a una casilla
         @mazo << Sorpresa.new("Te tropiezas y sales volando a una casilla 
         diferente.", @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)
    
         # Carta sorpresa que manda al jugador a una casilla
         @mazo << Sorpresa.new("Te tropiezas y sales volando a una casilla 
         diferente.", 4, TipoSorpresa::IRACASILLA)
    
         # PORCASAHOTEL #
         # Carta sorpresa que hace que el jugador cobre por su propiedad
         @mazo << Sorpresa.new("Tu propiedad ha obtenido beneficios así que te 
         llevas un buen pico", 10000, TipoSorpresa::PORCASAHOTEL)
      
         # Carta sorpresa que hace que el jugador pague por su propiedad
         @mazo << Sorpresa.new("Te toca pagar por tener tierras, no seas tan
         avaricioso la próxima vez.", -10000, TipoSorpresa::PORCASAHOTEL)
      
         # PORJUGADOR #      
         # Carta sorpresa que hace que todos los jugadores te paguen
         @mazo << Sorpresa.new("Hoy es tu día de suerte, todos los jugadores
         deben pagarte por tu cara bonita.", 3000, TipoSorpresa::PORJUGADOR)
      
         # Carta sorpresa que hace que tengas que pagar a todos los jugadores
         @mazo << Sorpresa.new("Hoy no es tu día de suerte, debes pagar a todos
         los jugadores porque así lo dice esta carta.", -3000, 
         TipoSorpresa::PORJUGADOR)
    
         # SALIRCARCEL #      
         # Carta sorpresa que saca al jugador de la cárcel
         @mazo << Sorpresa.new("Parece ser que le has caído bien a alguien y ha
         pagado tu fianza. Sales de la cárcel.", 0, TipoSorpresa::SALIRCARCEL) 
         
         # Se barajan las cartas
         @mazo.shuffle
      end
      
      def inicializar_juego(nombres)
         inicializar_jugadores(nombres)
         inicializar_tablero
         inicializar_cartas_sorpresa
         salida_jugadores
      end
      
      def inicializar_jugadores(nombres)
         for n in nombres
            @jugadores << Jugador.new(n)
         end
      end
      
      def inicializar_tablero  
         @tablero = Tablero.new      
      end
      
      def intentar_salir_carcel(metodo)
         if (metodo == MetodoSalirCarcel::TIRANDODADO)
            resultado = tirar_dado
            
            if (resultado >= 5)
               @jugador_actual.encarcelado = false
            end
         elsif (metodo == MetodoSalirCarcel::PAGANDOLIBERTAD)
            @jugador_actual.pagar_libertad(@@PRECIO_LIBERTAD)
         end
         
         encarcelado = @jugador_actual.encarcelado
         if (encarcelado)
            @estado_juego = EstadoJuego::JA_ENCARCELADO
         else
            @estado_juego = EstadoJuego::JA_PREPARADO
         end
         
         return !encarcelado
      end
      
      def jugar
         num = tirar_dado
         pos = @tablero.obtener_casilla_final(@jugador_actual.casilla_actual, num).numero_casilla
         mover(pos)
      end
      
      def mover (num_casilla_destino)
         casilla_inicial = @jugador_actual.casilla_actual
         casilla_final = @tablero.obtener_casilla_numero(num_casilla_destino)
         @jugador_actual.casilla_actual = casilla_final
         
         if (num_casilla_destino < casilla_inicial.numero_casilla)
            @jugador_actual.modificar_saldo(@@SALDO_SALIDA)
         end
         
         if (casilla_final.soy_edificable)
            actuar_si_en_casilla_edificable
         else
            actuar_si_en_casilla_no_edificable
         end
      end
      
      def obtener_casilla_jugador_actual
         return @jugador_actual.casilla_actual
      end
      
      def obtener_casillas_tablero
         raise NotImplementedError
      end
      
      def obtener_propiedades_jugador
         propiedades_jugador = Array.new
         
         for c in @tablero.casillas
            if (c.tipo == TipoCasilla::CALLE)
               if (@jugador_actual.propiedades.include?(c.titulo))
                  propiedades_jugador << c.numero_casilla
               end
            end
         end
         
         return propiedades_jugador
      end
      
      def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca)
         propiedades_segun_hipoteca = Array.new
         
         for c in @tablero.casillas
            if (c.tipo == TipoCasilla::CALLE)
               if (@jugador_actual.obtener_propiedades(estado_hipoteca).include?(c.titulo))
                  propiedades_segun_hipoteca << c.numero_casilla
               end
            end
         end
         
         return propiedades_segun_hipoteca
      end
      
      def obtener_ranking
         @jugadores = @jugadores.sort
      end
      
      def obtener_saldo_jugador_actual
         return @jugador_actual.saldo
      end
      
      def salida_jugadores
         for j in @jugadores
            j.casilla_actual = @tablero.obtener_casilla_numero(0)
         end
         
         jugador_actual = rand(@jugadores.size)
         @jugador_actual = @jugadores.at(jugador_actual)
         @estado_juego = EstadoJuego::JA_PREPARADO
      end
      
      def siguiente_jugador
         pos = @jugadores.index(@jugador_actual)
         if (pos + 1 == @jugadores.size)
            @jugador_actual = @jugadores.at(0)
         else
            @jugador_actual = @jugadores.at(pos + 1)
         end
         
         if (@jugador_actual.encarcelado)
            @estado_juego = EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
         else
            @estado_juego = EstadoJuego::JA_PREPARADO
         end
      end
      
      def tirar_dado
         return @dado.tirar
      end
      
      def vender_propiedad(numero_casilla)
         casilla = @tablero.obtener_casilla_numero(numero_casilla)
         @jugador_actual.vender_propiedad(casilla)
      end
      
      def to_s
         s = "\nJuego Qytetet: #{@tablero.to_s}"
         
         for j in @jugadores
            s = s + j.to_s
         end
         
         for sorp in @mazo
            s = s + sorp.to_s
         end
         
         if @jugador_actual != nil && @carta_actual != nil
            s = s + ", jugador_actual: #{@jugador_actual.to_s}"
            s = s + ", carta_actual: #{@carta_actual.to_s}"
         end
         
         if @dado != nil
            s = s + ", dado: #{@dado.to_s}"
         end
         
         s = s + "\n"
         
         s
      end
      # Visibilidad de los métodos
      # private_class_method :encarcelar_jugador, :salida_jugadores
   end
end
