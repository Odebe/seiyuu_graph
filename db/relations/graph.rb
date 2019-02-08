# frozen_string_literal: true

module Graphs
  class Relation < ROM::Relation[:sql]
    schema(:graphs, infer: true)
  end
end
