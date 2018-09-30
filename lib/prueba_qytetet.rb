# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Función Main
# Autor: Jose Luis Gallego Peña

require_relative "sorpresa.rb"
require_relative "qytetet.rb"
require_relative "tipo_sorpresa.rb"

module ModeloQytetet
   class PruebaQytetet
    
      @@juego = Qytetet.new
    
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
    
      def self.main
      
         @@juego.inicializarCartasSorpresa
         
         # Invocar cada uno de los métodos definidos anteriormente #
         
         puts "Todas las cartas \n"
         for s in @@juego.mazo
            
            puts s.to_s
            
         end
         
         puts "Método 1: Sorpresas con valor positivo \n"
         s_positivas = sorpresaspositivas
         for s in s_positivas
            
            puts s.to_s
            
         end 
         
         puts "Método 2: Sorpresas de tipo IRACASILLA \n"
         s_iracasilla = sorpresasiracasilla
         for s in s_iracasilla
            
            puts s.to_s
            
         end
         
         puts "Método 3: Sorpresas de cada tipo \n"
         for t in TipoSorpresa::constants      
            for s in sorpresastipo(TipoSorpresa.const_get(t))
               
               puts s.to_s
               puts "\n"
               
            end
         end
      end
   end
  
   # Invocar al método main
   PruebaQytetet.main
  
end
