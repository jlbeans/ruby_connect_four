# frozen_string_literal
# renders players
class Player
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end
end
