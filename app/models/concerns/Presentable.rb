module Presentable
  extend ActiveSupport::Concern

  def presentation_phrase

    <<-HEREDOC
Olá! Meu nome é #{name}. #{species_expression}, peso #{mass} Kg e #{mass_expression}, #{planet_expression} #{year_expression}.
#{transports_expression('pilotei', starships, 'espaçonave')}. #{transports_expression('dirigi', vehicles, 'veículos')}
    HEREDOC
  end

  private

  def species_expression
    species_names = species.pluck(:name)
    if species_names.blank?
      'Não conheço qual minha raça'
    else
      result = "Sou um #{species_names.shift}"
      if species_names.count.positive?
        result += " mas também sou #{species_names.shift}"
        i = 0
        until species_names.blank?
          if species_names.count == 1
            result += " e "
          else
            result += " , "
          end
          result += "#{species_names[i]}"
        end
      end
      result
    end
  end

  def transports_expression(verb, transports, transport_type)
    transports = transports.pluck(:name)
    if transports.blank?
      "Nunca #{verb} #{transport_type}"
    else
      result = "Já #{verb} #{transports.shift}"
      if transports.count.positive?
        until transports.blank?
          if transports.count == 1
            result += " e "
          else
            result += " , "
          end
          result += "#{transports[0]}"
          transports.shift
        end
      end
      result
    end
  end

  def planet_expression
    if planet&.name?
      "nasci em #{planet.name}"
    else
      'não sei exatamente onde nasci'
    end
  end

  def year_expression
    if !birthday_year.blank? && birthday_year != 'unknown'
      "no ano #{birthday_year}"
    else
      'e não sei exatamente o ano'
    end
  end

  def mass_expression
    result = "e meço #{height} cm"
    unless species.blank?
      specie = species.first
      position = if height > specie.height_avg
                   'acima da média'
                 elsif height == specie.height_avg
                   'na média'
                 else
                   'abaixo da média'
                 end

      result + "(curiosidade: estou #{position} de altura dos #{specie.name})"
    end
  end
end

