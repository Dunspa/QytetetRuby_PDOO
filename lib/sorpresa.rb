# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Sorpresa
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Sorpresa
    
      attr_reader :texto, :tipo, :valor
    
      def initialize(text, val, tip)
      
         @texto = text  # Describe la sorpresa
         @tipo = tip    # Indica el tipo de sorpresa
         @valor = val   # Afecta de forma diferente según la carta
     
      end
    
      def to_s
      
         "Sorpresa{Texto: #{@texto}, Valor: #{@valor}, Tipo: #{@tipo}} \n"
      
      end 
   end
end
