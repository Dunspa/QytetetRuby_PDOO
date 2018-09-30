# encoding: utf-8
# Programación y Diseño Orientado a Objetos - Práctica Qytetet
# Clase Sorpresa
# Autor: Jose Luis Gallego Peña

module ModeloQytetet
   class Sorpresa
    
      attr_reader :texto, :tipo, :valor
    
      def initialize(text, val, tip)
      
         @texto = text
         @tipo = tip
         @valor = val
     
      end
    
      def to_s
      
         "Texto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
      
      end 
   end
end
