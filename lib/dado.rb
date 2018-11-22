# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"

module ModeloQytetet
   class Dado
      include Singleton
      attr_reader :valor
      
      #-------------------------------------------------------------------------
      
      def initialize
         @valor = 0
      end
      
      #-------------------------------------------------------------------------
      
      def tirar
         valor = (1 + rand(6))
         @valor = valor
         return valor
      end
      
      def to_s
         "\nDado{valor: #{@valor}}\n"
      end
   end
end
