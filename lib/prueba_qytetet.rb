# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase PruebaQytetet (Función Main)
# Autor: Jose Luis Gallego Peña

require_relative "sorpresa.rb"
require_relative "qytetet.rb"
require_relative "tipo_sorpresa.rb"
require_relative "casilla.rb"
require_relative "titulo_propiedad.rb"
require_relative "tipo_casilla.rb"
require_relative "tablero.rb"
require_relative "jugador.rb"
require_relative "dado.rb"

module ModeloQytetet
   class PruebaQytetet
    
      @@juego = Qytetet.instance
    
      # Devuelve las sorpresas cuyo valor es mayor que 0
      def self.sorpresaspositivas
         sorpresas = Array.new   # Array donde almacenar las sorpresas
         
         for s in @@juego.mazo
            if s.valor > 0               
               sorpresas << s             
            end
         end
         
         sorpresas        
      end
      
      # Devuelve las sorpresas cuyo tipo es IRACASILLA
      def self.sorpresasiracasilla
         sorpresas = Array.new   # Array donde almacenar las sorpresas
         
         for s in @@juego.mazo
            if s.tipo == TipoSorpresa::IRACASILLA       
               sorpresas << s 
            end
         end
         
         sorpresas        
      end
      
      # Devuelve las sorpresas cuyo tipo se especifica
      def self.sorpresastipo(tipo)        
         sorpresas = Array.new   # Array donde almacenar las sorpresas
         
         for s in @@juego.mazo
            if s.tipo == tipo               
               sorpresas << s              
            end
         end
         
         sorpresas       
      end
      
      # Pide el nombre de los jugadores que van a jugar Qytetet
      def self.get_nombre_jugadores
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
    
      def self.main 
         jugadores = get_nombre_jugadores
         @@juego.inicializar_juego(jugadores)
         
         puts "\nJugadores:"
         for s in jugadores
            puts s
         end
         
         # Invocar cada uno de los métodos definidos anteriormente #
         
         puts "\n Todas las cartas \n\n"
         for s in @@juego.mazo            
            puts s.to_s           
         end
         
         puts "\n Método 1: Sorpresas con valor positivo \n\n"
         s_positivas = sorpresaspositivas
         for s in s_positivas           
            puts s.to_s          
         end 
         
         puts "\n Método 2: Sorpresas de tipo IRACASILLA \n\n"
         s_iracasilla = sorpresasiracasilla
         for s in s_iracasilla            
            puts s.to_s         
         end
         
         puts "\n Método 3: Sorpresas de cada tipo \n\n"
         for t in TipoSorpresa::constants      
            for s in sorpresastipo(TipoSorpresa.const_get(t))          
               puts s.to_s
               puts "\n" 
            end
         end
         
         puts @@juego.to_s
      end
   end
   # Invocar al método main
   PruebaQytetet.main
end
