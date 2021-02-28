class ScoreCalculator
  def initialize(evaluation)
    @evaluation = evaluation
  end

  def calculate
    [
      evaluation['weapon'],
      evaluation['alcohol'],
      evaluation['drugs'],
      (evaluation['nudity']['safe'] - 1).abs,
      evaluation['offensive']['prob']
    ].max
  end

  private

  attr_reader :evaluation
end
