# frozen_string_literal: true

class GraphRepo < ROM::Repository[:graphs]
  commands :create

  def query(cond)
    graphs.where(cond).to_a
  end

  def all
    graphs.to_a
  end
end
