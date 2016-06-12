class Acform < ActiveRecord::Base
  belongs_to :student
  has_many :activities
  include AASM

  aasm do
    state :open, :initial => true
    state :queue
    state :denied
    state :approved
    state :processed

    event :submit do
      transitions :from => :open, :to => :queue
    end

    event :resubmit do
      transitions :from => :denied, :to => :queue
    end

    event :aprove do
      transitions :from => :queue, :to => :approved
    end

    event :deny do
      transitions :from => :queue, :to => :denied
    end

    event :process do
      transitions :from => :approved, :to => :processed
    end
  end


  def state
    case self.aasm_state
    when "open"
      return "Aberto"
    when "queue"
      return "Aguardando avaliação"
    when "denied"
      return "Reprovado"
    when "approved"
      return "Aprovado"
    when "processed"
      return "Processado pela coordenação"
    else
      return "Inválido"
    end
  end

  def total_hours
    total = 0
    self.activities.each do |activity|
      total += activity.valid_hours
    end
    return total
  end

  def num_cat
    ary = Array.new
    self.activities.each do |activity|
      unless ary.include?(activity.category)
        ary.push(activity.category)
      end
    end
    return ary.size
  end

  def complete?
    if (num_cat >= 3) and (total_hours > 460)
      return true
    else
      return false
    end
  end
end
