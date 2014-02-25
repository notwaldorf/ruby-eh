# encoding: utf-8

# Classes are open, which means we can put anything in them.
class Object
  def please
    self
  end
  alias_method :eh, :please
  alias_method :eh?, :please
  alias_method :pardon, :please
  alias_method :pardon?, :please
end

# French as a second language.
class Array
  translations = {:at => :a, :clear => :clear, :collect => :collecter, :collect! => :collecter!, :combination => :combinaison, :compact => :compact, :compact! => :compact!, :count => :compte, :delete => :supprimer, :delete_at => :supprimer_at, :delete_if => :supprimer_si, :drop => :baisse, :drop_while => :drop_while, :each => :chaque, :each_index => :chaque_index, :empty? => :vide?, :eql? => :eql?, :fetch => :chercher, :fill => :remplissage, :find_index => :trouver_index, :first => :premier, :flatten => :aplatir, :flatten! => :aplatir!, :frozen? => :gelé?, :hash => :hachage, :index => :index, :insert => :insert, :inspect => :inspecter, :join => :joindre, :keep_if => :garde_si, :last => :dernier, :length => :longueur, :map => :carte, :map! => :carte!, :pack => :paquet, :product => :produit, :push => :poussoir, :rassoc => :rassoc, :reject => :rejeter, :reject! => :rejeter!, :replace => :remplacer, :reverse => :inverse, :reverse! => :inverse!, :reverse_each => :inverse_chaque, :rotate => :tourner, :rotate! => :tourner!, :sample => :echantillon, :select => :choisir, :select! => :choisir!, :shift => :changement, :shuffle => :mélanger, :shuffle! => :mélanger!, :size => :taille, :slice => :tranche, :slice! => :tranche!, :take => :prendre, :take_while => :prendre_tout, :transpose => :transposer, :uniq => :uniques, :uniq! => :uniques!} 
  Array.instance_methods(false).each do |f|
    if translations.key?(f)
      alias_method translations[f], f
    end
  end
end

# Leads to glorious french code.
def articles_aleatoires(matrice)
  matrice.echantillon(1 + rand(matrice.compte))
end

# We can alias any existing functions.
module Kernel
  alias sane_puts puts
  def puts(s)
      sane_puts "If you don't mind, " + s
    end
  alias_method :giver, :puts
end

# Exceptions aren't any different.
class Exception
  alias_method :sane_to_s, :to_s
  def to_s
    sane_to_s + ". Take off, hoser."
  end
end

# Unicode for all.
class Object
  def ☢
    sane_puts "BOOM"
  end
end

# There's bare words.
# def self.method_missing(*args)
#   args.join(" ")
# end

# But you can also have bare words in function names because Ruby.
# from: http://99designs.com/tech-blog/blog/2012/10/30/abusing-ruby-for-fun-and-profit/
self.instance_exec do
  def method_missing(sym, *args)
    # Splat args if passed in from a parent call
    if args.length == 1 && args[0].is_a?(Array) && args[0][0].class == NameError
      args = args[0]
    end
    method_names, arguments = args.partition { |a| a.class == NameError }
    method([sym.to_s, *method_names.map(&:name)].join(" ")).call(*arguments)
  rescue NameError => e
    return [e, *arguments]
  end
end

# All together now.
self.class.send(:define_method, :"take off") do
  puts "♫ ♪ Coo loo coo coo, coo coo coo coo ♬ ♪"
end

