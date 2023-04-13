class DecisionMaker
  def initialize(actions, player, opponent)
    @actions = actions
    @player = player
    @opponent = opponent
  end

  def take_action
    @actions.sample
  end
end