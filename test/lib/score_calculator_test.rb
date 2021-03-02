class ScoreCalculatorTest < Minitest::Test
  def setup
    evaluation = {
      "weapon" => 0.006,
      "alcohol" => 0.01,
      "drugs" => 0.01,
      "nudity" => {
        "raw" => 0.01,
        "safe" => 0.98,
        "partial" => 0.01
      },
      "offensive" => {
        "prob" => 0.01
      }
    }

    @score_calculator = ScoreCalculator.new(evaluation)
  end

  def test_calculate
    assert_in_delta @score_calculator.calculate, 0.02
  end
end
