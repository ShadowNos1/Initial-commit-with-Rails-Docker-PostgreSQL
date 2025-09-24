class BmrService
  # patient: Patient instance
  # formula: "mifflin" or "harris"
  def self.calculate(patient, formula)
    weight = patient.weight.to_f
    height = patient.height.to_f
    age = age_from_birthday(patient.birthday)
    gender = patient.gender.to_s.downcase

    value =
      case formula.to_s.downcase
      when "mifflin", "mifflin-st-jeor", "mifflin-stjeor"
        # Mifflin–St Jeor
        base = (10 * weight) + (6.25 * height) - (5 * age)
        base += (gender == "female") ? -161 : 5
        base
      when "harris", "harris-benedict"
        # Revised Harris–Benedict (original formula differs; using common variant)
        if gender == "female"
          655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)
        else
          66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age)
        end
      else
        raise ArgumentError, "Unsupported formula"
      end

    value.round(2)
  end

  def self.age_from_birthday(birthday)
    return 0 unless birthday
    now = Time.zone.now.to_date
    born = birthday.to_date
    age = now.year - born.year
    age -= 1 if (now.month < born.month) || (now.month == born.month && now.day < born.day)
    age
  end
end
