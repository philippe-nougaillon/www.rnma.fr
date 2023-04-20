# frozen_string_literal: true

module EvenementDecorator
  def style
    self.current_state.meta[:style]
  end

  def pretty_date(show_hour)
    #ne prend pas en compte s'il y a un event à minuit, ou 00h30 ou avec l'heure à 0
    result = ""

    deb_l = I18n.l(self.debut.to_date, format: :long)
    fin_l = I18n.l(self.fin.to_date, format: :long)
    deb_h = self.debut.hour
    fin_h = self.fin.hour
    deb_m = self.debut.min
    fin_m = self.fin.min
    
    if show_hour
      if self.debut.day == self.fin.day
        if deb_h == 0
          # le 18/03/2022 quand y'a pas d'heure et pas de date de fin
          result = "le #{deb_l}"
        elsif self.fin > self.debut
          if deb_m !=0
            if fin_m !=0
              # le 18/03/2022 de 12h30 à 14h30 quand y'a une heure de début et de fin, avec des minutes, et une date de fin le même jour
              result = "le #{deb_l} de #{deb_h}h#{deb_m} à #{fin_h}h#{fin_m}"
            else
              # le 18/03/2022 de 12h30 à 14h quand y'a une heure de début et de fin, avec des minutes pour le début, et une date de fin le même jour
              result = "le #{deb_l} de #{deb_h}h#{deb_m} à #{fin_h}h"
            end
          else
            if fin_m != 0
              # le 18/03/2022 de 12h à 14h30 quand y'a une heure de début et de fin, avec des minutes pour la fin, et une date de fin le même jour
              result = "le #{deb_l} de #{deb_h}h à #{fin_h}h#{fin_m}"
            else
              # le 18/03/2022 de 12h à 14h quand y'a une heure de début et de fin, et une date de fin le même jour
              result = "le #{deb_l} de #{deb_h}h à #{fin_h}h"
            end
          end
        elsif deb_m !=0
          result = "le #{deb_l} à #{deb_h}h#{deb_m}"
        else
          # le 18/03/2022 à 12h quand y'a une heure et pas de date de fin
          result = "le #{deb_l} à #{deb_h}h"
        end
      else
        if deb_h == 0
          # du 18/03/2002 au 19/03/2022 quand les dates ne sont pas les mêmes
          result = "du #{deb_l} au #{fin_l}"
        else
          # du 18/03/2002 à 8h au 19/03/2022 à 20h quand les dates ne sont pas les même avec une heure pour chaque
          result = "du #{deb_l} à #{deb_h}h "
          result +="au #{fin_l} à #{fin_h}h"
        end
      end
    else
      if self.debut.day == self.fin.day
        # le 18/03/2022 quand y'a pas d'heure et pas de date de fin
        result = "#{deb_l}"
      else
        # du 18/03/2002 au 19/03/2022 quand les dates ne sont pas les mêmes
        result = "#{self.debut.day} - #{self.fin.day} #{I18n.l(self.debut.to_date, format: :month)} #{self.debut.year}"
      end
    end
  end
end
